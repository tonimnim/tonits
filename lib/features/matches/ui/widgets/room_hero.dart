import 'package:flutter/material.dart';

import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../data/match_room.dart';
import '../../data/match_summary.dart';

/// The room's tinted top: the round, and the two players face to face,
/// the player always on the left, with the score between them once there
/// is one.
class RoomHero extends StatelessWidget {
  const RoomHero({super.key, required this.room});

  final MatchRoom room;

  @override
  Widget build(BuildContext context) {
    final match = room.summary;
    final confirmed = room.result?.score;
    final reported = room.verification.submitted?.score;
    final preMatch = switch (room.lifecycle) {
      MatchLifecycle.assigned ||
      MatchLifecycle.readyForCheckIn ||
      MatchLifecycle.checkedIn => true,
      _ => false,
    };

    return Column(
      children: [
        Text(
          match.roundName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: TonitsSpace.lg),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _Side(
                player: match.me,
                caption: 'You',
                showCheckIn: preMatch,
              ),
            ),
            SizedBox(
              width: 96,
              child: Padding(
                padding: const EdgeInsets.only(top: 18),
                child: _Centre(
                  score: confirmed ?? reported,
                  home: match.isHome,
                  label: confirmed != null
                      ? 'Full time'
                      : reported != null
                      ? 'Reported'
                      : null,
                ),
              ),
            ),
            Expanded(
              child: _Side(
                player: match.opponent,
                caption: match.opponent == null ? 'To be decided' : null,
                showCheckIn: preMatch,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Side extends StatelessWidget {
  const _Side({
    required this.player,
    required this.caption,
    required this.showCheckIn,
  });

  final MatchParticipant? player;

  /// Shown under the name instead of the handle, such as "You".
  final String? caption;
  final bool showCheckIn;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final player = this.player;
    return Column(
      children: [
        // A card-coloured ring lifts the avatar off the tint, flat.
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(color: p.card, shape: BoxShape.circle),
          child: InitialsAvatar(name: player?.displayName ?? '?', size: 68),
        ),
        const SizedBox(height: 12),
        Text(
          player?.displayName ?? 'Opponent',
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        if (caption != null || player != null)
          Text(
            caption ?? '@${player!.handle}',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13, color: p.subtleForeground),
          ),
        if (showCheckIn && player != null && player.checkedIn) ...[
          const SizedBox(height: 8),
          Pill(
            'Checked in',
            icon: Icons.check_circle,
            color: p.good.$1,
            filled: p.card,
          ),
        ],
      ],
    );
  }
}

class _Centre extends StatelessWidget {
  const _Centre({required this.score, required this.home, this.label});

  final Score? score;
  final bool home;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final score = this.score;
    if (score == null) {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          'VS',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
            color: p.mutedForeground,
          ),
        ),
      );
    }
    final (mine, theirs) = score.forSide(home: home);
    final pens = score.penalties?.forSide(home: home);
    return Column(
      children: [
        FittedBox(
          child: Text(
            '$mine – $theirs',
            style: const TextStyle(
              fontSize: 44,
              fontWeight: FontWeight.w700,
              height: 1.05,
              letterSpacing: -1,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
        ),
        if (pens != null)
          Text(
            '${pens.$1}–${pens.$2} on pens',
            style: TextStyle(fontSize: 13, color: p.subtleForeground),
          ),
        if (label != null) ...[
          const SizedBox(height: 8),
          Pill(label!, filled: p.card),
        ],
      ],
    );
  }
}
