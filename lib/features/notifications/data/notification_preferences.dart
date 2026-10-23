import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_preferences.freezed.dart';
part 'notification_preferences.g.dart';

/// Which notifications the player gets, by channel (`NotificationPreferences`).
@freezed
abstract class NotificationPreferences with _$NotificationPreferences {
  const factory NotificationPreferences({
    /// Check-ins, opponents and chat messages.
    @Default(true) bool matchPush,

    /// Scores to confirm and disputes.
    @Default(true) bool resultPush,

    /// Draws and competitions opening or closing.
    @Default(true) bool competitionPush,
    @Default(true) bool matchEmail,
    @Default(true) bool competitionEmail,

    /// Opt-in only.
    @Default(false) bool marketingEmail,
  }) = _NotificationPreferences;

  factory NotificationPreferences.fromJson(Map<String, dynamic> json) =>
      _$NotificationPreferencesFromJson(json);
}

/// One switch, by the API's name for it.
enum NotificationChannel {
  matchPush,
  resultPush,
  competitionPush,
  matchEmail,
  competitionEmail,
  marketingEmail;

  bool of(NotificationPreferences p) => switch (this) {
    matchPush => p.matchPush,
    resultPush => p.resultPush,
    competitionPush => p.competitionPush,
    matchEmail => p.matchEmail,
    competitionEmail => p.competitionEmail,
    marketingEmail => p.marketingEmail,
  };

  NotificationPreferences set(NotificationPreferences p, bool on) =>
      switch (this) {
        matchPush => p.copyWith(matchPush: on),
        resultPush => p.copyWith(resultPush: on),
        competitionPush => p.copyWith(competitionPush: on),
        matchEmail => p.copyWith(matchEmail: on),
        competitionEmail => p.copyWith(competitionEmail: on),
        marketingEmail => p.copyWith(marketingEmail: on),
      };
}
