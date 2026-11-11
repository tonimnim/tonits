import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/error_text.dart';
import '../../../core/api/poll_backoff.dart';
import '../../../core/l10n.dart';
import '../../evidence/application/evidence_providers.dart';
import '../../evidence/application/screenshot_uploader.dart';
import '../data/match_room.dart';
import '../data/match_room_repository.dart';
import '../data/match_summary.dart';
import 'matches_providers.dart';

/// One match room: reads it, runs the player's actions, and keeps it fresh
/// while the match is live. What the player may do always comes from the
/// server's lifecycle and allowed actions, never from a local clock.
class MatchRoomController extends AsyncNotifier<MatchRoom> {
  MatchRoomController(this.matchId);

  final String matchId;

  /// One key per action attempt, kept only to retry that same request after
  /// a dropped connection, so the server never acts twice. A changed request
  /// (a corrected score, another screenshot) gets a new key: reusing one for
  /// a different body is refused.
  final _keys = <MatchAction, ({String payload, String key})>{};

  /// Screenshots already uploaded and verified, by game, so a retry after a
  /// failed send reuses them instead of uploading every game again.
  final _uploaded = <int, ({Uint8List bytes, String evidenceId})>{};

  Timer? _nextRead;
  AppLifecycleListener? _lifecycle;
  bool _foreground = true;
  bool _paused = false;

  /// Waits longer between reads while they fail.
  final _backoff = PollBackoff();

  MatchRoomRepository get _repository => ref.read(matchRoomRepositoryProvider);

  @override
  Future<MatchRoom> build() async {
    final repository = ref.watch(matchRoomRepositoryProvider);
    ref.onDispose(() {
      _nextRead?.cancel();
      _lifecycle?.dispose();
      _lifecycle = null;
    });
    // Pause while the app is in the background; catch up on return.
    _lifecycle ??= AppLifecycleListener(
      onShow: () {
        _foreground = true;
        if (!_paused) unawaited(refresh());
      },
      onHide: () {
        _foreground = false;
        _nextRead?.cancel();
      },
    );
    // Off screen (another tab, or a screen on top) Riverpod pauses this
    // provider, but a timer of our own would keep firing: stop reading until
    // it is shown again, then catch up at once.
    ref
      ..onCancel(() {
        _paused = true;
        _nextRead?.cancel();
      })
      ..onResume(() {
        _paused = false;
        // Not from inside the life-cycle callback, where ref can't be used.
        scheduleMicrotask(() {
          if (ref.mounted && _foreground) unawaited(refresh());
        });
      });
    final room = await repository.get(matchId);
    _scheduleRead(room);
    return room;
  }

  /// Reads the room again, keeping the current one on screen meanwhile.
  Future<void> refresh() async {
    _nextRead?.cancel();
    try {
      final room = await _repository.get(matchId);
      _backoff.succeeded();
      if (ref.mounted) _show(room);
    } catch (e) {
      // A failed background read keeps what's shown; the next read
      // retries, later each time.
      _backoff.failed(e);
      if (ref.mounted) _scheduleRead(state.value);
    }
  }

  Future<String?> checkIn() => _act(
    MatchAction.checkIn,
    (key) => _repository.checkIn(matchId, key: key),
  );

  /// Goals for a best of 1, games won for a series.
  Future<String?> reportScore(Score score) => _act(
    MatchAction.reportScore,
    (key) => _repository.reportScore(matchId, score: score, key: key),
    payload: '$score',
  );

  Future<String?> answer({required bool confirm}) => _act(
    confirm ? MatchAction.confirmResult : MatchAction.rejectResult,
    (key) => _repository.answer(matchId, confirm: confirm, key: key),
  );

  /// Uploads and verifies each game's screenshot, then sends them together
  /// as this side's screenshots. [onProgress] reports which game is being
  /// uploaded (1-based count) and at what stage.
  Future<String?> sendScreenshots(
    Map<int, Uint8List> bytesByGame, {
    void Function(int done, int total, UploadStage stage)? onProgress,
  }) async {
    final l = ref.read(l10nProvider);
    // Finish even if the player leaves the room meanwhile: verifying can take
    // a while, and in a dispute an upload that never gets sent forfeits.
    final alive = ref.keepAlive();
    try {
      final games = bytesByGame.keys.toList()..sort();
      final evidence = <int, String>{};
      for (final (i, game) in games.indexed) {
        final bytes = bytesByGame[game]!;
        final done = _uploaded[game];
        if (done != null && _same(done.bytes, bytes)) {
          evidence[game] = done.evidenceId;
          continue;
        }
        try {
          final evidenceId = await ref
              .read(screenshotUploaderProvider)
              .upload(
                bytes,
                onStage: (stage) =>
                    onProgress?.call(i + 1, games.length, stage),
              );
          _uploaded[game] = (bytes: bytes, evidenceId: evidenceId);
          evidence[game] = evidenceId;
        } on ScreenshotProblem catch (e) {
          return bytesByGame.length == 1
              ? e.message
              : l.matchScreenshotProblemForGame(game, e.message);
        } catch (e) {
          return _describe(e, l);
        }
        if (!ref.mounted) return l.matchErrorMatchChanged;
      }
      final perGame = state.value?.windows.perGameScreenshots ?? false;
      final problem = await _act(
        MatchAction.submitScreenshot,
        (key) => _repository.sendScreenshots(
          matchId,
          evidenceByGame: evidence,
          perGame: perGame,
          key: key,
        ),
        payload: [for (final game in games) '$game:${evidence[game]}']
            .join(','),
      );
      if (problem == null) _uploaded.clear();
      return problem;
    } finally {
      alive.close();
    }
  }

