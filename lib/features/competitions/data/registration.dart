import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration.freezed.dart';
part 'registration.g.dart';

/// The player's entry in a competition (`Registration`).
@freezed
abstract class Registration with _$Registration {
  const factory Registration({
    required String id,
    required String competitionId,

    /// `registered`, `checked_in`, `accepted`, `withdrawal_pending`,
    /// `withdrawn` or `disqualified`.
    required String status,
    @Default(0) int entryFeeMinor,
  }) = _Registration;

  factory Registration.fromJson(Map<String, dynamic> json) =>
      _$RegistrationFromJson(json);
}
