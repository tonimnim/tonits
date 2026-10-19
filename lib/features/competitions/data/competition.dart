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
