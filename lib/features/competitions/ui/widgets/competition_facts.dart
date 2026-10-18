import 'package:flutter/material.dart';

import '../../../../core/format.dart';
import '../../../../core/theme.dart';
import '../../data/competition.dart';
import 'capacity_bar.dart';

/// The facts a player decides on: when, the cost, the prize and the room
/// left.
class CompetitionFacts extends StatelessWidget {
  const CompetitionFacts({super.key, required this.competition});

  final Competition competition;

  @override
  Widget build(BuildContext context) {
    final c = competition;
    final closes = c.registrationClosesAt;
    final rows = [
      ('Starts', Format.dateTime(c.startsAt)),
      if (closes != null) ('Registration', _closing(closes)),
      ('Entry', c.isPaid ? Format.money(c.entryFeeMinor, c.currency) : 'Free'),
      if (c.prizeAmountMinor > 0)
        ('Prize', Format.money(c.prizeAmountMinor, c.currency)),
      ('Format', c.format.label),
    ];

    return Card(
      child: Column(
        children: [
          for (final (label, value) in rows) ...[
            _Row(label: label, value: value),
            const Divider(indent: TonitsSpace.md),
          ],
          Padding(
            padding: const EdgeInsets.all(TonitsSpace.md),
            child: CapacityBar(entries: c.entryCount, max: c.maxEntries),
          ),
        ],
      ),
    );
  }
}

/// The countdown when it's close, the date when it isn't.
String _closing(DateTime closes) {
  final left = closes.difference(DateTime.now());
  if (left.isNegative) return 'Closed';
  if (left < const Duration(days: 3)) return Format.closesIn(closes);
  return 'Closes ${Format.dateTime(closes)}';
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: TonitsSpace.md,
          vertical: 14,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 104,
              child: Text(
                label,
                style: TextStyle(color: context.palette.subtleForeground),
              ),
            ),
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.end,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
