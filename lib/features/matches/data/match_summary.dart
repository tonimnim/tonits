/// One of the player's match assignments (`MatchSummary` in the OpenAPI
/// contract). The server decides what the player can do next: drive the UI
/// from [lifecycle] and [allowedActions], never from guesses.
class MatchSummary {
  const MatchSummary({
    required this.id,
    required this.competitionId,
    required this.competitionName,
    required this.roundName,
    required this.scheduledAt,
    required this.checkInClosesAt,
    required this.lifecycle,
    required this.outcome,
    required this.currentPlayerSide,
    required this.home,
    required this.away,
    required this.allowedActions,
  });

  factory MatchSummary.fromJson(Map<String, dynamic> json) => MatchSummary(
    id: json['id'] as String,
    competitionId: json['competitionId'] as String? ?? '',
    competitionName: json['competitionName'] as String,
    roundName: json['roundName'] as String,
    scheduledAt: _date(json['scheduledAt']),
    checkInClosesAt: _date(json['checkInClosesAt']),
    lifecycle: MatchLifecycle.parse(json['lifecycle'] as String),
    outcome: MatchOutcome.parse(json['outcome'] as String?),
    currentPlayerSide: json['currentPlayerSide'] as String,
    home: MatchParticipant.maybe(json['home']),
    away: MatchParticipant.maybe(json['away']),
    allowedActions: {
      for (final action in json['allowedActions'] as List) action as String,
    },
  );

  final String id;
  final String competitionId;
  final String competitionName;
  final String roundName;
  final DateTime? scheduledAt;
  final DateTime? checkInClosesAt;
  final MatchLifecycle lifecycle;
  final MatchOutcome? outcome;

  /// `home` or `away`: which side the signed-in player is on.
  final String currentPlayerSide;
  final MatchParticipant? home;
  final MatchParticipant? away;
  final Set<String> allowedActions;

  /// Null until the other slot is filled (for example, by a previous round).
  MatchParticipant? get opponent => currentPlayerSide == 'home' ? away : home;

  MatchParticipant? get me => currentPlayerSide == 'home' ? home : away;

  bool get isHome => currentPlayerSide == 'home';

  static DateTime? _date(Object? value) =>
      value is String ? DateTime.parse(value) : null;
}

class MatchParticipant {
  const MatchParticipant({
    required this.displayName,
    required this.handle,
    this.playerId,
    this.checkedInAt,
    this.gameAccount,
  });

  static MatchParticipant? maybe(Object? json) => json is Map<String, dynamic>
      ? MatchParticipant(
          displayName: json['displayName'] as String,
          handle: json['handle'] as String,
          playerId: json['playerId'] as String?,
          checkedInAt: json['checkedInAt'] is String
              ? DateTime.parse(json['checkedInAt'] as String)
              : null,
          gameAccount: MatchGameAccount.maybe(json['gameAccount']),
        )
      : null;

  final String displayName;
  final String handle;
  final String? playerId;
  final DateTime? checkedInAt;

  /// The eFootball account this side plays with, for finding each other in
  /// the game. Only the match's two players receive it.
  final MatchGameAccount? gameAccount;

  bool get checkedIn => checkedInAt != null;
}

class MatchGameAccount {
  const MatchGameAccount({
    required this.inGameName,
    required this.platform,
    required this.userId,
  });

  static MatchGameAccount? maybe(Object? json) => json is Map<String, dynamic>
      ? MatchGameAccount(
          inGameName: json['inGameName'] as String,
          platform: json['platform'] as String,
          userId: json['publisherPlayerId'] as String?,
        )
      : null;

  /// The name shown in eFootball.
  final String inGameName;

  /// `android` or `ios`.
  final String platform;

  /// The eFootball User ID players add each other by; null when not added.
  final String? userId;
}

/// Where the match stands for this player, as the server derives it.
enum MatchLifecycle {
  assigned,
  readyForCheckIn,
  checkedIn,
  reportRequired,
  awaitingOpponentConfirmation,
  confirmationRequired,
  screenshotRequired,
  awaitingOpponentScreenshot,
  awaitingResolution,
  underReview,
  forfeited,
  completed,
  cancelled,
  outOfCompetition,
  unknown;

  static MatchLifecycle parse(String value) {
    // snake_case on the wire, camelCase here.
    final camel = value.replaceAllMapped(
      RegExp(r'_([a-z])'),
      (m) => m[1]!.toUpperCase(),
    );
    return values.firstWhere((v) => v.name == camel, orElse: () => unknown);
  }

  bool get isOver =>
      this == completed || this == forfeited || this == cancelled;
}

enum MatchOutcome {
  won,
  lost,
  drawn,
  noResult;

  static MatchOutcome? parse(String? value) => switch (value) {
    'won' => won,
    'lost' => lost,
    'drawn' => drawn,
    'no_result' => noResult,
    _ => null,
  };
}
