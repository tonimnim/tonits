import '../../../core/l10n.dart';
import '../data/competition.dart';

/// The filters on the Competitions tab. There is no "live" filter: the app
/// can't know that matches are being played right now.
enum CompetitionFilter {
  open(CompetitionStatus.registrationOpen),
  upcoming(CompetitionStatus.published),
  finished(CompetitionStatus.completed);

  const CompetitionFilter(this.status);

  final CompetitionStatus status;

  String label(AppLocalizations l) => switch (this) {
    open => l.competitionFilterOpen,
    upcoming => l.competitionFilterUpcoming,
    finished => l.competitionFilterFinished,
  };
}
