import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/error_text.dart';
import '../../../core/clock.dart';
import '../../../core/l10n.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../matches/application/matches_providers.dart';
import '../../matches/data/match_summary.dart';
import '../application/chat_controller.dart';
import '../application/chat_providers.dart';
import '../data/match_chat.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/chat_composer.dart';
import 'widgets/chat_sheets.dart';
import 'widgets/game_plan.dart';

/// The match's chat with the opponent, laid out like the chat apps players
/// already use. Its game plan above the messages pins the room code and
/// kick-off. It's read again every few seconds while on screen, and is
/// read-only once the match is over.
class MatchChatScreen extends ConsumerWidget {
  const MatchChatScreen({super.key, required this.matchId});

  final String matchId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final provider = matchChatProvider(matchId);
    final summary = ref.watch(matchRoomProvider(matchId)).value?.summary;
    final name = summary?.opponent?.displayName ?? l.matchOpponent;

    final chat = ref.watch(provider);
    // What's on screen counts as read; it only reaches the server when
    // there's something new.
    if (chat.hasValue) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) unawaited(ref.read(provider.notifier).markSeen());
      });
    }

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: _Header(name: name, summary: summary),
      ),
      body: switch (chat) {
        AsyncData(:final value) => _Chat(
          matchId: matchId,
          view: value,
          opponent: name,
        ),
        AsyncError(:final error) => ErrorState(
          message: describeError(error, l),
          onRetry: () => ref.invalidate(provider),
        ),
        _ => const LoadingState(),
      },
    );
  }
}

/// The opponent, and which match this is.
class _Header extends StatelessWidget {
  const _Header({required this.name, this.summary});

  final String name;
  final MatchSummary? summary;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final match = summary;
    return Row(
      children: [
        InitialsAvatar(name: name, size: 38),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (match != null)
                Text(
                  '${match.roundName} · ${match.competitionName}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: p.mutedForeground),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Chat extends ConsumerWidget {
  const _Chat({
    required this.matchId,
    required this.view,
    required this.opponent,
  });

  final String matchId;
  final ChatView view;
  final String opponent;

  ChatController _controller(WidgetRef ref) =>
      ref.read(matchChatProvider(matchId).notifier);

  Future<void> _send(
    BuildContext context,
    WidgetRef ref,
    ChatDraft? draft,
  ) async {
    if (draft == null) return;
    final refused = await _controller(ref).send(draft);
    if (refused != null && context.mounted) showMessage(context, refused);
  }

  Future<void> _report(
    BuildContext context,
    WidgetRef ref,
    ChatMessage message,
  ) async {
    final reason = await showModalBottomSheet<ChatReportReason>(
      context: context,
      builder: (sheet) {
        final l = sheet.l10n;
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  TonitsSpace.lg,
                  0,
                  TonitsSpace.lg,
                  TonitsSpace.sm,
                ),
                child: Text(
                  l.chatReportTitle,
                  style: Theme.of(sheet).textTheme.headlineSmall,
                ),
              ),
              for (final (reason, label) in [
                (ChatReportReason.abuse, l.chatReasonAbuse),
                (ChatReportReason.harassment, l.chatReasonHarassment),
                (ChatReportReason.cheating, l.chatReasonCheating),
                (ChatReportReason.spam, l.chatReasonSpam),
                (ChatReportReason.other, l.chatReasonOther),
              ])
                ListTile(
                  title: Text(label),
                  onTap: () => Navigator.of(sheet).pop(reason),
                ),
            ],
          ),
        );
      },
    );
    if (reason == null || !context.mounted) return;
    final l = context.l10n;
    final problem = await _controller(ref).report(message.seq, reason);
    if (context.mounted) showMessage(context, problem ?? l.chatReported);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    // To the minute: nothing here needs seconds (day labels, whether a
    // suggested kick-off has passed), and a per-second clock would rebuild
    // the whole conversation every second.
    final now =
        ref.watch(clockProvider.select((tick) => _toMinute(tick.value))) ??
        _toMinute(DateTime.now())!;
    final chat = view.chat;
    final open = view.openProposal;

    // Oldest first, with a day label where the day changes, then what's
    // still being sent; shown newest at the bottom of a reversed list, which
    // builds only the rows on screen.
    final items = <_ChatItem>[];
    String? day;
    for (final (i, m) in view.messages.indexed) {
      final label = chatDay(m.sentAt, l, now: now);
      if (label != day) {
        items.add(_ChatItem.day(label));
        day = label;
      }
      items.add(_ChatItem.message(i, m.seq));
    }
    for (final p in view.pending) {
      items.add(_ChatItem.pending(p));
    }
    // Row index in the reversed list, by key: a new message at the bottom
    // keeps every other row (and its state) where it was.
    final rowOf = {
      for (final (i, item) in items.indexed) item.key: items.length - 1 - i,
    };

    Widget message(int i) {
      final m = view.messages[i];
      final previous = i > 0 ? view.messages[i - 1] : null;
      final sameRun = previous != null && previous.mine == m.mine;
      return Padding(
        padding: EdgeInsets.only(top: sameRun ? 3 : 10),
        child: ChatBubble(
          message: m,
          view: view,
          opponent: opponent,
          now: now,
          seen: m.mine && chat.opponentReadSeq >= m.seq,
          onAnswer:
              m == open &&
                  chat.open &&
                  (m.proposedStartAt?.isAfter(now) ?? false)
              ? ({required accepted}) => _send(
                  context,
                  ref,
                  TimeAnswerDraft(proposalSeq: m.seq, accepted: accepted),
                )
              : null,
          onReport: m.mine || m.kind == ChatKind.timeAnswer
              ? null
              : () => _report(context, ref, m),
        ),
      );
    }

    Widget pending(PendingMessage p) => Padding(
      padding: const EdgeInsets.only(top: 3),
      child: PendingBubble(
        message: p,
        onRetry: () async {
          final refused = await _controller(ref).retry(p);
          if (refused != null && context.mounted) {
            showMessage(context, refused);
          }
        },
      ),
    );

    return Column(
      children: [
        // Out of the way while typing, so the conversation keeps the room.
        _HiddenWhileTyping(
          child: GamePlan(
            view: view,
            opponent: opponent,
            now: now,
            onDropCode: () async {
              final draft = await askRoomCode(context);
              if (context.mounted) await _send(context, ref, draft);
            },
            onSuggestTime: () async {
              // The exact time, not the minute the screen shows: choices
              // like "In 30 min" count from it.
              final draft = await askKickOff(
                context,
                now: ref.read(clockProvider).value ?? DateTime.now(),
                playBy: chat.playBy,
              );
              if (context.mounted) await _send(context, ref, draft);
            },
          ),
        ),
        Expanded(
          child: items.isEmpty
              ? _Empty(opponent: opponent)
              : ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.fromLTRB(
                    TonitsSpace.md,
                    TonitsSpace.sm,
                    TonitsSpace.md,
                    TonitsSpace.md,
                  ),
                  // The privacy line sits above the oldest message.
                  itemCount: items.length + 1,
                  findChildIndexCallback: (key) =>
                      key is ValueKey<String> ? rowOf[key.value] : null,
                  itemBuilder: (context, row) {
                    if (row == items.length) return const _PrivacyLine();
                    final item = items[items.length - 1 - row];
                    return KeyedSubtree(
                      key: ValueKey(item.key),
                      child: switch (item) {
                        _ChatItem(day: final label?) => ChatDaySeparator(label),
                        _ChatItem(pending: final p?) => pending(p),
                        _ChatItem(:final index) => message(index!),
                      },
                    );
                  },
                ),
        ),
        SafeArea(
          top: false,
          child: chat.open
              ? ChatComposer(
                  opponent: opponent,
                  onSend: (draft) => unawaited(_send(context, ref, draft)),
                )
              : Padding(
                  padding: const EdgeInsets.all(TonitsSpace.md),
                  child: Text(
                    l.chatClosed,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: context.palette.mutedForeground),
                  ),
                ),
        ),
      ],
    );
  }
}

