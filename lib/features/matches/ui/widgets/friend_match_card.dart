import 'package:flutter/material.dart';

import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../data/match_room.dart';
import '../../data/match_summary.dart';

/// How to find the opponent in eFootball and set up the Friend Match:
/// their User ID and in-game name to copy, then the server's steps.
class FriendMatchCard extends StatelessWidget {
  const FriendMatchCard({
    super.key,
    required this.opponent,
    required this.instructions,
    this.series = false,
  });

  final MatchParticipant opponent;
  final List<FriendMatchInstruction> instructions;

  /// A best of 3 or 5, whose disputes need every game's screenshot.
  final bool series;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final account = opponent.gameAccount;

    return Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l.matchFind(opponent.displayName),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
              if (account != null) ...[
                const SizedBox(width: 8),
                Pill(
                  account.platform == 'ios' ? 'iPhone' : 'Android',
                  icon: account.platform == 'ios'
                      ? Icons.phone_iphone
                      : Icons.phone_android,
                ),
              ],
            ],
          ),
          // Only what the player can't see for themselves.
          if (account == null || account.userId == null) ...[
            const SizedBox(height: 4),
            Text(
              account == null ? l.matchNoGameAccount : l.matchNoUserId,
              style: TextStyle(fontSize: 14, color: p.subtleForeground),
            ),
          ],
          if (account != null) ...[
            const SizedBox(height: 16),
            if (account.userId case final id?) ...[
              _CopyField(label: l.matchUserId, value: id, mono: true),
              const SizedBox(height: 10),
            ],
            _CopyField(label: l.matchInGameName, value: account.inGameName),
          ],
          if (series) ...[
            const SizedBox(height: 18),
            _Reminder(text: l.seriesScreenshotReminder),
          ],
          if (instructions.isNotEmpty) ...[
            const SizedBox(height: 22),
            for (final (i, step) in instructions.indexed) ...[
              if (i > 0) const SizedBox(height: 16),
              _Instruction(number: i + 1, step: step),
            ],
          ],
        ],
      ),
    );
  }
}

/// A value on a soft field with a round copy button.
class _CopyField extends StatelessWidget {
  const _CopyField({
    required this.label,
    required this.value,
    this.mono = false,
  });

  final String label;
  final String value;
  final bool mono;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    const valueStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
      decoration: BoxDecoration(
        color: p.muted,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: p.mutedForeground),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: mono ? monoFont.merge(valueStyle) : valueStyle,
                ),
              ],
            ),
          ),
          RoundIconButton(
            icon: Icons.copy_rounded,
            tooltip: context.l10n.matchCopyLabel(label),
            background: p.card,
            onPressed: () => copyToClipboard(context, value, what: label),
          ),
        ],
      ),
    );
  }
}

class _Instruction extends StatelessWidget {
  const _Instruction({required this.number, required this.step});

  final int number;
  final FriendMatchInstruction step;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: p.soft, shape: BoxShape.circle),
          child: Text(
            '$number',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: p.onSoft,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                step.title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 2),
              Text(
                step.detail,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: p.subtleForeground,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// A tip that matters later, such as screenshotting every game.
class _Reminder extends StatelessWidget {
  const _Reminder({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: p.soft,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.photo_camera_outlined, size: 20, color: p.onSoft),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 13, height: 1.4, color: p.onSoft),
            ),
          ),
        ],
      ),
    );
  }
}
