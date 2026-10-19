import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/error_text.dart';
import '../../../core/clock.dart';
import '../../../core/format.dart';
import '../../../core/l10n.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../matches/application/matches_providers.dart';
import '../application/chat_controller.dart';
import '../application/chat_providers.dart';
import '../data/match_chat.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/chat_composer.dart';

/// The match's chat with the opponent: agree a time, share the room code.
/// It's read again every few seconds while it's on screen, and closes
/// (read-only) once the match is final.
class MatchChatScreen extends ConsumerWidget {
  const MatchChatScreen({super.key, required this.matchId});

  final String matchId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final provider = matchChatProvider(matchId);
    final opponent = ref
        .watch(matchRoomProvider(matchId))
        .value
        ?.summary
        .opponent;
    final name = opponent?.displayName ?? l.matchOpponent;

    final chat = ref.watch(provider);
    // What's on screen counts as read; it only reaches the server when
    // there's something new.
    if (chat.hasValue) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) unawaited(ref.read(provider.notifier).markSeen());
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text(name)),
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
    ChatDraft draft,
  ) async {
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
    final now = ref.watch(clockProvider).value ?? DateTime.now();
    final chat = view.chat;
    final open = view.openProposal;
    final mineLatest = view.messages.where((m) => m.mine).lastOrNull;

    // Oldest first, then what's still being sent; shown newest at the
    // bottom of a reversed list.
    final entries = <Widget>[];
    for (final (i, m) in view.messages.indexed) {
      final next = i + 1 < view.messages.length ? view.messages[i + 1] : null;
      final endOfRun =
          next == null ||
          next.mine != m.mine ||
          next.kind == ChatKind.timeAnswer ||
          next.sentAt.difference(m.sentAt) > const Duration(minutes: 10);
      entries.add(
        Padding(
          padding: EdgeInsets.only(top: 4, bottom: endOfRun ? 10 : 0),
          child: ChatBubble(
            message: m,
            view: view,
            opponent: opponent,
            now: now,
            showTime: endOfRun && m.kind != ChatKind.timeAnswer,
            seen:
                m == mineLatest &&
                view.pending.isEmpty &&
                chat.opponentReadSeq >= m.seq,
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
        ),
      );
    }
    for (final p in view.pending) {
      entries.add(
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 10),
          child: PendingBubble(
            message: p,
            onRetry: () async {
              final refused = await _controller(ref).retry(p);
              if (refused != null && context.mounted) {
                showMessage(context, refused);
              }
            },
          ),
        ),
      );
    }

    return Column(
      children: [
        if (chat.roomCode != null || chat.agreedStartAt != null)
          _Pinned(chat: chat, now: now),
        Expanded(
          child: entries.isEmpty
              ? const _Empty()
              : ListView(
                  reverse: true,
                  padding: const EdgeInsets.fromLTRB(
                    TonitsSpace.md,
                    TonitsSpace.sm,
                    TonitsSpace.md,
                    TonitsSpace.sm,
                  ),
                  children: [...entries.reversed, const _PrivacyLine()],
                ),
        ),
        SafeArea(
          top: false,
          child: chat.open
              ? ChatComposer(
                  now: now,
                  playBy: chat.playBy,
                  onSend: (draft) => unawaited(_send(context, ref, draft)),
                )
              : Padding(
                  padding: const EdgeInsets.all(TonitsSpace.md),
                  child: Text(
                    context.l10n.chatClosed,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: context.palette.mutedForeground),
                  ),
                ),
        ),
      ],
    );
  }
}

/// The shared room code and the agreed kick-off, kept in view.
class _Pinned extends StatelessWidget {
  const _Pinned({required this.chat, required this.now});

  final MatchChat chat;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final code = chat.roomCode?.code;
    final agreed = chat.agreedStartAt;
    final label = TextStyle(fontSize: 12, color: p.mutedForeground);

    return Container(
      margin: const EdgeInsets.fromLTRB(
        TonitsSpace.md,
        TonitsSpace.sm,
        TonitsSpace.md,
        0,
      ),
      padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
      decoration: BoxDecoration(
        color: p.soft,
        borderRadius: BorderRadius.circular(TonitsRadius.tile),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (code != null)
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l.chatRoomCode, style: label),
                      Text(
                        code,
                        style: monoFont.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: p.foreground,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: l.chatRoomCode,
                  icon: Icon(Icons.copy_rounded, size: 18, color: p.onSoft),
                  onPressed: () =>
                      copyToClipboard(context, code, what: l.chatRoomCode),
                ),
              ],
            ),
          if (code != null && agreed != null) const SizedBox(height: 6),
          if (agreed != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.chatAgreedKickOff, style: label),
                  Text(
                    Format.dateTime(agreed, l, now: now),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(l.chatDeadlinesApply, style: label),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty();

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
            const IconDot(icon: Icons.forum_outlined, size: 56),
            const SizedBox(height: TonitsSpace.md),
            Text(
              l.chatEmpty,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(
              l.chatPrivacy,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: p.mutedForeground),
            ),
          ],
        ),
      ),
    );
  }
}

/// Who can read the chat, at the start of the conversation.
class _PrivacyLine extends StatelessWidget {
  const _PrivacyLine();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: TonitsSpace.md),
      child: Text(
        context.l10n.chatPrivacy,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12, color: context.palette.mutedForeground),
      ),
    );
  }
}
