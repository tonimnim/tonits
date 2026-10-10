/// A public competition (`Competition` in the OpenAPI contract). Only the
/// fields the app shows are parsed.
class Competition {
  const Competition({
    required this.id,
    required this.name,
    required this.gameName,
    required this.organizerName,
    required this.format,
    required this.status,
    required this.maxEntries,
    required this.entryCount,
    required this.entryType,
    required this.entryFeeMinor,
    required this.currency,
    required this.prizeAmountMinor,
    required this.startsAt,
    this.registrationClosesAt,
  });

  factory Competition.fromJson(Map<String, dynamic> json) => Competition(
    id: json['id'] as String,
    name: json['name'] as String,
    gameName: json['gameName'] as String,
    organizerName: json['organizerName'] as String,
    format: CompetitionFormat.parse(json['format'] as String),
    status: CompetitionStatus.parse(json['status'] as String),
    maxEntries: json['maxEntries'] as int,
    entryCount: json['entryCount'] as int,
    entryType: json['entryType'] == 'paid' ? EntryType.paid : EntryType.free,
    entryFeeMinor: json['entryFeeMinor'] as int? ?? 0,
    currency: json['currency'] as String,
    prizeAmountMinor: json['prizeAmountMinor'] as int? ?? 0,
    startsAt: DateTime.parse(json['startsAt'] as String),
    registrationClosesAt: _date(json['registrationClosesAt']),
  );

  final String id;
  final String name;
  final String gameName;
  final String organizerName;
  final CompetitionFormat format;
  final CompetitionStatus status;
  final int maxEntries;
  final int entryCount;
  final EntryType entryType;

  /// In the currency's minor units; zero for free entry.
  final int entryFeeMinor;
  final String currency;

  /// In minor units; zero when there is no prize.
  final int prizeAmountMinor;
  final DateTime startsAt;
  final DateTime? registrationClosesAt;

  bool get isFull => entryCount >= maxEntries;

  static DateTime? _date(Object? value) =>
      value is String ? DateTime.parse(value) : null;
}

enum EntryType { free, paid }

enum CompetitionFormat {
  singleElimination('Single elimination'),
  doubleElimination('Double elimination'),
  roundRobin('Round robin'),
  unknown('Competition');

  const CompetitionFormat(this.label);

  final String label;

  static CompetitionFormat parse(String value) => switch (value) {
    'single_elimination' => singleElimination,
    'double_elimination' => doubleElimination,
    'round_robin' => roundRobin,
    _ => unknown,
  };
}

enum CompetitionStatus {
  published,
  registrationOpen,
  checkIn,
  running,
  completed,
  cancelled,
  unknown;

  static CompetitionStatus parse(String value) => switch (value) {
    'published' => published,
    'registration_open' => registrationOpen,
    'check_in' => checkIn,
    'running' => running,
    'completed' => completed,
    'cancelled' => cancelled,
    _ => unknown,
  };

  /// The query value for `GET /v1/competitions?status=`.
  String get wire => switch (this) {
    registrationOpen => 'registration_open',
    checkIn => 'check_in',
    _ => name,
  };
}
