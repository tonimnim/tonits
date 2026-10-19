import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/format.dart';
import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../application/chat_controller.dart';
import '../../data/match_chat.dart';

/// When a message was sent: just the time today, the day too otherwise.
String chatClock(DateTime sentAt, AppLocalizations l, {required DateTime now}) {
  final local = sentAt.toLocal();
  final today = now.toLocal();
  final sameDay =
      local.year == today.year &&
      local.month == today.month &&
      local.day == today.day;
  return sameDay
      ? DateFormat.Hm().format(local)
      : Format.dateTime(sentAt, l, now: now);
}

/// A quick reply in the player's language.
String quickReplyText(QuickReply reply, AppLocalizations l) => switch (reply) {
  QuickReply.readyNow => l.chatQuickReadyNow,
  QuickReply.fiveMinutes => l.chatQuickFiveMinutes,
  QuickReply.tenMinutes => l.chatQuickTenMinutes,
  QuickReply.friendRequestSent => l.chatQuickFriendRequestSent,
  QuickReply.roomCreated => l.chatQuickRoomCreated,
  QuickReply.goodGame => l.chatQuickGoodGame,
};

final _compact = ButtonStyle(
  minimumSize: const WidgetStatePropertyAll(Size(0, 40)),
  padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 18)),
  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
);

/// One message: a bubble on the player's side (right) or the opponent's
/// (left). A time answer is a line in the middle instead.
class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.view,
    required this.opponent,
    required this.now,
    this.showTime = false,
    this.seen = false,
    this.onAnswer,
    this.onReport,
  });

  final ChatMessage message;
  final ChatView view;
  final String opponent;
  final DateTime now;

  /// The last of a run from one side carries the time.
  final bool showTime;

  /// The opponent has read up to here: the player's latest message says so.
  final bool seen;

  /// Answers the opponent's open proposal; null when there's none to answer.
  final void Function({required bool accepted})? onAnswer;

  /// Reports the opponent's message, on a long press.
  final VoidCallback? onReport;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    if (message.kind == ChatKind.timeAnswer) return _answerLine(context);

    final mine = message.mine;
    final caption = [
      if (showTime) chatClock(message.sentAt, l, now: now),
      if (seen) l.chatSeen,
    ].join(' · ');

    return Column(
      crossAxisAlignment: mine
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onLongPress: onReport,
          child: BubbleShape(mine: mine, child: _content(context)),
        ),
        if (message.contactHidden) ...[
          const SizedBox(height: 4),
          Text(
            l.chatContactHidden,
            style: TextStyle(fontSize: 11, color: p.mutedForeground),
          ),
        ],
        if (caption.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            caption,
            style: TextStyle(fontSize: 11, color: p.mutedForeground),
          ),
        ],
      ],
    );
  }

  Widget _content(BuildContext context) {
    final l = context.l10n;
    final text = bubbleTextStyle(context, mine: message.mine);
    return switch (message.kind) {
      ChatKind.text => Text(message.text ?? '', style: text),
      ChatKind.quickReply => Text(
        message.quickReply == null
            ? ''
            : quickReplyText(message.quickReply!, l),
        style: text,
      ),
      ChatKind.roomCode => RoomCodeContent(
        code: message.roomCode ?? '',
        mine: message.mine,
      ),
      ChatKind.timeProposal => _proposal(context),
      _ => Text(message.text ?? '', style: text),
    };
  }

  Widget _proposal(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final mine = message.mine;
    final at = message.proposedStartAt;
    final answer = view.messages
        .where(
          (m) => m.kind == ChatKind.timeAnswer && m.replyToSeq == message.seq,
        )
        .firstOrNull;
    final label = TextStyle(
      fontSize: 12,
      color: mine ? p.onPrimary.withValues(alpha: 0.8) : p.mutedForeground,
    );
    final status = switch (answer?.accepted) {
      true => l.chatAccepted,
      false => l.chatDeclined,
      null when mine => l.chatWaitingFor(opponent),
      null => null,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(l.chatKickOffAt, style: label),
        Text(
          at == null ? '' : Format.dateTime(at, l, now: now),
          style: bubbleTextStyle(
            context,
            mine: mine,
          ).copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        if (onAnswer != null) ...[
          const SizedBox(height: 10),
          // Compact, and wrapping rather than overflowing a narrow bubble.
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton(
                style: _compact,
                onPressed: () => onAnswer!(accepted: false),
                child: Text(l.chatDecline),
              ),
              FilledButton(
                style: _compact,
                onPressed: () => onAnswer!(accepted: true),
                child: Text(l.chatAccept),
              ),
            ],
          ),
        ] else if (status != null) ...[
          const SizedBox(height: 4),
          Text(status, style: label),
        ],
      ],
    );
  }

  /// The proposal above already shows the time; this says how it went.
  Widget _answerLine(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final accepted = message.accepted ?? false;
    final text = accepted
        ? l.chatTimeAgreed
        : message.mine
        ? l.chatYouDeclinedTime
        : l.chatTheyDeclinedTime(opponent);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Pill(
          text,
          icon: accepted ? Icons.check : Icons.close,
          color: accepted ? p.good.$1 : p.subtleForeground,
        ),
      ),
    );
  }
}

