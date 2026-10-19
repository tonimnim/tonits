import 'package:flutter/material.dart';

import '../../../../core/format.dart';
import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../data/competition.dart';
import 'capacity_bar.dart';
import 'competition_status_badge.dart';
import 'kenya_only_badge.dart';

/// A competition in a list: name and status, format and start, then the
/// entry fee, prize and how full it is.
class CompetitionCard extends StatelessWidget {
  const CompetitionCard({
    super.key,
    required this.competition,
    this.showStatus = true,
    this.onTap,
  });

  final Competition competition;

  /// Off where the list is already one status, such as Home's "Open for
  /// registration".
  final bool showStatus;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = competition;
    final p = context.palette;
    final l = context.l10n;
    final text = Theme.of(context).textTheme;
    final entry = c.entryType == EntryType.free || c.entryFeeMinor == 0
        ? l.competitionFreeEntry
        : l.competitionPaidEntry(Format.money(c.entryFeeMinor, c.currency));

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
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
                    CompetitionStatusBadge(
                      c.status,
                      registrationEnded: c.registrationEnded,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: TonitsSpace.xs),
              Text(
                l.competitionFormatStarts(
                  c.format.label(l),
                  Format.dateTime(c.startsAt, l),
                ),
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
                        if (c.isPaid) ...[
                          const SizedBox(height: 4),
                          KenyaOnlyBadge(competition: c),
                        ],
                        if (c.prizeAmountMinor > 0)
                          Text(
                            l.competitionPrize(
                              Format.money(c.prizeAmountMinor, c.currency),
                            ),
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
                    child: CapacityBar(
                      entries: c.entryCount,
                      max: c.maxEntries,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
