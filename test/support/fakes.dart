import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:tonits/features/auth/data/identity_providers.dart';
import 'package:tonits/features/auth/data/token_store.dart';

/// Stands in for the Google or Apple account picker. [token] null means
/// the player closed it.
class FakeIdentity implements IdentityProvider {
  FakeIdentity(this.token, {this.nonce});

  final String? token;
  final String? nonce;
  int signOuts = 0;

  @override
  Future<IdentityToken?> obtain() async =>
      token == null ? null : IdentityToken(token!, nonce: nonce);

  @override
  Future<void> signOut() async => signOuts++;
}

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

/// A player as the API returns it. A Google or Apple player who hasn't
/// finished onboarding ([onboarded] false) has a generated handle and no
/// Konami ID, country or phone yet.
Map<String, dynamic> playerJson({
  String countryCode = 'KE',
  String? email,
  String? phoneNumber,
  String displayName = 'striker.9',
  bool onboarded = true,
  List<String> signInMethods = const ['google'],
}) => {
  'id': '6f1c2c55-0d3e-4b9b-9a55-0c0b8a3e1d11',
  'username': onboarded ? 'striker.9' : newPlayerHandle,
  'konamiId': onboarded ? 'ABCD-1234-EFGH' : null,
  'displayName': onboarded ? displayName : newPlayerHandle,
  'email': email,
  'emailVerified': email != null,
  'phoneNumber': onboarded ? phoneNumber : null,
  'phoneVerified': false,
  'countryCode': onboarded ? countryCode : '',
  'birthDate': null,
  'status': 'active',
  'onboardingCompleted': onboarded,
  'signInMethods': signInMethods,
  'profile': null,
};

/// The handle the API generates for a new Google or Apple player.
const newPlayerHandle = 'Wanjiru_4821';

