// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MatchSummary _$MatchSummaryFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_MatchSummary', json, ($checkedConvert) {
  final val = _MatchSummary(
    id: $checkedConvert('id', (v) => v as String),
    competitionId: $checkedConvert('competitionId', (v) => v as String? ?? ''),
    competitionName: $checkedConvert('competitionName', (v) => v as String),
    roundName: $checkedConvert('roundName', (v) => v as String),
    scheduledAt: $checkedConvert(
      'scheduledAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    checkInClosesAt: $checkedConvert(
      'checkInClosesAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    lifecycle: $checkedConvert(
      'lifecycle',
      (v) => $enumDecode(
        _$MatchLifecycleEnumMap,
        v,
        unknownValue: MatchLifecycle.unknown,
      ),
    ),
    outcome: $checkedConvert(
      'outcome',
      (v) => $enumDecodeNullable(
        _$MatchOutcomeEnumMap,
        v,
        unknownValue: JsonKey.nullForUndefinedEnumValue,
      ),
    ),
    currentPlayerSide: $checkedConvert('currentPlayerSide', (v) => v as String),
    home: $checkedConvert(
      'home',
      (v) => v == null
          ? null
          : MatchParticipant.fromJson(v as Map<String, dynamic>),
    ),
    away: $checkedConvert(
      'away',
      (v) => v == null
          ? null
          : MatchParticipant.fromJson(v as Map<String, dynamic>),
    ),
    allowedActions: $checkedConvert(
      'allowedActions',
      (v) =>
          (v as List<dynamic>?)?.map((e) => e as String).toSet() ??
          const <String>{},
    ),
  );
  return val;
});

const _$MatchLifecycleEnumMap = {
  MatchLifecycle.assigned: 'assigned',
  MatchLifecycle.readyForCheckIn: 'ready_for_check_in',
  MatchLifecycle.checkedIn: 'checked_in',
  MatchLifecycle.reportRequired: 'report_required',
  MatchLifecycle.awaitingOpponentConfirmation: 'awaiting_opponent_confirmation',
  MatchLifecycle.confirmationRequired: 'confirmation_required',
  MatchLifecycle.screenshotRequired: 'screenshot_required',
  MatchLifecycle.awaitingOpponentScreenshot: 'awaiting_opponent_screenshot',
  MatchLifecycle.awaitingResolution: 'awaiting_resolution',
  MatchLifecycle.underReview: 'under_review',
  MatchLifecycle.forfeited: 'forfeited',
  MatchLifecycle.completed: 'completed',
  MatchLifecycle.cancelled: 'cancelled',
  MatchLifecycle.outOfCompetition: 'out_of_competition',
  MatchLifecycle.unknown: 'unknown',
};

const _$MatchOutcomeEnumMap = {
  MatchOutcome.won: 'won',
  MatchOutcome.lost: 'lost',
  MatchOutcome.drawn: 'drawn',
  MatchOutcome.noResult: 'no_result',
};

_MatchParticipant _$MatchParticipantFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_MatchParticipant', json, ($checkedConvert) {
      final val = _MatchParticipant(
        displayName: $checkedConvert('displayName', (v) => v as String),
        handle: $checkedConvert('handle', (v) => v as String),
        playerId: $checkedConvert('playerId', (v) => v as String?),
        checkedInAt: $checkedConvert(
          'checkedInAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        gameAccount: $checkedConvert(
          'gameAccount',
          (v) => v == null
              ? null
              : MatchGameAccount.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

_MatchGameAccount _$MatchGameAccountFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_MatchGameAccount', json, ($checkedConvert) {
      final val = _MatchGameAccount(
        inGameName: $checkedConvert('inGameName', (v) => v as String),
        platform: $checkedConvert('platform', (v) => v as String),
        userId: $checkedConvert('publisherPlayerId', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {'userId': 'publisherPlayerId'});
