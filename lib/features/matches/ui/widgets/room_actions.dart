import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n.dart';
import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../evidence/application/screenshot_uploader.dart';
import '../../application/match_room_controller.dart';
import '../../application/matches_providers.dart';
import '../../data/match_room.dart';
import '../room_status.dart';
import 'deadline_pill.dart';
import 'series_screenshots.dart';

/// Right under the score: where the match stands in one line, the time
/// left, and the action the server allows now.
class RoomActions extends ConsumerStatefulWidget {
  const RoomActions({super.key, required this.room});

  final MatchRoom room;

  @override
  ConsumerState<RoomActions> createState() => _RoomActionsState();
}

class _RoomActionsState extends ConsumerState<RoomActions> with BusyState {
  UploadStage? _stage;

  MatchRoom get room => widget.room;
  MatchRoomController get _controller =>
      ref.read(matchRoomProvider(room.id).notifier);

  Future<void> _run(Future<String?> Function() action) async {
    await runForMessage(action);
    if (mounted) setState(() => _stage = null);
  }

  Future<void> _decline() async {
    final l = context.l10n;
    final opponent = room.summary.opponent?.displayName ?? l.matchYourOpponent;
    final confirmed = await confirmAction(
      context,
      title: l.matchRejectTitle,
      message: l.matchRejectMessage(
        opponent,
        room.windows.screenshot.inMinutes,
      ),
      confirmLabel: l.roomDecline,
    );
    if (confirmed) await _run(() => _controller.answer(confirm: false));
  }

  Future<void> _sendScreenshot() async {
    final bytes = await ref.read(screenshotPickerProvider)();
    if (bytes == null || !mounted) return;
    await _run(
      () => _controller.sendScreenshot(
        bytes,
        onStage: (stage) {
          if (mounted) setState(() => _stage = stage);
        },
      ),
    );
  }

  Future<void> _openScreenshots() => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (sheet) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          TonitsSpace.lg,
          0,
          TonitsSpace.lg,
          TonitsSpace.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              sheet.l10n.roomScreenshotsTitle,
              style: Theme.of(sheet).textTheme.headlineSmall,
            ),
            const SizedBox(height: TonitsSpace.md),
            SeriesScreenshots(
              room: room,
              onSent: () => Navigator.of(sheet).pop(),
            ),
          ],
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final status = RoomStatus.of(room, l);
    final color = switch (status.tone) {
      RoomTone.won => p.good.$1,
      RoomTone.bad => p.destructive,
      _ => p.foreground,
    };
    final actions = _actions(l);

    return Semantics(
      liveRegion: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            status.text,
            textAlign: TextAlign.center,
            style: status.outcome
                ? TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.6,
                    color: color,
                  )
                : TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
          ),
          if (status.deadline != null) ...[
            const SizedBox(height: 10),
            Center(
              child: DeadlinePill(
                deadline: status.deadline!,
                showClockTime: false,
                filled: p.card,
              ),
            ),
          ],
          if (status.note != null) ...[
            const SizedBox(height: 8),
            Text(
              status.note!,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: p.subtleForeground),
            ),
          ],
          if (actions.isNotEmpty) ...[const SizedBox(height: 20), ...actions],
          if (_stage != null) ...[
            const SizedBox(height: 10),
            Text(
              _stage == UploadStage.uploading
                  ? l.matchUploadingScreenshot
                  : l.matchCheckingScreenshot,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: p.mutedForeground),
            ),
          ],
          if (error != null) ...[
            const SizedBox(height: TonitsSpace.md),
            Notice(error!),
          ],
        ],
      ),
    );
  }

  List<Widget> _actions(AppLocalizations l) {
    final p = context.palette;
    if (room.can(MatchAction.checkIn)) {
      return [
        PrimaryButton(
          label: l.matchCheckIn,
          busy: busy,
          onPressed: () => _run(_controller.checkIn),
        ),
      ];
    }
    if (room.can(MatchAction.reportScore)) {
      return [
        PrimaryButton(
          label: l.matchReportScore,
          onPressed: () => context.push(Routes.reportScore(room.id)),
        ),
      ];
    }
    if (room.can(MatchAction.confirmResult)) {
      return [
        Row(
          children: [
            if (room.can(MatchAction.rejectResult)) ...[
              Expanded(
                child: SecondaryButton(
                  label: l.roomDecline,
                  background: p.card,
                  onPressed: busy ? null : _decline,
                ),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: PrimaryButton(
                label: l.roomAccept,
                busy: busy,
                onPressed: () => _run(() => _controller.answer(confirm: true)),
              ),
            ),
          ],
        ),
      ];
    }
    if (room.can(MatchAction.submitScreenshot)) {
      return [
        PrimaryButton(
          label: room.windows.perGameScreenshots
              ? l.roomSendScreenshotsButton
              : l.roomSendScreenshotButton,
          busy: busy,
          onPressed: room.windows.perGameScreenshots
              ? _openScreenshots
              : _sendScreenshot,
        ),
      ];
    }
    return const [];
  }
}
