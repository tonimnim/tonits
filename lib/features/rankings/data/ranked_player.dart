/// One row of a ranking ladder (`CompactPublicPlayer` in the contract).
class RankedPlayer {
  const RankedPlayer({
    required this.playerId,
    required this.rank,
    required this.handle,
    required this.displayName,
    required this.countryCode,
    required this.rating,
    required this.matchesPlayed,
    required this.rankMovement,
  });

  factory RankedPlayer.fromJson(Map<String, dynamic> json) => RankedPlayer(
    playerId: json['playerId'] as String,
    rank: json['rank'] as int?,
    handle: json['handle'] as String,
    displayName: json['displayName'] as String,
    countryCode: json['countryCode'] as String,
    rating: json['rating'] as int?,
    matchesPlayed: json['matchesPlayed'] as int,
    rankMovement: json['rankMovement'] as int?,
  );

  final String playerId;

  /// Null while the player is still provisional.
  final int? rank;
  final String handle;
  final String displayName;
  final String countryCode;
  final int? rating;
  final int matchesPlayed;

  /// Places gained (positive) or lost since the previous snapshot.
  final int? rankMovement;
}
