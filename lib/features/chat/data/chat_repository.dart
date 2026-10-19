import '../../../core/api/api_client.dart';
import '../../../core/api/cursor_page.dart';
import 'match_chat.dart';

/// A match's chat, for its two players only; anyone else gets
/// `match_not_found`, as for the match room.
class ChatRepository {
  ChatRepository(this._api);

  final ApiClient _api;

  String _chat(String matchId) =>
      '/v1/matches/${Uri.encodeComponent(matchId)}/chat';

  /// Messages after [after] (all of them when null), oldest first. Each
  /// read also tells the server the player is looking, which holds back
  /// pushes about this chat.
  Future<MatchChat> read(String matchId, {int? after, int limit = 100}) async {
    final json = await _api.get(
      withQuery(_chat(matchId), {'after': after, 'limit': limit}),
      auth: true,
    );
    return MatchChat.fromJson(json!['data'] as Map<String, dynamic>);
  }

  /// [clientMessageId] is one per message, reused only to retry it: a
  /// retry returns the message first stored.
  Future<ChatMessage> send(
    String matchId,
    ChatDraft draft, {
    required String clientMessageId,
  }) async {
    final json = await _api.post(
      '${_chat(matchId)}/messages',
      body: {'clientMessageId': clientMessageId, ...draft.fields},
      auth: true,
    );
    return ChatMessage.fromJson(json!['data'] as Map<String, dynamic>);
  }

  Future<void> markRead(String matchId, int seq) =>
      _api.post('${_chat(matchId)}/read', body: {'seq': seq}, auth: true);

  Future<void> report(
    String matchId, {
    required int seq,
    required ChatReportReason reason,
  }) => _api.post(
    '${_chat(matchId)}/reports',
    body: {'seq': seq, 'reason': reason.name},
    auth: true,
  );
}
