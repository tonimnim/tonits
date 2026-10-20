import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/format.dart';
import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../application/chat_controller.dart';
import '../../data/match_chat.dart';

/// A quick reply in the player's words.
String quickReplyText(QuickReply reply, AppLocalizations l) => switch (reply) {
  QuickReply.readyNow => l.chatQuickReadyNow,
  QuickReply.fiveMinutes => l.chatQuickFiveMinutes,
  QuickReply.tenMinutes => l.chatQuickTenMinutes,
  QuickReply.friendRequestSent => l.chatQuickFriendRequestSent,
  QuickReply.roomCreated => l.chatQuickRoomCreated,
  QuickReply.goodGame => l.chatQuickGoodGame,
};

/// "Today", "Yesterday", or the date, between days of messages.
String chatDay(DateTime at, AppLocalizations l, {required DateTime now}) {
  final day = DateUtils.dateOnly(at.toLocal());
  final today = DateUtils.dateOnly(now.toLocal());
  final days = today.difference(day).inDays;
  if (days == 0) return l.chatToday;
  if (days == 1) return l.chatYesterday;
  return Format.date(at, now: now);
}

/// A day's first message carries a centred day label above it.
class ChatDaySeparator extends StatelessWidget {
  const ChatDaySeparator(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: dark ? p.card : p.muted,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: p.subtleForeground,
          ),
        ),
      ),
    );
  }
}

/// One message: a bubble on the player's side (right) or the opponent's
/// (left), with its time and, on the player's, a tick (two once seen). A
/// time answer is a line in the middle instead.
class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.view,
    required this.opponent,
    required this.now,
    this.seen = false,
    this.onAnswer,
    this.onReport,
  });

  final ChatMessage message;
  final ChatView view;
  final String opponent;
  final DateTime now;

  /// The opponent has read it.
  final bool seen;

  /// Answers the opponent's open suggestion; null when there's none to
  /// answer.
  final void Function({required bool accepted})? onAnswer;

  /// Reports the opponent's message, on a long press.
  final VoidCallback? onReport;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    if (message.kind == ChatKind.timeAnswer) return _answerLine(context);

    return Column(
      crossAxisAlignment: message.mine
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onLongPress: onReport,
          child: BubbleShape(
            mine: message.mine,
            child: BubbleBody(
              mine: message.mine,
              meta: _Meta(
                time: message.sentAt,
                mine: message.mine,
                tick: message.mine ? (seen ? _Tick.seen : _Tick.sent) : null,
              ),
              child: _content(context),
            ),
          ),
        ),
        if (message.contactHidden) ...[
          const SizedBox(height: 4),
          Text(
            l.chatContactHidden,
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
      ChatKind.timeProposal => _suggestion(context),
      _ => Text(message.text ?? '', style: text),
    };
  }

  Widget _suggestion(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final mine = message.mine;
    final at = message.proposedStartAt;
    final answer = view.messages
        .where(
          (m) => m.kind == ChatKind.timeAnswer && m.replyToSeq == message.seq,
        )
        .firstOrNull;
    final soft = mine ? p.onPrimary.withValues(alpha: 0.8) : p.mutedForeground;
    final status = switch (answer?.accepted) {
      true => l.chatAccepted,
      false => l.chatNotThen,
      null when mine => l.chatWaitingFor(opponent),
      null => null,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _Label(icon: Icons.schedule_rounded, text: l.chatPlayAt, color: soft),
        const SizedBox(height: 2),
        Text(
          at == null ? '' : Format.dateTime(at, l, now: now),
          style: bubbleTextStyle(
            context,
            mine: mine,
          ).copyWith(fontSize: 18, fontWeight: FontWeight.w700),
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
                child: Text(l.chatNotThen),
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
          Text(
            status,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: soft,
            ),
          ),
        ],
      ],
    );
  }

  /// How a suggestion went, in the middle of the conversation.
  Widget _answerLine(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final accepted = message.accepted ?? false;
    final suggestion = view.messages
        .where((m) => m.seq == message.replyToSeq)
        .firstOrNull;
    final at = suggestion?.proposedStartAt;
    final text = accepted
        ? [
            l.chatKickOffSet,
            if (at != null) Format.dateTime(at, l, now: now),
          ].join(' · ')
        : message.mine
        ? l.chatYouSaidNo
        : l.chatTheySaidNo(opponent);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Pill(
          text,
          icon: accepted ? Icons.check_rounded : Icons.close_rounded,
          color: accepted ? p.good.$1 : p.subtleForeground,
        ),
      ),
    );
  }
}

final _compact = ButtonStyle(
  minimumSize: const WidgetStatePropertyAll(Size(0, 40)),
  padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 18)),
  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
);

