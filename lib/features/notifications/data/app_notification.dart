import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_notification.freezed.dart';
part 'app_notification.g.dart';

/// One inbox item (`Notification` in the OpenAPI contract), from one
/// platform event. Route on [kind] and the ids in [data], never on the
/// title or body.
@freezed
abstract class AppNotification with _$AppNotification {
  const AppNotification._();

  const factory AppNotification({
    required String id,
    @JsonKey(unknownEnumValue: NotificationCategory.unknown)
    @Default(NotificationCategory.unknown)
    NotificationCategory category,
    required String title,
    required String body,

    /// Identifiers only: `kind`, and `matchId`, `competitionId`,
    /// `paymentId` and so on as the kind needs.
    @Default(<String, Object?>{}) Map<String, Object?> data,

    /// An in-app route hint such as `/matches/{id}`; never an API path.
    String? actionUrl,
    DateTime? readAt,
    required DateTime createdAt,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);

  /// The event type, such as `result.report_received`; empty on items
  /// stored before kinds existed.
  String get kind => data['kind'] as String? ?? '';

  String? get matchId => data['matchId'] as String?;
  String? get competitionId => data['competitionId'] as String?;

  bool get isRead => readAt != null;
}

/// A broad grouping for the icon. Routing uses the kind.
enum NotificationCategory {
  competition,
  match,
  result,
  account,
  payment,
  unknown,
}
