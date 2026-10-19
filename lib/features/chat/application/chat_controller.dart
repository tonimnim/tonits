import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/error_text.dart';
import '../../../core/l10n.dart';
import '../../matches/application/matches_providers.dart';
import '../data/chat_repository.dart';
import '../data/match_chat.dart';
import 'chat_providers.dart';

/// A message the player sent that the server hasn't numbered yet. A failed
/// one keeps its client id, so retrying never posts it twice.
class PendingMessage {
  const PendingMessage({
    required this.clientId,
    required this.draft,
    this.error,
  });

  final String clientId;
  final ChatDraft draft;

  /// Why it didn't go, when it didn't.
  final String? error;

  bool get failed => error != null;
}

/// Everything the chat screen shows: where the chat stands, the messages
/// held so far in seq order, and what's still being sent.
class ChatView {
  const ChatView({
    required this.chat,
    required this.messages,
    this.pending = const [],
  });

  /// The latest read's state: open, room code, agreed time, read marks.
  /// Its own message list is left empty; [messages] holds them all.
  final MatchChat chat;
  final List<ChatMessage> messages;
  final List<PendingMessage> pending;

  int get lastSeq => messages.isEmpty ? 0 : messages.last.seq;

  bool answered(ChatMessage proposal) => messages.any(
    (m) => m.kind == ChatKind.timeAnswer && m.replyToSeq == proposal.seq,
  );

  /// The opponent's latest proposal, when nothing answers it and no newer
  /// one replaced it: the only one the player can answer.
  ChatMessage? get openProposal {
    final latest = messages
        .where((m) => m.kind == ChatKind.timeProposal)
        .lastOrNull;
    if (latest == null || latest.mine || answered(latest)) return null;
    return latest;
  }

  ChatView copyWith({
    MatchChat? chat,
    List<ChatMessage>? messages,
    List<PendingMessage>? pending,
  }) => ChatView(
    chat: chat ?? this.chat,
    messages: messages ?? this.messages,
    pending: pending ?? this.pending,
  );

  /// [incoming] merged in by seq, each once, and the pending messages
  /// the server has now numbered dropped.
  ChatView withMessages(
    List<ChatMessage> incoming, {
    Set<String> delivered = const {},
  }) {
    final bySeq = {for (final m in messages) m.seq: m};
    for (final m in incoming) {
      bySeq[m.seq] = m;
    }
    return copyWith(
      messages: bySeq.values.toList()..sort((a, b) => a.seq.compareTo(b.seq)),
      pending: [
        for (final p in pending)
          if (!delivered.contains(p.clientId)) p,
      ],
    );
  }
}

/// One match's chat: reads it, polls for new messages while it's on screen,
/// sends with a client id per message, and marks what the player has seen.
class ChatController extends AsyncNotifier<ChatView> {
  ChatController(this.matchId);

  final String matchId;

  Timer? _nextRead;
  AppLifecycleListener? _lifecycle;
  bool _foreground = true;
  bool _reading = false;

  /// The highest seq already reported as read.
  int _readSent = 0;

  ChatRepository get _repository => ref.read(chatRepositoryProvider);

  @override
  Future<ChatView> build() async {
    final repository = ref.watch(chatRepositoryProvider);
    ref.onDispose(() {
      _nextRead?.cancel();
      _lifecycle?.dispose();
      _lifecycle = null;
    });
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
    var chat = await repository.read(matchId);
    final messages = [...chat.messages];
    while (chat.hasMore && messages.isNotEmpty) {
      chat = await repository.read(matchId, after: messages.last.seq);
      messages.addAll(chat.messages);
    }
    _readSent = chat.readSeq;
    _schedule(open: chat.open);
    return ChatView(
      chat: chat.copyWith(messages: const []),
      messages: messages,
    );
  }

  /// Reads what's new since the last message held. A failed read keeps
  /// what's shown; the next one tries again.
  Future<void> refresh() async {
    final view = state.value;
    if (view == null || _reading) return;
    _reading = true;
    _nextRead?.cancel();
    try {
      var chat = await _repository.read(matchId, after: view.lastSeq);
      final incoming = [...chat.messages];
      while (chat.hasMore && incoming.isNotEmpty) {
        chat = await _repository.read(matchId, after: incoming.last.seq);
        incoming.addAll(chat.messages);
      }
      if (!ref.mounted) return;
      final current = state.value ?? view;
      state = AsyncData(
        current
            .copyWith(chat: chat.copyWith(messages: const []))
            .withMessages(incoming),
      );
    } catch (_) {
      // Kept as shown; the next read retries.
    } finally {
      _reading = false;
      if (ref.mounted) _schedule(open: state.value?.chat.open ?? false);
    }
  }