/// A message the server hasn't numbered yet, with a clock, or marked when
/// it didn't go.
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
    final Widget content = switch (message.draft) {
      TextDraft(:final text) => Text(text, style: style),
      QuickReplyDraft(:final reply) => Text(
        quickReplyText(reply, l),
        style: style,
      ),
      RoomCodeDraft(:final code) => RoomCodeContent(code: code, mine: true),
      TimeProposalDraft(:final startAt) => Text(
        '${l.chatPlayAt} ${Format.dateTime(startAt, l)}',
        style: style,
      ),
      TimeAnswerDraft() => const SizedBox.shrink(),
    };
    if (message.draft is TimeAnswerDraft) return const SizedBox.shrink();
    return GestureDetector(
      onTap: message.failed ? onRetry : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Opacity(
            opacity: message.failed ? 1 : 0.75,
            child: BubbleShape(
              mine: true,
              child: BubbleBody(
                mine: true,
                meta: _Meta(
                  mine: true,
                  tick: message.failed ? _Tick.failed : _Tick.sending,
                ),
                child: content,
              ),
            ),
          ),
          if (message.failed) ...[
            const SizedBox(height: 4),
            Text(
              l.chatNotSent,
              style: TextStyle(fontSize: 12, color: p.destructive),
            ),
          ],
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
        padding: const EdgeInsets.fromLTRB(14, 9, 12, 7),
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

/// A bubble's content with its time (and tick) in the bottom corner: on
/// the same line when there's room, as in the chat apps players know.
class BubbleBody extends StatelessWidget {
  const BubbleBody({
    super.key,
    required this.mine,
    required this.meta,
    required this.child,
  });

  final bool mine;
  final Widget meta;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.end,
      crossAxisAlignment: WrapCrossAlignment.end,
      spacing: 10,
      runSpacing: 2,
      children: [child, meta],
    );
  }
}

enum _Tick { sending, sent, seen, failed }

/// The time, and on the player's own message where it stands.
class _Meta extends StatelessWidget {
  const _Meta({required this.mine, this.time, this.tick});

  final bool mine;
  final DateTime? time;
  final _Tick? tick;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final color = mine
        ? p.onPrimary.withValues(alpha: 0.75)
        : p.mutedForeground;
    final (icon, label) = switch (tick) {
      _Tick.sending => (Icons.schedule_rounded, l.chatSending),
      _Tick.sent => (Icons.done_rounded, l.chatSent),
      _Tick.seen => (Icons.done_all_rounded, l.chatSeen),
      _Tick.failed => (Icons.error_outline_rounded, l.chatNotSent),
      null => (null, null),
    };
    return Padding(
      padding: const EdgeInsets.only(bottom: 1),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (time != null)
            Text(
              DateFormat.Hm().format(time!.toLocal()),
              style: TextStyle(fontSize: 11, color: color),
            ),
          if (icon != null) ...[
            const SizedBox(width: 3),
            Icon(
              icon,
              size: 15,
              semanticLabel: label,
              color: tick == _Tick.seen
                  ? p.onPrimary
                  : tick == _Tick.failed
                  ? p.onPrimary
                  : color,
            ),
          ],
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({required this.icon, required this.text, required this.color});

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 15, color: color),
      const SizedBox(width: 5),
      Text(text, style: TextStyle(fontSize: 12, color: color)),
    ],
  );
}

/// A shared room code, big, with a Copy button.
class RoomCodeContent extends StatelessWidget {
  const RoomCodeContent({super.key, required this.code, required this.mine});

  final String code;
  final bool mine;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final color = mine ? p.onPrimary : p.foreground;
    final soft = mine ? p.onPrimary.withValues(alpha: 0.8) : p.mutedForeground;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _Label(icon: Icons.vpn_key_rounded, text: l.chatRoomCode, color: soft),
        const SizedBox(height: 2),
        Text(
          code,
          style: monoFont.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
            color: color,
          ),
        ),
        const SizedBox(height: 8),
        CopyPill(value: code, what: l.chatRoomCode, onPrimary: mine),
      ],
    );
  }
}

/// A small "Copy" button.
class CopyPill extends StatelessWidget {
  const CopyPill({
    super.key,
    required this.value,
    required this.what,
    this.onPrimary = false,
  });

  final String value;

  /// What's copied, for the confirmation.
  final String what;

  /// On the player's own indigo bubble.
  final bool onPrimary;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final fg = onPrimary ? p.onPrimary : p.onSoft;
    return Material(
      color: onPrimary
          ? p.onPrimary.withValues(alpha: 0.18)
          : (dark ? p.muted : p.soft),
      shape: const StadiumBorder(),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: () => copyToClipboard(context, value, what: what),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.copy_rounded, size: 15, color: fg),
              const SizedBox(width: 6),
              Text(
                l.chatCopy,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: fg,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
