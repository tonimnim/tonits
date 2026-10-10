import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tonits/features/auth/data/token_store.dart';

class MemoryTokenStore implements TokenStore {
  MemoryTokenStore([this.token]);

  String? token;

  @override
  Future<String?> readRefreshToken() async => token;

  @override
  Future<void> writeRefreshToken(String value) async => token = value;

  @override
  Future<void> clear() async => token = null;
}

http.Response jsonResponse(
  Object body,
  int status, {
  Map<String, String>? headers,
}) => http.Response(
  jsonEncode(body),
  status,
  headers: {'content-type': 'application/json', ...?headers},
);

http.Response errorResponse(
  int status,
  String code, {
  Map<String, String>? headers,
}) => jsonResponse(
  {'error': code, 'message': 'Server says $code'},
  status,
  headers: headers,
);

Map<String, dynamic> playerJson({String countryCode = 'KE'}) => {
  'id': '6f1c2c55-0d3e-4b9b-9a55-0c0b8a3e1d11',
  'username': 'striker.9',
  'konamiId': 'ABCD-1234-EFGH',
  'displayName': 'striker.9',
  'email': null,
  'emailVerified': false,
  'phoneNumber': null,
  'countryCode': countryCode,
  'birthDate': null,
  'status': 'active',
  'profile': null,
};

Map<String, dynamic> sessionJson({
  String access = 'access-1',
  String refresh = 'refresh-1',
}) => {
  'accessToken': access,
  'refreshToken': refresh,
  'tokenType': 'Bearer',
  'expiresInSeconds': 900,
  'player': playerJson(),
};

Map<String, dynamic> competitionJson({
  String id = 'c1',
  String name = 'Nairobi Weekend Cup',
  String status = 'registration_open',
  String entryType = 'free',
  int entryFeeMinor = 0,
  String currency = 'KES',
  int entryCount = 23,
  int maxEntries = 32,
  int prizeAmountMinor = 500000,
  String startsAt = '2026-10-14T16:00:00Z',
}) => {
  'id': id,
  'slug': id,
  'name': name,
  'description': '',
  'gameId': 'efootball-mobile',
  'gameName': 'eFootball Mobile',
  'organizerId': 'o1',
  'organizerName': 'Tonits',
  'format': 'single_elimination',
  'status': status,
  'maxEntries': maxEntries,
  'entryCount': entryCount,
  'availableSlots': maxEntries - entryCount,
  'entryType': entryType,
  'entryFeeMinor': entryFeeMinor,
  'currency': currency,
  'prizeAmountMinor': prizeAmountMinor,
  'registrationClosesAt': '2026-10-13T16:00:00Z',
  'startsAt': startsAt,
};

Map<String, dynamic> participantJson(String name, String handle) => {
  'playerId': 'p-$handle',
  'handle': handle,
  'displayName': name,
  'initials': name.substring(0, 1),
  'avatarUrl': null,
  'side': 'away',
  'gameAccount': null,
};

Map<String, dynamic> matchJson({
  String id = 'm1',
  String lifecycle = 'ready_for_check_in',
  String? outcome,
  Map<String, dynamic>? opponent,
  String scheduledAt = '2026-10-14T18:30:00Z',
  String? checkInClosesAt = '2026-10-14T18:15:00Z',
}) => {
  'id': id,
  'code': 'R1-M1',
  'competitionId': 'c1',
  'competitionName': 'Nairobi Weekend Cup',
  'gameId': 'efootball-mobile',
  'gameName': 'eFootball Mobile',
  'roundName': 'Round of 32',
  'scheduledAt': scheduledAt,
  'checkInClosesAt': checkInClosesAt,
  'state': 'ready',
  'lifecycle': lifecycle,
  'winnerSide': null,
  'outcome': outcome,
  'version': 1,
  'currentPlayerSide': 'home',
  'home': participantJson('striker.9', 'striker.9'),
  'away': opponent ?? participantJson('Amina Otieno', 'amina.o'),
  'allowedActions': lifecycle == 'ready_for_check_in' ? ['check_in'] : [],
};

