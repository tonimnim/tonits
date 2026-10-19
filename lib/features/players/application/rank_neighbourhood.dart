import '../../rankings/data/ranked_player.dart';

class RankNeighbourhood {
  const RankNeighbourhood(this.rows, {required this.ranked});

  final List<RankedPlayer> rows;

  /// Whether [rows] are around the player (true) or the top of the ladder.
  final bool ranked;
}
