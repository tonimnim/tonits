import 'package:freezed_annotation/freezed_annotation.dart';

part 'eligibility.freezed.dart';
part 'eligibility.g.dart';

/// The server's decision on whether the player can enter a competition, and
/// what to do next (`CompetitionEligibility`). The entry button is driven by
/// [requiredAction]; the app never decides eligibility itself.
@freezed
abstract class Eligibility with _$Eligibility {
  const Eligibility._();

  const factory Eligibility({
    /// `eligible`, `ineligible` or `registered`.
    required String status,
    required bool eligible,
    @JsonKey(unknownEnumValue: RequiredAction.none)
    required RequiredAction requiredAction,
    @Default(0) int entryFeeMinor,
    required String currency,
    @Default(<EligibilityIssue>[]) List<EligibilityIssue> issues,

    /// The player's latest payment for this competition. Whenever it is set,
    /// its status decides what happens, whatever [requiredAction] says.
    String? paymentId,
  }) = _Eligibility;

  factory Eligibility.fromJson(Map<String, dynamic> json) =>
      _$EligibilityFromJson(json);

  bool get isRegistered => status == 'registered';

  /// The first issue that stops entry, if any.
  EligibilityIssue? get blockingIssue =>
      issues.where((i) => i.blocking).firstOrNull;
}

@freezed
abstract class EligibilityIssue with _$EligibilityIssue {
  const EligibilityIssue._();

  const factory EligibilityIssue({
    /// Such as `country_not_allowed` or `competition_full`.
    required String code,

    /// `blocking` or `warning`.
    required String severity,

    /// Ready to show.
    required String message,
  }) = _EligibilityIssue;

  factory EligibilityIssue.fromJson(Map<String, dynamic> json) =>
      _$EligibilityIssueFromJson(json);

  bool get blocking => severity == 'blocking';
}

@JsonEnum(fieldRename: FieldRename.snake)
enum RequiredAction {
  none,
  submitRegistration,
  startPayment,
  pollPayment,
  viewRegistration,
  viewRefund,
}