Map<String, dynamic> rankedJson(int rank, String name, {int rating = 1500}) => {
  'rank': rank,
  'playerId': 'p$rank',
  'handle': name.toLowerCase().replaceAll(' ', '.'),
  'displayName': name,
  'avatarUrl': null,
  'countryCode': 'KE',
  'rating': rating,
  'matchesPlayed': 12,
  'rankMovement': rank.isEven ? 2 : -1,
};

Map<String, dynamic> pageJson(List<Map<String, dynamic>> items) => {
  'data': items,
  'page': {'nextCursor': null, 'hasMore': false},
};

const myPlayerId = '6f1c2c55-0d3e-4b9b-9a55-0c0b8a3e1d11';

Map<String, dynamic> profileJson({
  int wins = 13,
  int draws = 3,
  int losses = 5,
  bool rated = true,
}) => {
  'playerId': myPlayerId,
  'handle': 'striker.9',
  'displayName': 'striker.9',
  'bio': '',
  'avatarUrl': null,
  'countryCode': 'KE',
  'joinedAt': '2026-09-01T00:00:00Z',
  'record': {
    'matchesPlayed': wins + draws + losses,
    'wins': wins,
    'draws': draws,
    'losses': losses,
  },
  'ratings': [
    if (rated)
      {
        'gameId': 'efootball-mobile',
        'rating': 1542,
        'matchesPlayed': wins + draws + losses,
        'wins': wins,
        'draws': draws,
        'losses': losses,
        'globalRank': 310,
        'countryRank': 24,
        'rankMovement': 3,
        'lastMatchAt': '2026-10-08T19:00:00Z',
      },
  ],
  'gameAccounts': [],
};

Map<String, dynamic> playedJson(
  String outcome,
  int scored,
  int conceded,
  String opponent, {
  String playedAt = '2026-10-08T19:00:00Z',
}) => {
  'matchId': 'pm-$opponent-$scored$conceded',
  'playedAt': playedAt,
  'opponent': {
    'playerId': 'p-$opponent',
    'handle': opponent.toLowerCase().replaceAll(' ', '.'),
    'displayName': opponent,
    'avatarUrl': null,
  },
  'score': {
    'player': scored,
    'opponent': conceded,
    'home': scored,
    'away': conceded,
  },
  'outcome': outcome,
  'competition': {'competitionId': 'c1', 'name': 'Nairobi Weekend Cup'},
  'stage': 'main',
  'roundNumber': 1,
  'verificationState': 'confirmed',
};

/// Newest first: three wins in a row, then a loss, a draw and a win.
List<Map<String, dynamic>> recentJson() => [
  playedJson('win', 3, 1, 'Coast Ace', playedAt: '2026-10-08T19:00:00Z'),
  playedJson('win', 2, 0, 'Amina Otieno', playedAt: '2026-10-06T18:30:00Z'),
  playedJson('win', 4, 2, 'Lake Striker', playedAt: '2026-10-04T20:00:00Z'),
  playedJson('loss', 1, 2, 'Kibera Maestro', playedAt: '2026-10-01T19:00:00Z'),
  playedJson('draw', 2, 2, 'Rift Valley FC', playedAt: '2026-09-28T17:00:00Z'),
  playedJson('win', 3, 0, 'Mombasa Flyer', playedAt: '2026-09-25T19:00:00Z'),
];

Map<String, dynamic> ratingHistoryJson() => {
  'data': [
    for (var i = 0; i < 30; i++)
      {
        'at': DateTime.utc(2026, 9, 10 + i).toIso8601String(),
        'rating': 1490 + (i * 1.9).round() + (i % 4 == 0 ? -8 : 0),
      },
  ],
};

/// The Kenya ladder from 21st to 27th, with the signed-in player 24th.
List<Map<String, dynamic>> ladderJson() => [
  for (final (rank, name, rating) in [
    (21, 'Lake Striker', 1571),
    (22, 'Coast Ace', 1560),
    (23, 'Rift Valley FC', 1549),
    (24, 'striker.9', 1542),
    (25, 'Amina Otieno', 1538),
    (26, 'Mombasa Flyer', 1529),
    (27, 'Nakuru Nine', 1521),
  ])
    {
      ...rankedJson(rank, name, rating: rating),
      if (rank == 24) 'playerId': myPlayerId,
    },
];
