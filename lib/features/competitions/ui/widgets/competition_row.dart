import 'package:flutter/material.dart';

import '../../../../core/format.dart';
import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../data/competition.dart';
import 'kenya_only_badge.dart';

/// A competition as a row on the page: entry and urgency, name, and
/// deadline with prize.
class CompetitionRow extends StatelessWidget {
  const CompetitionRow({super.key, required this.competition, this.onTap});

  final Competition competition;
  final VoidCallback? onTap;

  /// Few enough places to say so.
  static const _scarce = 5;

  @override
  Widget build(BuildContext context) {
    final c = competition;
    final p = context.palette;
    final l = context.l10n;
    final free = c.entryType == EntryType.free || c.entryFeeMinor == 0;
    final left = c.maxEntries - c.entryCount;
    final closes = c.registrationClosesAt;

    return InkWell(
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
                  // One line: each badge shrinks rather than wrapping.
                  Row(
                    children: [
                      for (final (i, badge) in [
                        StatusBadge(
                          free
                              ? l.competitionFree
                              : Format.money(c.entryFeeMinor, c.currency),
                          tone: free ? StatusTone.good : StatusTone.info,
                        ),
                        if (c.isPaid) KenyaOnlyBadge(competition: c),
                        if (left > 0 && left <= _scarce)
                          StatusBadge(
                            l.competitionPlacesLeft(left),
                            tone: StatusTone.warn,
                          ),
                      ].indexed) ...[
                        if (i > 0) const SizedBox(width: 6),
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: badge,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    c.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    [
                      if (closes != null) Format.closesIn(closes, l),
                      if (c.prizeAmountMinor > 0)
                        l.competitionPrize(
                          Format.money(c.prizeAmountMinor, c.currency),
                        ),
                    ].join(' · '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: p.mutedForeground),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: p.mutedForeground),
          ],
        ),
      ),
    );
  }
}
