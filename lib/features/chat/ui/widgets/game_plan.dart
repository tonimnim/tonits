import 'package:flutter/material.dart';

import '../../../../core/format.dart';
import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../application/chat_controller.dart';
import '../../data/match_chat.dart';
import 'chat_bubble.dart';

/// What the chat is for, pinned above it: the Friend Match room code and
/// the kick-off. Each says where it stands and has the button that moves it
/// on, so nothing hides behind a menu.
class GamePlan extends StatelessWidget {
  const GamePlan({
    super.key,
    required this.view,
    required this.opponent,
    required this.now,
    required this.onDropCode,
    required this.onSuggestTime,
  });

  final ChatView view;
  final String opponent;
  final DateTime now;
  final VoidCallback onDropCode;
  final VoidCallback onSuggestTime;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      margin: const EdgeInsets.fromLTRB(
        TonitsSpace.md,
        TonitsSpace.sm,
        TonitsSpace.md,
        0,
      ),
      decoration: BoxDecoration(
        color: p.card,
        borderRadius: BorderRadius.circular(TonitsRadius.card),
      ),
      child: Column(
        children: [
          _roomCode(context),
          const Divider(height: 1, indent: 62),
          _kickOff(context),
        ],
      ),
    );
  }

  Widget _roomCode(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final open = view.chat.open;
    final code = view.chat.roomCode;
    if (code == null) {
      return _Row(
        icon: Icons.vpn_key_rounded,
        label: l.chatRoomCode,
        value: Text(
          l.chatRoomCodeNotShared,
          style: TextStyle(fontSize: 15, color: p.subtleForeground),
        ),
        trailing: open
            ? _SmallButton(label: l.chatDropCode, onPressed: onDropCode)
            : null,
      );
    }
    return _Row(
      icon: Icons.vpn_key_rounded,
      label: l.chatRoomCode,
      value: Text(
        code.code,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: monoFont.copyWith(
          fontSize: 19,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
          color: p.foreground,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CopyPill(value: code.code, what: l.chatRoomCode),
          if (open)
            IconButton(
              tooltip: l.chatNewCode,
              icon: Icon(
                Icons.edit_outlined,
                size: 18,
                color: p.mutedForeground,
              ),
              onPressed: onDropCode,
            ),
        ],
      ),
    );
  }

  Widget _kickOff(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final open = view.chat.open;
    final agreed = view.chat.agreedStartAt;
    final time = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: p.foreground,
    );
    final note = TextStyle(fontSize: 12, color: p.mutedForeground);

    if (agreed != null) {
      return _Row(
        icon: Icons.sports_esports_rounded,
        label: l.chatKickOffSet,
        value: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(Format.dateTime(agreed, l, now: now), style: time),
            Text(l.chatDeadlinesApply, style: note),
          ],
        ),
        trailing: open
            ? TextButton(onPressed: onSuggestTime, child: Text(l.chatChange))
            : null,
      );
    }
    final theirs = view.openProposal;
    if (theirs?.proposedStartAt case final at?) {
      return _Row(
        icon: Icons.schedule_rounded,
        label: l.chatTheyWant(opponent),
        value: Text(Format.dateTime(at, l, now: now), style: time),
      );
    }
    final mine = view.messages
        .where((m) => m.kind == ChatKind.timeProposal)
        .lastOrNull;
    if (mine != null &&
        mine.mine &&
        !view.answered(mine) &&
        mine.proposedStartAt != null) {
      return _Row(
        icon: Icons.schedule_rounded,
        label: l.chatYouSuggested,
        value: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Format.dateTime(mine.proposedStartAt!, l, now: now),
              style: time,
            ),
            Text(l.chatWaitingFor(opponent), style: note),
          ],
        ),
      );
    }
    return _Row(
      icon: Icons.schedule_rounded,
      label: l.chatKickOff,
      value: Text(
        l.chatKickOffNotSet,
        style: TextStyle(fontSize: 15, color: p.subtleForeground),
      ),
      trailing: open
          ? _SmallButton(label: l.chatSuggestTime, onPressed: onSuggestTime)
          : null,
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.icon,
    required this.label,
    required this.value,
    this.trailing,
  });

  final IconData icon;
  final String label;
  final Widget value;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 10, 10),
      child: Row(
        children: [
          IconDot(icon: icon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: p.mutedForeground,
                  ),
                ),
                const SizedBox(height: 2),
                value,
              ],
            ),
          ),
          if (trailing != null) ...[const SizedBox(width: 8), trailing!],
        ],
      ),
    );
  }
}

/// A short solid button for the plan's next step.
class _SmallButton extends StatelessWidget {
  const _SmallButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      // The label's font comes from the theme; naming a text style here
      // would drop it.
      style: FilledButton.styleFrom(
        minimumSize: const Size(0, 38),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
