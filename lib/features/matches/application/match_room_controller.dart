import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/error_text.dart';
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

  /// One key per action attempt, kept only to retry it after a dropped
  /// connection, so the server never acts twice.
  final _keys = <MatchAction, String>{};

  Timer? _nextRead;
  AppLifecycleListener? _lifecycle;
  bool _foreground = true;

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
        unawaited(refresh());
      },
      onHide: () {
        _foreground = false;
        _nextRead?.cancel();
      },
    );
    final room = await repository.get(matchId);
    _scheduleRead(room);
    return room;
  }

  /// Reads the room again, keeping the current one on screen meanwhile.
  Future<void> refresh() async {
    _nextRead?.cancel();
    try {
      final room = await _repository.get(matchId);
      if (ref.mounted) _show(room);
    } catch (_) {
      // A failed background read keeps what's shown; the next read retries.
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
    final games = bytesByGame.keys.toList()..sort();
    final evidence = <int, String>{};
    for (final (i, game) in games.indexed) {
      try {
        evidence[game] = await ref
            .read(screenshotUploaderProvider)
            .upload(
              bytesByGame[game]!,
              onStage: (stage) => onProgress?.call(i + 1, games.length, stage),
            );
      } on ScreenshotProblem catch (e) {
        return bytesByGame.length == 1
            ? e.message
            : ref
                  .read(l10nProvider)
                  .matchScreenshotProblemForGame(game, e.message);
      } catch (e) {
        return _describe(e);
      }
      if (!ref.mounted) return null;
    }
    final perGame = state.value?.windows.perGameScreenshots ?? false;
    return _act(
      MatchAction.submitScreenshot,
      (key) => _repository.sendScreenshots(
        matchId,
        evidenceByGame: evidence,
        perGame: perGame,
        key: key,
      ),
    );
  }

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
    Future<MatchRoom> Function(String key) run,
  ) async {
    final key = _keys[action] ??= newUuid();
    try {
      final room = await run(key);
      _keys.remove(action);
      if (ref.mounted) _show(room);
      _refreshLists();
      return null;
    } on NetworkException catch (e) {
      // Keep the key: trying again repeats this same request.
      return describeError(e, ref.read(l10nProvider));
    } on ApiException catch (e) {
      _keys.remove(action);
      // The room moved on (a deadline passed, the opponent acted): show
      // where it is now instead of a stale button.
      if (e.status == 409 && ref.mounted) await refresh();
      return _describe(e);
    }
  }

  void _show(MatchRoom room) {
    state = AsyncData(room);
    _scheduleRead(room);
  }

  void _scheduleRead(MatchRoom? room) {
    _nextRead?.cancel();
    if (room == null || !_foreground || !_isLive(room.lifecycle)) return;
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
      waitingOnOthers ? intervals.fast : intervals.slow,
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

  String _describe(Object error) {
    final l = ref.read(l10nProvider);
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
        case 'match_changed':
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
