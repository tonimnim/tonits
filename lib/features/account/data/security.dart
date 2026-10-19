import 'package:freezed_annotation/freezed_annotation.dart';

part 'security.freezed.dart';
part 'security.g.dart';

/// A device signed in to the account (`PlayerSession`).
@freezed
abstract class DeviceSession with _$DeviceSession {
  const DeviceSession._();

  const factory DeviceSession({
    required String id,

    /// What the app called the device when it signed in, such as
    /// "Ozone on android". Can be empty.
    @Default('') String deviceName,
    @Default('') String userAgent,
    required DateTime createdAt,
    required DateTime lastUsedAt,
    DateTime? revokedAt,

    /// The session this request was made with: this device.
    @Default(false) bool current,
  }) = _DeviceSession;

  factory DeviceSession.fromJson(Map<String, dynamic> json) =>
      _$DeviceSessionFromJson(json);

  bool get active => revokedAt == null;
}

/// The player's latest request to delete their account
/// (`AccountDeletionRequest`).
@freezed
abstract class DeletionRequest with _$DeletionRequest {
  const factory DeletionRequest({
    required String id,
    @JsonKey(unknownEnumValue: DeletionStatus.unknown)
    required DeletionStatus status,
    required DateTime requestedAt,

    /// The end of the 24-hour wait: deleting is possible from then on.
    required DateTime executeAfter,
  }) = _DeletionRequest;

  factory DeletionRequest.fromJson(Map<String, dynamic> json) =>
      _$DeletionRequestFromJson(json);
}

enum DeletionStatus { pending, cancelled, completed, unknown }
