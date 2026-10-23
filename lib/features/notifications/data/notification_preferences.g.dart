// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationPreferences _$NotificationPreferencesFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_NotificationPreferences', json, ($checkedConvert) {
  final val = _NotificationPreferences(
    matchPush: $checkedConvert('matchPush', (v) => v as bool? ?? true),
    resultPush: $checkedConvert('resultPush', (v) => v as bool? ?? true),
    competitionPush: $checkedConvert(
      'competitionPush',
      (v) => v as bool? ?? true,
    ),
    matchEmail: $checkedConvert('matchEmail', (v) => v as bool? ?? true),
    competitionEmail: $checkedConvert(
      'competitionEmail',
      (v) => v as bool? ?? true,
    ),
    marketingEmail: $checkedConvert(
      'marketingEmail',
      (v) => v as bool? ?? false,
    ),
  );
  return val;
});
