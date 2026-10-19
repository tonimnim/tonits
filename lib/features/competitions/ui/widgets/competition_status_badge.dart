import 'package:flutter/material.dart';

import '../../../../core/l10n.dart';
import '../../../../core/widgets/widgets.dart';
import '../../data/competition.dart';

class CompetitionStatusBadge extends StatelessWidget {
  const CompetitionStatusBadge(
    this.status, {
    super.key,
    this.registrationEnded = false,
  });

  final CompetitionStatus status;

  /// Shows "Closed" for an open competition whose deadline has passed.
  final bool registrationEnded;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final (label, tone) = switch (status) {
      CompetitionStatus.registrationOpen when registrationEnded => (
        l.closed,
        StatusTone.muted,
      ),
      CompetitionStatus.registrationOpen => (
        l.competitionStatusOpen,
        StatusTone.good,
      ),
      CompetitionStatus.published => (
        l.competitionStatusUpcoming,
        StatusTone.info,
      ),
      CompetitionStatus.checkIn => (
        l.competitionStatusCheckIn,
        StatusTone.warn,
      ),
      CompetitionStatus.running => (
        l.competitionStatusRunning,
        StatusTone.info,
      ),
      CompetitionStatus.completed => (
        l.competitionStatusFinished,
        StatusTone.muted,
      ),
      CompetitionStatus.cancelled => (
        l.competitionStatusCancelled,
        StatusTone.bad,
      ),
      CompetitionStatus.unknown => ('—', StatusTone.muted),
    };
    return StatusBadge(label, tone: tone);
  }
}
