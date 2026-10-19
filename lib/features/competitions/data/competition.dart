import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/l10n.dart';

part 'competition.freezed.dart';
part 'competition.g.dart';

/// A public competition (`Competition` in the OpenAPI contract). Only the
/// fields the app shows are read.
@freezed
abstract class Competition with _$Competition {
  const Competition._();

  const factory Competition({
    required String id,
    required String name,
    required String gameName,
    required String organizerName,
    @JsonKey(unknownEnumValue: CompetitionFormat.unknown)
    required CompetitionFormat format,
    @JsonKey(unknownEnumValue: CompetitionStatus.unknown)
    required CompetitionStatus status,
    required int maxEntries,
    required int entryCount,
    @JsonKey(unknownEnumValue: EntryType.free) required EntryType entryType,

    /// In the currency's minor units; zero for free entry.
    @Default(0) int entryFeeMinor,
    required String currency,

    /// In minor units; zero when there is no prize.
    @Default(0) int prizeAmountMinor,
    required DateTime startsAt,
    DateTime? registrationClosesAt,
    @Default('') String description,

    /// How many games each round's matches are; only on the detail.
    MatchFormat? matchFormat,
  }) = _Competition;

  factory Competition.fromJson(Map<String, dynamic> json) =>
      _$CompetitionFromJson(json);

  bool get isPaid => entryType == EntryType.paid && entryFeeMinor > 0;

  bool get isFull => entryCount >= maxEntries;

  /// The status can say "registration open" a while after the deadline has
  /// passed; the deadline is what the player can act on.
  bool get registrationEnded {
    final closes = registrationClosesAt;
    return closes != null && !closes.isAfter(DateTime.now());
  }
}

/// How many games a match is (`CompetitionMatchFormat`): [bestOf] for
/// every match, and [rounds] for the rounds that differ, named back from
/// the final (`final`, `semifinal`, `quarterfinal`, `round_of_16`, ...,
/// `third_place`; double elimination `winners_final`, `losers_final`).
@freezed
abstract class MatchFormat with _$MatchFormat {
  const MatchFormat._();

  const factory MatchFormat({
    @Default(1) int bestOf,
    @Default(<String, int>{}) Map<String, int> rounds,
  }) = _MatchFormat;

  factory MatchFormat.fromJson(Map<String, dynamic> json) =>
      _$MatchFormatFromJson(json);

  /// Whether any match is more than one game.
  bool get hasSeries => bestOf > 1 || rounds.values.any((n) => n > 1);
}

enum EntryType { free, paid }

@JsonEnum(fieldRename: FieldRename.snake)
enum CompetitionFormat {
  singleElimination,
  doubleElimination,
  roundRobin,
  unknown;

  String label(AppLocalizations l) => switch (this) {
    singleElimination => l.competitionFormatSingleElimination,
    doubleElimination => l.competitionFormatDoubleElimination,
    roundRobin => l.competitionFormatRoundRobin,
    unknown => l.competitionFormatUnknown,
  };
}

@JsonEnum(fieldRename: FieldRename.snake)
enum CompetitionStatus {
  published,
  registrationOpen,
  checkIn,
  running,
  completed,
  cancelled,
  unknown;

  /// The query value for `GET /v1/competitions?status=`.
  String get wire => switch (this) {
    registrationOpen => 'registration_open',
    checkIn => 'check_in',
    _ => name,
  };
}
