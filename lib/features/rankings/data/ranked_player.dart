import 'package:freezed_annotation/freezed_annotation.dart';

import '../../players/data/player_profile.dart';

part 'ranked_player.freezed.dart';
part 'ranked_player.g.dart';

/// One row of a ranking ladder (`CompactPublicPlayer` in the contract).
@freezed
abstract class RankedPlayer with _$RankedPlayer {
  const factory RankedPlayer({
    required String playerId,

    /// Null while the player is still provisional.
    int? rank,
    required String handle,
    required String displayName,
    required String countryCode,
    int? rating,

    /// The rating's named band; null when [rating] is, and from servers
    /// from before levels.
    @JsonKey(unknownEnumValue: RatingLevel.unknown) RatingLevel? level,
    required int matchesPlayed,

    /// Places gained (positive) or lost since the previous snapshot.
    int? rankMovement,
  }) = _RankedPlayer;

  factory RankedPlayer.fromJson(Map<String, dynamic> json) =>
      _$RankedPlayerFromJson(json);
}
