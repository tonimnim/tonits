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
import '../next_step.dart';
import 'deadline_pill.dart';

/// The room's main panel: where the match stands, what's next and by when,
/// and the action the server allows now.
class NextStepPanel extends ConsumerStatefulWidget {
  const NextStepPanel({super.key, required this.room});

  final MatchRoom room;

  @override
  ConsumerState<NextStepPanel> createState() => _NextStepPanelState();
}

class _NextStepPanelState extends ConsumerState<NextStepPanel> with BusyState {
  UploadStage? _stage;

  MatchRoom get room => widget.room;
  MatchRoomController get _controller =>
      ref.read(matchRoomProvider(room.id).notifier);
  String get _opponent =>
      room.summary.opponent?.displayName ?? context.l10n.matchYourOpponent;

  Future<void> _run(Future<String?> Function() action) async {
    await runForMessage(action);
    if (mounted) setState(() => _stage = null);
  }

  Future<void> _reject() async {
    final l = context.l10n;
    final minutes = room.windows.screenshot.inMinutes;
    final confirmed = await confirmAction(
      context,
      title: l.matchRejectTitle,
      message: l.matchRejectMessage(_opponent, minutes),
      confirmLabel: l.matchReject,
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

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final step = NextStep.of(room, l);
    final (label, color) = switch (step.tone) {
      StepTone.action => (l.matchToneYourMove, p.primary),
      StepTone.waiting => (l.matchToneWaiting, p.info.$1),
      StepTone.won => (l.matchToneFinal, p.good.$1),
      StepTone.neutral => (l.matchToneFinal, p.subtleForeground),
      StepTone.bad => (l.matchToneFinal, p.destructive),
    };

    return Panel(
      child: Semantics(
        liveRegion: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Pill(label, color: color),
            ),
            const SizedBox(height: 14),
            Text(
              step.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.4,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              step.message,
              style: TextStyle(
                fontSize: 15,
                height: 1.45,
                color: p.subtleForeground,
              ),
            ),
            if (step.deadline != null) ...[
              const SizedBox(height: 18),
              DeadlinePill(deadline: step.deadline!),
              if (step.deadlineNote != null) ...[
                const SizedBox(height: 10),
                Text(
                  step.deadlineNote!,
                  style: TextStyle(fontSize: 13, color: p.mutedForeground),
                ),
              ],
            ],
            ..._actions(),
            if (_stage != null) ...[
              const SizedBox(height: 12),
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
      ),
    );
  }

  List<Widget> _actions() {
    final l = context.l10n;
    const gap = SizedBox(height: 22);
    if (room.can(MatchAction.checkIn)) {
      return [
        gap,
        PrimaryButton(
          label: l.matchCheckIn,
          busy: busy,
          onPressed: () => _run(_controller.checkIn),
        ),
      ];
    }
    if (room.can(MatchAction.reportScore)) {
      return [
        gap,
        PrimaryButton(
          label: l.matchReportScore,
          onPressed: () => context.push(Routes.reportScore(room.id)),
        ),
      ];
    }
    if (room.can(MatchAction.confirmResult)) {
      return [
        gap,
        PrimaryButton(
          label: l.matchConfirmYes,
          busy: busy,
          onPressed: () => _run(() => _controller.answer(confirm: true)),
        ),
        if (room.can(MatchAction.rejectResult)) ...[
          const SizedBox(height: TonitsSpace.sm),
          SecondaryButton(
            label: l.matchConfirmNo,
            onPressed: busy ? null : _reject,
          ),
        ],
      ];
    }
    if (room.can(MatchAction.submitScreenshot)) {
      return [
        gap,
        PrimaryButton(
          label: l.matchChooseScreenshot,
          busy: busy,
          onPressed: _sendScreenshot,
        ),
      ];
    }
    return const [];
  }
}
