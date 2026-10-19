import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/error_text.dart';
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

  Future<String?> reportScore(Score score) => _act(
    MatchAction.reportScore,
    (key) => _repository.reportScore(matchId, score: score, key: key),
  );

  Future<String?> answer({required bool confirm}) => _act(
    confirm ? MatchAction.confirmResult : MatchAction.rejectResult,
    (key) => _repository.answer(matchId, confirm: confirm, key: key),
  );

  /// Uploads and verifies [bytes], then sends it as this side's screenshot.
  Future<String?> sendScreenshot(
    Uint8List bytes, {
    void Function(UploadStage stage)? onStage,
  }) async {
    final String evidenceId;
    try {
      evidenceId = await ref
          .read(screenshotUploaderProvider)
          .upload(bytes, onStage: onStage);
    } on ScreenshotProblem catch (e) {
      return e.message;
    } catch (e) {
      return _describe(e);
    }
    if (!ref.mounted) return null;
    return _act(
      MatchAction.submitScreenshot,
      (key) =>
          _repository.sendScreenshot(matchId, evidenceId: evidenceId, key: key),
    );
  }

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
      return describeError(e);
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

  static String _describe(Object error) {
    if (error is ApiException) {
      switch (error.code) {
        case 'result_awaiting_confirmation':
          return 'Your opponent already reported the result. Confirm or '
              'reject it instead.';
        case 'result_already_submitted':
          return 'Your side already reported the result.';
        case 'report_window_closed' ||
            'confirmation_window_closed' ||
            'screenshot_window_closed':
          return 'The time for that has passed.';
        case 'invalid_score':
          return "That score doesn't fit this match's format.";
        case 'match_changed':
          return 'The match changed. Check the latest and try again.';
        case 'competition_closed':
          return 'This competition has ended.';
        case 'evidence_rate_limited':
          return 'Too many uploads. Wait a moment and try again.';
      }
    }
    return describeError(error);
  }
}
