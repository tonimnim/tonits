import 'package:freezed_annotation/freezed_annotation.dart';

import '../../matches/data/match_room.dart';
import 'competition.dart';

part 'draw.freezed.dart';
part 'draw.g.dart';

/// A competition's draw once it's made (`TypedBracketResponse`): its stages,
/// their rounds and every match in them, played or still to come.
@freezed
abstract class Bracket with _$Bracket {
  const factory Bracket({
    @Default(<BracketStage>[]) List<BracketStage> stages,
  }) = _Bracket;

  factory Bracket.fromJson(Map<String, dynamic> json) =>
      _$BracketFromJson(json);
}

@freezed
abstract class BracketStage with _$BracketStage {
  const factory BracketStage({
    required String id,
    required int position,
    @JsonKey(unknownEnumValue: CompetitionFormat.unknown)
    required CompetitionFormat format,

    /// `pending`, `active` or `completed`.
    required String status,
    @Default(<BracketRound>[]) List<BracketRound> rounds,
  }) = _BracketStage;

  factory BracketStage.fromJson(Map<String, dynamic> json) =>
      _$BracketStageFromJson(json);
}

@freezed
abstract class BracketRound with _$BracketRound {
  const factory BracketRound({
    /// Counts from 1 within its [bracket].
    required int number,

    /// `main`, `bronze`, `winners`, `losers`, `grand_final`, or a group's
    /// key such as `group_a`.
    required String bracket,
    @Default(<BracketMatch>[]) List<BracketMatch> matches,
  }) = _BracketRound;

  factory BracketRound.fromJson(Map<String, dynamic> json) =>
      _$BracketRoundFromJson(json);
}

@freezed
abstract class BracketMatch with _$BracketMatch {
  const BracketMatch._();

  const factory BracketMatch({
    required String id,
    required int matchNumber,
    @Default(1) int bestOf,
    @JsonKey(unknownEnumValue: BracketMatchState.unknown)
    required BracketMatchState state,
    required BracketSlot home,
    required BracketSlot away,

    /// Goals for a best of 1, games won for a series.
    Score? score,
    String? winnerEntryId,
    DateTime? scheduledAt,

    /// Why it ended, such as `played`, `walkover` or `double_no_show`.
    @JsonKey(readValue: _completionReason) String? completionReason,
  }) = _BracketMatch;

  factory BracketMatch.fromJson(Map<String, dynamic> json) =>
      _$BracketMatchFromJson(json);

  bool involves(String? entryId) =>
      entryId != null &&
      (home.participant?.entryId == entryId ||
          away.participant?.entryId == entryId);

  bool get isOver => switch (state) {
    BracketMatchState.completed ||
    BracketMatchState.forfeit ||
    BracketMatchState.cancelled => true,
    _ => false,
  };
}

Object? _completionReason(Map<dynamic, dynamic> json, String key) =>
    (json['progression'] as Map<dynamic, dynamic>?)?['completionReason'];

@JsonEnum(fieldRename: FieldRename.snake)
enum BracketMatchState {
  pending,
  ready,
  inProgress,
  awaitingConfirmation,
  disputed,
  completed,
  forfeit,
  cancelled,
  unknown,
}

/// One side of a match: the player in it, or nobody yet.
@freezed
abstract class BracketSlot with _$BracketSlot {
  const factory BracketSlot({
    BracketParticipant? participant,

    /// The match that would have filled it ended without a winner, so no
    /// one will.
    @JsonKey(readValue: _voided) @Default(false) bool voided,
  }) = _BracketSlot;

  factory BracketSlot.fromJson(Map<String, dynamic> json) =>
      _$BracketSlotFromJson(json);
}

Object? _voided(Map<dynamic, dynamic> json, String key) =>
    (json['source'] as Map<dynamic, dynamic>?)?['voidedAt'] != null;

@freezed
abstract class BracketParticipant with _$BracketParticipant {
  const factory BracketParticipant({
    required String entryId,
    required String displayName,
  }) = _BracketParticipant;

  factory BracketParticipant.fromJson(Map<String, dynamic> json) =>
      _$BracketParticipantFromJson(json);
}

/// Round-robin tables and, once a stage is over, the final placings
/// (`CompetitionStandings`).
@freezed
abstract class Standings with _$Standings {
  const factory Standings({
    @Default(<StandingsStage>[]) List<StandingsStage> stages,
    @Default(<Placement>[]) List<Placement> placements,
  }) = _Standings;

  factory Standings.fromJson(Map<String, dynamic> json) =>
      _$StandingsFromJson(json);
}

@freezed
abstract class StandingsStage with _$StandingsStage {
  const factory StandingsStage({
    required String id,
    @Default(<StandingsGroup>[]) List<StandingsGroup> groups,
  }) = _StandingsStage;

  factory StandingsStage.fromJson(Map<String, dynamic> json) =>
      _$StandingsStageFromJson(json);
}

@freezed
abstract class StandingsGroup with _$StandingsGroup {
  const factory StandingsGroup({
    /// `main` for a single table, otherwise `group_a`, `group_b` and so on,
    /// matching its rounds' bracket.
    required String key,

    /// In table order, removed entries last.
    @Default(<StandingRow>[]) List<StandingRow> rows,
  }) = _StandingsGroup;

  factory StandingsGroup.fromJson(Map<String, dynamic> json) =>
      _$StandingsGroupFromJson(json);
}

/// One player's line in a table. In a series stage wins and losses count
/// series and points are games won.
@freezed
abstract class StandingRow with _$StandingRow {
  const factory StandingRow({
    /// Null exactly when [removed].
    int? rank,
    required String entryId,
    required String displayName,
    required int played,
    required int wins,
    required int draws,
    required int losses,
    @Default(0) int gamesWon,
    @Default(0) int gamesLost,
    required int goalDifference,
    required int points,

    /// Disqualified or withdrew after the draw: results stand, unranked.
    @Default(false) bool removed,
  }) = _StandingRow;

  factory StandingRow.fromJson(Map<String, dynamic> json) =>
      _$StandingRowFromJson(json);
}

/// A final placing. Players knocked out in the same round share one.
@freezed
abstract class Placement with _$Placement {
  const factory Placement({
    required int placement,
    required String entryId,
    required String displayName,
  }) = _Placement;

  factory Placement.fromJson(Map<String, dynamic> json) =>
      _$PlacementFromJson(json);
}
