import '../data/competition.dart';

/// The filters on the Competitions tab. There is no "live" filter: the app
/// can't know that matches are being played right now.
enum CompetitionFilter {
  open('Open', CompetitionStatus.registrationOpen),
  upcoming('Upcoming', CompetitionStatus.published),
  finished('Finished', CompetitionStatus.completed);

  const CompetitionFilter(this.label, this.status);

  final String label;
  final CompetitionStatus status;
}
