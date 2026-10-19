// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_AppNotification', json, ($checkedConvert) {
      final val = _AppNotification(
        id: $checkedConvert('id', (v) => v as String),
        category: $checkedConvert(
          'category',
          (v) =>
              $enumDecodeNullable(
                _$NotificationCategoryEnumMap,
                v,
                unknownValue: NotificationCategory.unknown,
              ) ??
              NotificationCategory.unknown,
        ),
        title: $checkedConvert('title', (v) => v as String),
        body: $checkedConvert('body', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) => v as Map<String, dynamic>? ?? const <String, Object?>{},
        ),
        actionUrl: $checkedConvert('actionUrl', (v) => v as String?),
        readAt: $checkedConvert(
          'readAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => DateTime.parse(v as String),
        ),
      );
      return val;
    });

const _$NotificationCategoryEnumMap = {
  NotificationCategory.competition: 'competition',
  NotificationCategory.match: 'match',
  NotificationCategory.result: 'result',
  NotificationCategory.account: 'account',
  NotificationCategory.payment: 'payment',
  NotificationCategory.unknown: 'unknown',
};
