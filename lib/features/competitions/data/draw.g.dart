// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draw.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Bracket _$BracketFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Bracket', json, ($checkedConvert) {
      final val = _Bracket(
        stages: $checkedConvert(
          'stages',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => BracketStage.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              const <BracketStage>[],
        ),
      );
      return val;
    });

_BracketStage _$BracketStageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_BracketStage', json, ($checkedConvert) {
      final val = _BracketStage(
        id: $checkedConvert('id', (v) => v as String),
        position: $checkedConvert('position', (v) => (v as num).toInt()),
        format: $checkedConvert(
          'format',
          (v) => $enumDecode(
            _$CompetitionFormatEnumMap,
            v,
            unknownValue: CompetitionFormat.unknown,
          ),
        ),
        status: $checkedConvert('status', (v) => v as String),
        rounds: $checkedConvert(
          'rounds',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => BracketRound.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              const <BracketRound>[],
        ),
      );
      return val;
    });

const _$CompetitionFormatEnumMap = {
  CompetitionFormat.singleElimination: 'single_elimination',
  CompetitionFormat.doubleElimination: 'double_elimination',
  CompetitionFormat.roundRobin: 'round_robin',
  CompetitionFormat.unknown: 'unknown',
};

_BracketRound _$BracketRoundFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_BracketRound', json, ($checkedConvert) {
      final val = _BracketRound(
        number: $checkedConvert('number', (v) => (v as num).toInt()),
        bracket: $checkedConvert('bracket', (v) => v as String),
        matches: $checkedConvert(
          'matches',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => BracketMatch.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              const <BracketMatch>[],
        ),
      );
      return val;
    });

_BracketMatch _$BracketMatchFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_BracketMatch', json, ($checkedConvert) {
      final val = _BracketMatch(
        id: $checkedConvert('id', (v) => v as String),
        matchNumber: $checkedConvert('matchNumber', (v) => (v as num).toInt()),
        bestOf: $checkedConvert('bestOf', (v) => (v as num?)?.toInt() ?? 1),
        state: $checkedConvert(
          'state',
          (v) => $enumDecode(
            _$BracketMatchStateEnumMap,
            v,
            unknownValue: BracketMatchState.unknown,
          ),
        ),
        home: $checkedConvert(
          'home',
          (v) => BracketSlot.fromJson(v as Map<String, dynamic>),
        ),
        away: $checkedConvert(
          'away',
          (v) => BracketSlot.fromJson(v as Map<String, dynamic>),
        ),
        score: $checkedConvert(
          'score',
          (v) => v == null ? null : Score.fromJson(v as Map<String, dynamic>),
        ),
        winnerEntryId: $checkedConvert('winnerEntryId', (v) => v as String?),
        scheduledAt: $checkedConvert(
          'scheduledAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        completionReason: $checkedConvert(
          'completionReason',
          (v) => v as String?,
          readValue: _completionReason,
        ),
      );
      return val;
    });

const _$BracketMatchStateEnumMap = {
  BracketMatchState.pending: 'pending',
  BracketMatchState.ready: 'ready',
  BracketMatchState.inProgress: 'in_progress',
  BracketMatchState.awaitingConfirmation: 'awaiting_confirmation',
  BracketMatchState.disputed: 'disputed',
  BracketMatchState.completed: 'completed',
  BracketMatchState.forfeit: 'forfeit',
  BracketMatchState.cancelled: 'cancelled',
  BracketMatchState.unknown: 'unknown',
};

_BracketSlot _$BracketSlotFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_BracketSlot', json, ($checkedConvert) {
      final val = _BracketSlot(
        participant: $checkedConvert(
          'participant',
          (v) => v == null
              ? null
              : BracketParticipant.fromJson(v as Map<String, dynamic>),
        ),
        voided: $checkedConvert(
          'voided',
          (v) => v as bool? ?? false,
          readValue: _voided,
        ),
      );
      return val;
    });

_BracketParticipant _$BracketParticipantFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_BracketParticipant', json, ($checkedConvert) {
      final val = _BracketParticipant(
        entryId: $checkedConvert('entryId', (v) => v as String),
        displayName: $checkedConvert('displayName', (v) => v as String),
      );
      return val;
    });

_Standings _$StandingsFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Standings',
  json,
  ($checkedConvert) {
    final val = _Standings(
      stages: $checkedConvert(
        'stages',
        (v) =>
            (v as List<dynamic>?)
                ?.map((e) => StandingsStage.fromJson(e as Map<String, dynamic>))
                .toList() ??
            const <StandingsStage>[],
      ),
      placements: $checkedConvert(
        'placements',
        (v) =>
            (v as List<dynamic>?)
                ?.map((e) => Placement.fromJson(e as Map<String, dynamic>))
                .toList() ??
            const <Placement>[],
      ),
    );
    return val;
  },
);

_StandingsStage _$StandingsStageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_StandingsStage', json, ($checkedConvert) {
      final val = _StandingsStage(
        id: $checkedConvert('id', (v) => v as String),
        groups: $checkedConvert(
          'groups',
          (v) =>
              (v as List<dynamic>?)
                  ?.map(
                    (e) => StandingsGroup.fromJson(e as Map<String, dynamic>),
                  )
                  .toList() ??
              const <StandingsGroup>[],
        ),
      );
      return val;
    });

_StandingsGroup _$StandingsGroupFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_StandingsGroup', json, ($checkedConvert) {
      final val = _StandingsGroup(
        key: $checkedConvert('key', (v) => v as String),
        rows: $checkedConvert(
          'rows',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => StandingRow.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              const <StandingRow>[],
        ),
      );
      return val;
    });

_StandingRow _$StandingRowFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_StandingRow',
  json,
  ($checkedConvert) {
    final val = _StandingRow(
      rank: $checkedConvert('rank', (v) => (v as num?)?.toInt()),
      entryId: $checkedConvert('entryId', (v) => v as String),
      displayName: $checkedConvert('displayName', (v) => v as String),
      played: $checkedConvert('played', (v) => (v as num).toInt()),
      wins: $checkedConvert('wins', (v) => (v as num).toInt()),
      draws: $checkedConvert('draws', (v) => (v as num).toInt()),
      losses: $checkedConvert('losses', (v) => (v as num).toInt()),
      gamesWon: $checkedConvert('gamesWon', (v) => (v as num?)?.toInt() ?? 0),
      gamesLost: $checkedConvert('gamesLost', (v) => (v as num?)?.toInt() ?? 0),
      goalDifference: $checkedConvert(
        'goalDifference',
        (v) => (v as num).toInt(),
      ),
      points: $checkedConvert('points', (v) => (v as num).toInt()),
      removed: $checkedConvert('removed', (v) => v as bool? ?? false),
    );
    return val;
  },
);

_Placement _$PlacementFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Placement', json, ($checkedConvert) {
      final val = _Placement(
        placement: $checkedConvert('placement', (v) => (v as num).toInt()),
        entryId: $checkedConvert('entryId', (v) => v as String),
        displayName: $checkedConvert('displayName', (v) => v as String),
      );
      return val;
    });