DateTime? _toMinute(DateTime? t) =>
    t == null ? null : DateTime(t.year, t.month, t.day, t.hour, t.minute);

/// One row of the conversation: a day label, a delivered message (by its
/// place in the list) or one still being sent.
class _ChatItem {
  const _ChatItem.day(String this.day)
    : index = null,
      pending = null,
      key = 'day:$day';
  const _ChatItem.message(int this.index, int seq)
    : day = null,
      pending = null,
      key = 'seq:$seq';
  _ChatItem.pending(PendingMessage this.pending)
    : day = null,
      index = null,
      key = 'pending:${pending.clientId}';

  final String? day;
  final int? index;
  final PendingMessage? pending;
  final String key;
}

/// Shows [child] only while the keyboard is down. Reading the keyboard's
/// inset here, not in the chat, keeps its slide from rebuilding every
/// message on every frame.
class _HiddenWhileTyping extends StatelessWidget {
  const _HiddenWhileTyping({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) =>
      MediaQuery.viewInsetsOf(context).bottom == 0
      ? child
      : const SizedBox.shrink();
}

class _Empty extends StatelessWidget {
  const _Empty({required this.opponent});

  final String opponent;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(TonitsSpace.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InitialsAvatar(name: opponent, size: 64),
            const SizedBox(height: TonitsSpace.md),
            Text(
              l.chatEmpty(opponent),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(
              '${l.chatPrivacy} ${l.chatReportHint}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: p.mutedForeground),
            ),
          ],
        ),
      ),
    );
  }
}

/// Who can read the chat, and how to report a message, at the start of
/// the conversation.
class _PrivacyLine extends StatelessWidget {
  const _PrivacyLine();

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(top: TonitsSpace.sm),
      child: Text(
        '${l.chatPrivacy} ${l.chatReportHint}',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12, color: context.palette.mutedForeground),
      ),
    );
  }
}