/// A message the server hasn't numbered yet, faded, or marked when it
/// didn't go.
class PendingBubble extends StatelessWidget {
  const PendingBubble({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final PendingMessage message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final style = bubbleTextStyle(context, mine: true);
    final content = switch (message.draft) {
      TextDraft(:final text) => Text(text, style: style),
      QuickReplyDraft(:final reply) => Text(
        quickReplyText(reply, l),
        style: style,
      ),
      RoomCodeDraft(:final code) => RoomCodeContent(code: code, mine: true),
      TimeProposalDraft(:final startAt) => Text(
        '${l.chatKickOffAt} ${Format.dateTime(startAt, l)}',
        style: style,
      ),
      TimeAnswerDraft() => const SizedBox.shrink(),
    };
    if (message.draft is TimeAnswerDraft && !message.failed) {
      return const SizedBox.shrink();
    }
    return GestureDetector(
      onTap: message.failed ? onRetry : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Opacity(
            opacity: message.failed ? 1 : 0.6,
            child: BubbleShape(mine: true, child: content),
          ),
          const SizedBox(height: 4),
          Text(
            message.failed ? l.chatNotSent : l.chatSending,
            style: TextStyle(
              fontSize: 11,
              color: message.failed ? p.destructive : p.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }
}

/// The text colour on a bubble: light on the player's, dark on the
/// opponent's.
TextStyle bubbleTextStyle(BuildContext context, {required bool mine}) {
  final p = context.palette;
  return TextStyle(
    fontSize: 15,
    height: 1.35,
    color: mine ? p.onPrimary : p.foreground,
  );
}

/// The rounded bubble, its corner nearest the sender tucked in.
class BubbleShape extends StatelessWidget {
  const BubbleShape({super.key, required this.mine, required this.child});

  final bool mine;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    const round = Radius.circular(20);
    const tucked = Radius.circular(6);
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width * 0.78,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: mine ? p.primary : p.card,
          borderRadius: BorderRadius.only(
            topLeft: round,
            topRight: round,
            bottomLeft: mine ? round : tucked,
            bottomRight: mine ? tucked : round,
          ),
        ),
        child: child,
      ),
    );
  }
}

/// A shared room code, large and tappable to copy.
class RoomCodeContent extends StatelessWidget {
  const RoomCodeContent({super.key, required this.code, required this.mine});

  final String code;
  final bool mine;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final color = mine ? p.onPrimary : p.foreground;
    return InkWell(
      onTap: () => copyToClipboard(context, code, what: l.chatRoomCode),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l.chatRoomCode,
            style: TextStyle(
              fontSize: 12,
              color: mine
                  ? p.onPrimary.withValues(alpha: 0.8)
                  : p.mutedForeground,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  code,
                  style: monoFont.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.copy_rounded, size: 16, color: color),
            ],
          ),
        ],
      ),
    );
  }
}
