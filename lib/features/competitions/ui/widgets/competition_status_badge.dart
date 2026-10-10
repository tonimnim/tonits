import 'package:flutter/material.dart';

import '../../../../core/widgets/widgets.dart';
import '../../data/competition.dart';

class CompetitionStatusBadge extends StatelessWidget {
  const CompetitionStatusBadge(this.status, {super.key});

  final CompetitionStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, tone) = switch (status) {
      CompetitionStatus.registrationOpen => ('Open', StatusTone.good),
      CompetitionStatus.published => ('Upcoming', StatusTone.info),
      CompetitionStatus.checkIn => ('Check-in', StatusTone.warn),
      CompetitionStatus.running => ('Live', StatusTone.info),
      CompetitionStatus.completed => ('Finished', StatusTone.muted),
      CompetitionStatus.cancelled => ('Cancelled', StatusTone.bad),
      CompetitionStatus.unknown => ('—', StatusTone.muted),
    };
    return StatusBadge(label, tone: tone);
  }
}
