import 'package:flutter/material.dart';

import '../../../../core/countries.dart';
import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../players/ui/widgets/rating_level_label.dart';
import '../../data/ranked_player.dart';

/// One ladder row: rank, player with their level, rating and movement,
/// straight on the page (lists put hairlines between rows). The signed-in
/// player's own row is tinted so they can spot it.
class RankingRow extends StatelessWidget {
  const RankingRow({super.key, required this.player, this.isMe = false});

  final RankedPlayer player;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final flag = Country.byCode(player.countryCode)?.flag ?? '';
    final level = player.level?.label(context.l10n);
    return MergeSemantics(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: isMe
            ? BoxDecoration(
                color: p.soft,
                borderRadius: BorderRadius.circular(TonitsRadius.control),
              )
            : null,
        child: Row(
          children: [
            SizedBox(
              width: 32,
              child: Text(
                player.rank == null ? '–' : '${player.rank}',
                style: monoFont.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: p.subtleForeground,
                ),
              ),
            ),
            InitialsAvatar(name: player.displayName, size: 36),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isMe
                        ? context.l10n.rankingsYou(player.displayName)
                        : player.displayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    ['$flag @${player.handle}'.trim(), ?level].join(' · '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: p.mutedForeground),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  player.rating == null ? '—' : '${player.rating}',
                  style: monoFont.copyWith(fontWeight: FontWeight.w600),
                ),
                _Movement(player.rankMovement),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Movement extends StatelessWidget {
  const _Movement(this.places);

  final int? places;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final n = places ?? 0;
    if (n == 0) {
      return Text(
        '—',
        style: TextStyle(fontSize: 12, color: p.mutedForeground),
      );
    }
    final up = n > 0;
    final color = up ? p.good.$1 : p.destructive;
    return Semantics(
      label: up
          ? context.l10n.rankingsMovedUp(n)
          : context.l10n.rankingsMovedDown(-n),
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            up ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            size: 18,
            color: color,
          ),
          Text('${n.abs()}', style: TextStyle(fontSize: 12, color: color)),
        ],
      ),
    );
  }
}
