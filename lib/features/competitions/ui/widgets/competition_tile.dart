import 'package:flutter/material.dart';

import '../../../../core/format.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../data/competition.dart';

/// A compact competition for a horizontal row: entry, urgency, name and
/// deadline.
class CompetitionTile extends StatelessWidget {
  const CompetitionTile({super.key, required this.competition, this.width});

  final Competition competition;
  final double? width;

  /// Few enough places to say so.
  static const _scarce = 5;

  @override
  Widget build(BuildContext context) {
    final c = competition;
    final p = context.palette;
    final free = c.entryType == EntryType.free || c.entryFeeMinor == 0;
    final left = c.maxEntries - c.entryCount;
    final closes = c.registrationClosesAt;

    return Container(
      width: width,
      padding: const EdgeInsets.all(TonitsSpace.md),
      decoration: BoxDecoration(
        color: p.card,
        borderRadius: BorderRadius.circular(TonitsRadius.card),
        border: Border.all(color: p.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: StatusBadge(
                    free ? 'Free' : Format.money(c.entryFeeMinor, c.currency),
                    tone: free ? StatusTone.good : StatusTone.info,
                  ),
                ),
              ),
              if (left > 0 && left <= _scarce) ...[
                const SizedBox(width: 8),
                StatusBadge('$left left', tone: StatusTone.warn),
              ],
            ],
          ),
          const Spacer(),
          Text(
            c.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600, height: 1.25),
          ),
          const SizedBox(height: 4),
          Text(
            [
              if (closes != null) Format.closesIn(closes),
              if (c.prizeAmountMinor > 0)
                'Prize ${Format.money(c.prizeAmountMinor, c.currency)}',
            ].join(' · '),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12, color: p.mutedForeground),
          ),
        ],
      ),
    );
  }
}
