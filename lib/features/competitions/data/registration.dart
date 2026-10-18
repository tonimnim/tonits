/// The player's entry in a competition (`Registration`).
class Registration {
  const Registration({
    required this.id,
    required this.competitionId,
    required this.status,
    required this.entryFeeMinor,
  });

  factory Registration.fromJson(Map<String, dynamic> json) => Registration(
    id: json['id'] as String,
    competitionId: json['competitionId'] as String,
    status: json['status'] as String,
    entryFeeMinor: json['entryFeeMinor'] as int? ?? 0,
  );

  final String id;
  final String competitionId;

  /// `registered`, `checked_in`, `accepted`, `withdrawal_pending`,
  /// `withdrawn` or `disqualified`.
  final String status;
  final int entryFeeMinor;
}
