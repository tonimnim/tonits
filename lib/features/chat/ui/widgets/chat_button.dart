import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n.dart';
import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';

/// The round button to a match's chat, with the opponent's unread count.
class ChatButton extends StatelessWidget {
  const ChatButton({super.key, required this.matchId, this.unread = 0});

  final String matchId;
  final int unread;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    return Semantics(
      label: unread > 0 ? l.chatUnread(unread) : l.chatTitle,
      button: true,
      excludeSemantics: true,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          RoundIconButton(
            icon: Icons.chat_bubble_outline_rounded,
            tooltip: l.chatTitle,
            background: p.card,
            onPressed: () => context.push(Routes.matchChat(matchId)),
          ),
          if (unread > 0)
            Positioned(
              right: -2,
              top: -2,
              child: Container(
                constraints: const BoxConstraints(minWidth: 20),
                height: 20,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: p.destructive,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: p.card, width: 2),
                ),
                child: Text(
                  unread > 99 ? '99+' : '$unread',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
