/// The server's decision on whether the player can enter a competition, and
/// what to do next (`CompetitionEligibility`). The entry button is driven by
/// [requiredAction]; the app never decides eligibility itself.
class Eligibility {
  const Eligibility({
    required this.status,
    required this.eligible,
    required this.requiredAction,
    required this.entryFeeMinor,
    required this.currency,
    required this.issues,
    required this.paymentId,
  });

  factory Eligibility.fromJson(Map<String, dynamic> json) => Eligibility(
    status: json['status'] as String,
    eligible: json['eligible'] as bool,
    requiredAction: RequiredAction.parse(json['requiredAction'] as String),
    entryFeeMinor: json['entryFeeMinor'] as int? ?? 0,
    currency: json['currency'] as String,
    issues: (json['issues'] as List? ?? const [])
        .cast<Map<String, dynamic>>()
        .map(EligibilityIssue.fromJson)
        .toList(),
    paymentId: json['paymentId'] as String?,
  );

  /// `eligible`, `ineligible` or `registered`.
  final String status;
  final bool eligible;
  final RequiredAction requiredAction;
  final int entryFeeMinor;
  final String currency;
  final List<EligibilityIssue> issues;

  /// The player's latest payment for this competition. Whenever it is set,
  /// its status decides what happens, whatever [requiredAction] says.
  final String? paymentId;

  bool get isRegistered => status == 'registered';

  /// The first issue that stops entry, if any.
  EligibilityIssue? get blockingIssue =>
      issues.where((i) => i.blocking).firstOrNull;
}

class EligibilityIssue {
  const EligibilityIssue({
    required this.code,
    required this.blocking,
    required this.message,
  });

  factory EligibilityIssue.fromJson(Map<String, dynamic> json) =>
      EligibilityIssue(
        code: json['code'] as String,
        blocking: json['severity'] == 'blocking',
        message: json['message'] as String,
      );

  /// Such as `country_not_allowed` or `competition_full`.
  final String code;
  final bool blocking;

  /// Ready to show.
  final String message;
}

enum RequiredAction {
  none,
  submitRegistration,
  startPayment,
  pollPayment,
  viewRegistration,
  viewRefund;

  static RequiredAction parse(String value) => switch (value) {
    'submit_registration' => submitRegistration,
    'start_payment' => startPayment,
    'poll_payment' => pollPayment,
    'view_registration' => viewRegistration,
    'view_refund' => viewRefund,
    _ => none,
  };
}
