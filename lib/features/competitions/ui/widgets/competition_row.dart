import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        customBorder: TonitsShape.rounded(TonitsRadius.control),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          child: Row(
            children: [
              _StartDate(c.startsAt),
              const SizedBox(width: 14),
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

/// The day a competition starts, as a small white tile, like an event
/// list's date.
class _StartDate extends StatelessWidget {
  const _StartDate(this.startsAt);

  final DateTime startsAt;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final local = startsAt.toLocal();
    return ExcludeSemantics(
      child: Container(
        width: 48,
        height: 48,
        decoration: TonitsShape.fill(p.card, 14),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              DateFormat('d').format(local),
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                height: 1.1,
              ),
            ),
            Text(
              DateFormat('MMM').format(local),
              style: TextStyle(fontSize: 11, color: p.mutedForeground),
            ),
          ],
        ),
      ),
    );
  }
}
