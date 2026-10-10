import 'package:flutter/material.dart';

import '../../../../core/format.dart';
import '../../../../core/theme.dart';
import '../../data/competition.dart';
import 'capacity_bar.dart';
import 'competition_status_badge.dart';

/// A competition in a list: name and status, format and start, then the
/// entry fee, prize and how full it is.
class CompetitionCard extends StatelessWidget {
  const CompetitionCard({
    super.key,
    required this.competition,
    this.showStatus = true,
  });

  final Competition competition;

  /// Off where the list is already one status, such as Home's "Open for
  /// registration".
  final bool showStatus;

  @override
  Widget build(BuildContext context) {
    final c = competition;
    final p = context.palette;
    final text = Theme.of(context).textTheme;
    final entry = c.entryType == EntryType.free || c.entryFeeMinor == 0
        ? 'Free entry'
        : '${Format.money(c.entryFeeMinor, c.currency)} entry';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(TonitsSpace.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    c.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: text.titleMedium,
                  ),
                ),
                if (showStatus) ...[
                  const SizedBox(width: TonitsSpace.sm),
                  CompetitionStatusBadge(c.status),
                ],
              ],
            ),
            const SizedBox(height: TonitsSpace.xs),
            Text(
              '${c.format.label} · Starts ${Format.dateTime(c.startsAt)}',
              style: TextStyle(fontSize: 13, color: p.subtleForeground),
            ),
            const SizedBox(height: TonitsSpace.md),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (c.prizeAmountMinor > 0)
                        Text(
                          'Prize ${Format.money(c.prizeAmountMinor, c.currency)}',
                          style: TextStyle(
                            fontSize: 13,
                            color: p.subtleForeground,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: TonitsSpace.md),
                SizedBox(
                  width: 120,
                  child: CapacityBar(entries: c.entryCount, max: c.maxEntries),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
