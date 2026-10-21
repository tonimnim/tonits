import 'package:flutter/material.dart';

import '../../../../core/format.dart';
import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../data/competition.dart';

/// A competition the player can enter, as one row on the page: its name,
/// what entry costs and when it closes, and the prize.
class CompetitionRow extends StatelessWidget {
  const CompetitionRow({super.key, required this.competition, this.onTap});

  final Competition competition;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = competition;
    final p = context.palette;
    final l = context.l10n;
    final closes = c.registrationClosesAt;
    final prize = c.prizeAmountMinor > 0
        ? Format.money(c.prizeAmountMinor, c.currency)
        : null;

    return MergeSemantics(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(TonitsRadius.control),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text.rich(
                      TextSpan(
                        children: [
                          if (c.isPaid)
                            TextSpan(
                              text: Format.money(c.entryFeeMinor, c.currency),
                            )
                          else
                            TextSpan(
                              text: l.competitionFree,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: p.good.$1,
                              ),
                            ),
                          if (closes != null)
                            TextSpan(text: ' · ${Format.closesIn(closes, l)}'),
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: p.mutedForeground),
                    ),
                  ],
                ),
              ),
              if (prize != null) ...[
                const SizedBox(width: 12),
                Semantics(
                  label: l.competitionPrize(prize),
                  excludeSemantics: true,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.emoji_events_outlined,
                        size: 16,
                        color: p.mutedForeground,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        prize,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
