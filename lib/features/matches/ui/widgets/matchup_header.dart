import 'package:flutter/material.dart';

import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../data/match_room.dart';
import '../../data/match_summary.dart';

/// The two players face to face, the player always on the left, with the
/// score between them once there is one.
class MatchupHeader extends StatelessWidget {
  const MatchupHeader({super.key, required this.room});

  final MatchRoom room;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final match = room.summary;
    final confirmed = room.result?.score;
    final reported = room.verification.submitted?.score;
    final score = confirmed ?? reported;
    final preMatch = switch (room.lifecycle) {
      MatchLifecycle.assigned ||
      MatchLifecycle.readyForCheckIn ||
      MatchLifecycle.checkedIn => true,
      _ => false,
    };

    return Column(
      children: [
        Text(
          '${match.competitionName} · ${match.roundName}',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, color: p.subtleForeground),
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
              width: 104,
              child: Padding(
                padding: const EdgeInsets.only(top: 14),
                child: _Centre(
                  score: score,
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

  /// Shown above the name, such as "You".
  final String? caption;
  final bool showCheckIn;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final player = this.player;
    return Column(
      children: [
        InitialsAvatar(name: player?.displayName ?? '?', size: 60),
        const SizedBox(height: 10),
        Text(
          player?.displayName ?? 'Opponent',
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        if (caption != null || player != null)
          Text(
            caption ?? '@${player!.handle}',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13, color: p.mutedForeground),
          ),
        if (showCheckIn && player != null && player.checkedIn) ...[
          const SizedBox(height: 6),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, size: 14, color: p.good.$1),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  'Checked in',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: p.good.$1,
                  ),
                ),
              ),
            ],
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
      return Text(
        'vs',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: p.mutedForeground,
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
              fontSize: 34,
              fontWeight: FontWeight.w700,
              height: 1.1,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
        ),
        if (pens != null)
          Text(
            '${pens.$1}–${pens.$2} pens',
            style: TextStyle(fontSize: 13, color: p.subtleForeground),
          ),
        if (label != null) ...[
          const SizedBox(height: 2),
          Text(
            label!,
            style: TextStyle(fontSize: 12, color: p.mutedForeground),
          ),
        ],
      ],
    );
  }
}
