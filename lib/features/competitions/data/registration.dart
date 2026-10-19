import 'package:freezed_annotation/freezed_annotation.dart';

import 'competition.dart';

part 'registration.freezed.dart';
part 'registration.g.dart';

/// The player's entry in a competition (`Registration`). Its id is the
/// entry's, the one brackets and standings use.
@freezed
abstract class Registration with _$Registration {
  const Registration._();

  const factory Registration({
    required String id,
    required String competitionId,
    @Default('') String competitionName,
    @JsonKey(unknownEnumValue: EntryStatus.unknown) required EntryStatus status,
    @JsonKey(unknownEnumValue: CompetitionStatus.unknown)
    @Default(CompetitionStatus.unknown)
    CompetitionStatus competitionStatus,
    @Default(0) int entryFeeMinor,
    @Default('KES') String currency,
    DateTime? startsAt,
  }) = _Registration;

  factory Registration.fromJson(Map<String, dynamic> json) =>
      _$RegistrationFromJson(json);

  bool get isPaid => entryFeeMinor > 0;

  /// Cancelling a competition leaves free entries registered, so the
  /// competition's cancellation decides what the entry shows.
  bool get competitionCancelled =>
      competitionStatus == CompetitionStatus.cancelled;
}

@JsonEnum(fieldRename: FieldRename.snake)
enum EntryStatus {
  registered,
  checkedIn,
  accepted,

  /// A paid entry asked to leave; its refund is under review.
  withdrawalPending,
  withdrawn,
  disqualified,
  unknown,
}