Map<String, dynamic> sessionJson({
  String access = 'access-1',
  String refresh = 'refresh-1',
  bool onboarded = true,
  Map<String, dynamic>? player,
}) => {
  'accessToken': access,
  'refreshToken': refresh,
  'tokenType': 'Bearer',
  'expiresInSeconds': 900,
  'player': player ?? playerJson(onboarded: onboarded),
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
  String startsAt = '2027-01-14T16:00:00Z',
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
  'registrationClosesAt': '2027-01-13T16:00:00Z',
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

const myGameAccountId = '9b2f2a1e-1c2d-4e5f-8a9b-0c1d2e3f4a5b';

Map<String, dynamic> eligibilityJson({
  String status = 'eligible',
  String action = 'submit_registration',
  int fee = 0,
  String? paymentId,
  List<Map<String, dynamic>> issues = const [],
}) => {
  'data': {
    'competitionId': 'c1',
    'gameId': 'efootball-mobile',
    'status': status,
    'eligible': !issues.any((i) => i['severity'] == 'blocking'),
    'canRegisterNow': action == 'submit_registration',
    'requiredAction': action,
    'entryFeeMinor': fee,
    'currency': 'KES',
    'requirements': {
      'minimumAge': null,
      'allowedCountries': <String>[],
      'minimumRating': null,
      'maximumRank': null,
      'requireVerifiedGameAccount': false,
    },
    'issues': issues,
    'paymentId': paymentId,
    'evaluatedAt': '2026-10-18T09:00:00Z',
  },
};

Map<String, dynamic> issueJson(String code, String message) => {
  'code': code,
  'category': 'country',
  'severity': 'blocking',
  'message': message,
};

Map<String, dynamic> paymentJson({
  String id = 'pay1',
  String status = 'pending',
  String registrationStatus = 'pending',
  String? providerMessage,
}) => {
  'id': id,
  'competitionId': 'c2',
  'entryId': null,
  'amountMinor': 10000,
  'currency': 'KES',
  'phoneNumber': '+2547******78',
  'status': status,
  'registrationStatus': registrationStatus,
  'refund': null,
  'providerResultDescription': providerMessage,
  'createdAt': '2026-10-18T09:00:00Z',
  'updatedAt': '2026-10-18T09:00:00Z',
  'completedAt': null,
};

/// The paid competition in the fixtures.
Map<String, dynamic> paidCompetitionJson() => competitionJson(
  id: 'c2',
  name: 'Mombasa Masters',
  entryType: 'paid',
  entryFeeMinor: 10000,
  entryCount: 11,
  maxEntries: 16,
  prizeAmountMinor: 800000,
);

/// The fixed "now" the test clock reports; deadlines in fakes count from it.
final testNow = DateTime.now().toUtc();

/// A match room ([matchJson] plus the room's fields) at [lifecycle], with
/// the actions that stage allows. Deadlines count from [testNow].
Map<String, dynamic> matchRoomJson({
  String id = 'm1',
  String lifecycle = 'ready_for_check_in',
  List<String>? allowedActions,
  String? outcome,
  bool drawAllowed = false,
  bool meCheckedIn = false,
  bool opponentCheckedIn = false,
  Map<String, dynamic>? submitted,
  Map<String, dynamic>? result,
  String? completionReason,
  bool entryRemoved = false,
  String? opponentUserId = '8F3K-2P9Q-LM4R',
}) {
  String inMinutes(int minutes) =>
      testNow.add(Duration(minutes: minutes)).toIso8601String();
  final phase = switch (lifecycle) {
    'awaiting_opponent_confirmation' ||
    'confirmation_required' => 'awaiting_confirmation',
    'screenshot_required' ||
    'awaiting_opponent_screenshot' => 'awaiting_screenshots',
    'under_review' => 'in_review',
    'completed' || 'forfeited' || 'cancelled' => 'resolved',
    _ => 'not_started',
  };
  final home = participantJson('striker.9', 'striker.9')
    ..['checkedInAt'] = meCheckedIn ? inMinutes(-5) : null
    ..['gameAccount'] = {
      'inGameName': 'striker.9',
      'platform': 'android',
      'publisherPlayerId': 'ABCD-1234-EFGH',
    };
  final away = participantJson('Amina Otieno', 'amina.o')
    ..['checkedInAt'] = opponentCheckedIn ? inMinutes(-3) : null
    ..['gameAccount'] = {
      'inGameName': 'AminaFC',
      'platform': 'ios',
      'publisherPlayerId': opponentUserId,
    };
  return {
    ...matchJson(id: id, lifecycle: lifecycle, outcome: outcome),
    'home': home,
    'away': away,
    'checkInClosesAt': inMinutes(12),
    'allowedActions':
        allowedActions ??
        switch (lifecycle) {
          'ready_for_check_in' => ['check_in'],
          'report_required' => ['report_score'],
          'confirmation_required' => ['confirm_result', 'reject_result'],
          'screenshot_required' => ['submit_screenshot'],
          _ => <String>[],
        },
    'stageId': 's1',
    'stageName': 'Knockout',
    'roundNumber': 1,
    'matchNumber': 1,
    'bracket': 'main',
    'bestOf': 1,
    'drawAllowed': drawAllowed,
    'checkInOpensAt': inMinutes(-10),
    'resultDueAt': inMinutes(55),
    'completedAt': null,
    'currentPlayerId': myPlayerId,
    'friendMatchInstructions': [
      {
        'title': 'Add your opponent',
        'detail': 'In eFootball, open Friends and search for their User ID.',
      },
      {
        'title': 'Start a Friend Match',
        'detail': 'Use the competition settings: 10 minutes, no extra time.',
      },
    ],
    'completionReason': completionReason,
    'verificationPolicy': {
      'reportWindowSeconds': 600,
      'reminderBeforeDeadlineSeconds': 180,
      'responseWindowSeconds': 600,
      'screenshotEvidence': {
        'minItems': 1,
        'maxItems': 1,
        'mediaTypes': ['image/jpeg', 'image/png'],
      },
    },
    'resultVerification': {
      'phase': phase,
      'submittedResult': submitted,
      'myScreenshot': lifecycle == 'awaiting_opponent_screenshot'
          ? {'id': 'rs1', 'evidenceId': 'ev1', 'submittedAt': inMinutes(-1)}
          : null,
      'opponentScreenshotSubmitted': false,
      'confirmationDeadline': phase == 'awaiting_confirmation'
          ? inMinutes(8)
          : null,
      'screenshotDeadline': phase == 'awaiting_screenshots'
          ? inMinutes(9)
          : null,
      'resolution': null,
      'entryRemoved': entryRemoved,
    },
    'result': result,
    'removals': <Object>[],
  };
}

/// A result one side submitted: [home]–[away], by this player or not.
Map<String, dynamic> submittedJson(
  int home,
  int away, {
  bool byMe = false,
  Map<String, dynamic>? penalties,
}) => {
  'id': 'sr1',
  'side': byMe ? 'home' : 'away',
  'submittedByMe': byMe,
  'homeScore': home,
  'awayScore': away,
  'tiebreak': penalties,
  'games': <Object>[],
  'submittedAt': testNow.subtract(const Duration(minutes: 2)).toIso8601String(),
};

/// Wraps a room the way action responses do.
Map<String, dynamic> roomActionJson(Map<String, dynamic> room) => {
  'data': {'match': room},
};

/// The smallest valid PNG header, enough to be recognised as PNG.
final pngBytes = Uint8List.fromList([
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0, 0, 0, 13, //
]);
