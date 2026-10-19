import 'package:flutter/material.dart';

import '../../../../core/format.dart';
import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../data/competition.dart';
import '../../data/registration.dart';

/// One entry on the page: the competition, when it starts and what it
/// cost, with where the entry stands.
class EntryRow extends StatelessWidget {
  const EntryRow({super.key, required this.entry, this.onTap});

  final Registration entry;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final (label, tone) = _standing(l);
    final starts = entry.startsAt;

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
                  Text(
                    entry.competitionName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    [
                      if (starts != null) Format.dateTime(starts, l),
                      if (entry.isPaid)
                        Format.money(entry.entryFeeMinor, entry.currency)
                      else
                        l.competitionFree,
                    ].join(' · '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: p.mutedForeground),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            StatusBadge(label, tone: tone),
          ],
        ),
      ),
    );
  }

  /// A cancelled or finished competition says so first; otherwise the
  /// entry's own status.
  (String, StatusTone) _standing(AppLocalizations l) {
    if (entry.competitionCancelled) return (l.entryCancelled, StatusTone.muted);
    return switch (entry.status) {
      EntryStatus.withdrawn => (l.entryWithdrawn, StatusTone.muted),
      EntryStatus.disqualified => (l.entryRemoved, StatusTone.bad),
      EntryStatus.withdrawalPending => (l.entryRefundPending, StatusTone.warn),
      _ when entry.competitionStatus == CompetitionStatus.completed => (
        l.entryFinished,
        StatusTone.muted,
      ),
      EntryStatus.checkedIn => (l.entryCheckedIn, StatusTone.good),
      EntryStatus.accepted => (l.entryAccepted, StatusTone.good),
      EntryStatus.registered ||
      EntryStatus.unknown => (l.entryRegistered, StatusTone.info),
    };
  }
}