  /// The same picture: the very bytes, or the same file picked again.
  static bool _same(Uint8List a, Uint8List b) =>
      identical(a, b) ||
      (a.lengthInBytes == b.lengthInBytes && listEquals(a, b));

  /// A best of 1's one screenshot.
  Future<String?> sendScreenshot(
    Uint8List bytes, {
    void Function(UploadStage stage)? onStage,
  }) => sendScreenshots({
    1: bytes,
  }, onProgress: onStage == null ? null : (_, _, stage) => onStage(stage));

  /// Runs one action and shows the room it returns. Returns a message for
  /// the player when it failed, or null.
  Future<String?> _act(
    MatchAction action,
    Future<MatchRoom> Function(String key) run, {
    String payload = '',
  }) async {
    final l = ref.read(l10nProvider);
    final held = _keys[action];
    final key = held != null && held.payload == payload ? held.key : newUuid();
    _keys[action] = (payload: payload, key: key);
    // The action finishes even if the player leaves the room meanwhile.
    final alive = ref.keepAlive();
    try {
      final room = await run(key);
      _keys.remove(action);
      if (ref.mounted) {
        _show(room);
        _refreshLists();
      }
      return null;
    } on NetworkException catch (e) {
      // Keep the key: trying again repeats this same request.
      return describeError(e, l);
    } on ApiException catch (e) {
      // A server error or a rate limit may have acted anyway or will let a
      // retry through: keep the key for that. Any other answer is final.
      if (e.status < 500 && e.status != 429) _keys.remove(action);
      if (e.code == 'invalid_evidence') _uploaded.clear();
      // The room moved on (a deadline passed, the opponent acted): show
      // where it is now instead of a stale button.
      if (e.status == 409 && ref.mounted) await refresh();
      return _describe(e, l);
    } finally {
      alive.close();
    }
  }

  void _show(MatchRoom room) {
    state = AsyncData(room);
    _scheduleRead(room);
  }

  void _scheduleRead(MatchRoom? room) {
    _nextRead?.cancel();
    if (room == null ||
        !_foreground ||
        _paused ||
        _backoff.stopped ||
        !_isLive(room.lifecycle)) {
      return;
    }
    final intervals = ref.read(matchRoomPollIntervalsProvider);
    final waitingOnOthers = switch (room.lifecycle) {
      MatchLifecycle.checkedIn ||
      MatchLifecycle.awaitingOpponentConfirmation ||
      MatchLifecycle.awaitingOpponentScreenshot ||
      MatchLifecycle.awaitingResolution ||
      MatchLifecycle.reportRequired => true,
      _ => false,
    };
    _nextRead = Timer(
      _backoff.next(waitingOnOthers ? intervals.fast : intervals.slow),
      refresh,
    );
  }

  static bool _isLive(MatchLifecycle lifecycle) =>
      !lifecycle.isOver &&
      lifecycle != MatchLifecycle.outOfCompetition &&
      lifecycle != MatchLifecycle.unknown;

  /// Lists that show this match's state elsewhere in the app.
  void _refreshLists() {
    ref.invalidate(myMatchesProvider);
    ref.invalidate(nextMatchProvider);
  }

  static String _describe(Object error, AppLocalizations l) {
    if (error is ApiException) {
      switch (error.code) {
        case 'result_awaiting_confirmation':
          return l.matchErrorOpponentAlreadyReported;
        case 'result_already_submitted':
          return l.matchErrorAlreadySubmitted;
        case 'report_window_closed' ||
            'confirmation_window_closed' ||
            'screenshot_window_closed':
          return l.matchErrorWindowClosed;
        // The server says exactly what doesn't fit, such as a game a
        // decided series didn't need.
        case 'invalid_score' || 'invalid_evidence':
          return error.message.isNotEmpty
              ? error.message
              : l.matchErrorInvalidScore;
        // A retry that no longer matches what was first sent: the room is
        // read again above, so it now shows where things stand.
        case 'match_changed' || 'idempotency_conflict':
          return l.matchErrorMatchChanged;
        case 'competition_closed':
          return l.matchErrorCompetitionClosed;
        case 'evidence_rate_limited':
          return l.matchErrorEvidenceRateLimited;
      }
    }
    return describeError(error, l);
  }
}
