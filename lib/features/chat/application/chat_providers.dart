import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../data/chat_repository.dart';
import 'chat_controller.dart';

final chatRepositoryProvider = Provider<ChatRepository>(
  (ref) => ChatRepository(ref.watch(apiClientProvider)),
);

/// How often an open chat on screen is read again. Tests lengthen it.
final chatPollIntervalProvider = Provider<Duration>(
  (ref) => const Duration(seconds: 4),
);

/// One match's chat, alive while its screen is.
final matchChatProvider = AsyncNotifierProvider.autoDispose
    .family<ChatController, ChatView, String>(ChatController.new);