  /// Sends [draft], showing it at once as pending. Returns a message for
  /// the player when the server refused it outright; a message lost to the
  /// connection stays, marked, to retry.
  Future<String?> send(ChatDraft draft) {
    final pending = PendingMessage(clientId: newUuid(), draft: draft);
    _update((v) => v.copyWith(pending: [...v.pending, pending]));
    return _deliver(pending);
  }

  /// Sends a message that didn't go, with the same client id.
  Future<String?> retry(PendingMessage message) {
    final again = PendingMessage(
      clientId: message.clientId,
      draft: message.draft,
    );
    _replacePending(message.clientId, again);
    return _deliver(again);
  }

  /// Drops a message that didn't go.
  void discard(PendingMessage message) => _update(
    (v) => v.copyWith(
      pending: [
        for (final p in v.pending)
          if (p.clientId != message.clientId) p,
      ],
    ),
  );

  Future<String?> _deliver(PendingMessage message) async {
    final l = ref.read(l10nProvider);
    try {
      final sent = await _repository.send(
        matchId,
        message.draft,
        clientMessageId: message.clientId,
      );
      if (!ref.mounted) return null;
      _update((v) => v.withMessages([sent], delivered: {message.clientId}));
      // Sending reads everything before it, and may pin a code or agree a
      // time: catch up on all of that now.
      _readSent = sent.seq;
      unawaited(refresh());
      return null;
    } on NetworkException catch (e) {
      _replacePending(
        message.clientId,
        PendingMessage(
          clientId: message.clientId,
          draft: message.draft,
          error: describeError(e, l),
        ),
      );
      return null;
    } on ApiException catch (e) {
      // Too many too fast, or the server is struggling: worth a retry.
      if (e.status == 429 || e.status >= 500) {
        _replacePending(
          message.clientId,
          PendingMessage(
            clientId: message.clientId,
            draft: message.draft,
            error: _describe(e, l),
          ),
        );
        return null;
      }
      // Refused as it is: it won't go however often it's tried.
      discard(message);
      if (e.code == 'chat_closed' || e.code.startsWith('proposal_')) {
        unawaited(refresh());
      }
      return _describe(e, l);
    }
  }

  /// Tells the server the player has seen everything held. Cheap to call
  /// often: it only sends when there's something new.
  Future<void> markSeen() async {
    final view = state.value;
    if (view == null) return;
    final seq = view.lastSeq;
    if (seq <= _readSent || seq <= view.chat.readSeq) return;
    _readSent = seq;
    try {
      await _repository.markRead(matchId, seq);
      // The unread badge on the room and the list comes from the server.
      if (ref.mounted) {
        ref.invalidate(myMatchesProvider);
        if (ref.exists(matchRoomProvider(matchId))) {
          unawaited(ref.read(matchRoomProvider(matchId).notifier).refresh());
        }
      }
    } catch (_) {
      // Tried again with the next message seen.
      _readSent = 0;
    }
  }

  /// Reports one of the opponent's messages. Returns null when done, or why
  /// not.
  Future<String?> report(int seq, ChatReportReason reason) async {
    final l = ref.read(l10nProvider);
    try {
      await _repository.report(matchId, seq: seq, reason: reason);
      return null;
    } catch (e) {
      return _describe(e, l);
    }
  }

  void _update(ChatView Function(ChatView view) change) {
    final view = state.value;
    if (view != null && ref.mounted) state = AsyncData(change(view));
  }

  void _replacePending(String clientId, PendingMessage message) => _update(
    (v) => v.copyWith(
      pending: [
        for (final p in v.pending) p.clientId == clientId ? message : p,
      ],
    ),
  );

  void _schedule({required bool open}) {
    _nextRead?.cancel();
    // A closed chat is read-only: nothing new can arrive.
    if (!open || !_foreground) return;
    _nextRead = Timer(ref.read(chatPollIntervalProvider), refresh);
  }

  static String _describe(Object error, AppLocalizations l) {
    if (error is ApiException) {
      switch (error.code) {
        case 'chat_closed':
          return l.chatErrorClosed;
        case 'chat_full':
          return l.chatErrorFull;
        case 'invalid_proposed_time':
          return l.chatErrorProposedTime;
        case 'proposal_not_current' || 'proposal_answered':
          return l.chatErrorProposalGone;
        case 'proposal_expired':
          return l.chatErrorProposalExpired;
        case 'chat_message_already_reported':
          return l.chatErrorAlreadyReported;
      }
    }
    return describeError(error, l);
  }
}
