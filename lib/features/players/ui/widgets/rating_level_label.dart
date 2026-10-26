import '../../../../core/l10n.dart';
import '../../data/player_profile.dart';

extension RatingLevelLabel on RatingLevel {
  /// The level's name in the app's language, or null for one added after
  /// this build, which is left unsaid rather than guessed.
  String? label(AppLocalizations l) => switch (this) {
    RatingLevel.beginner => l.playerLevelBeginner,
    RatingLevel.amateur => l.playerLevelAmateur,
    RatingLevel.semiPro => l.playerLevelSemiPro,
    RatingLevel.professional => l.playerLevelProfessional,
    RatingLevel.worldClass => l.playerLevelWorldClass,
    RatingLevel.legend => l.playerLevelLegend,
    RatingLevel.unknown => null,
  };
}
