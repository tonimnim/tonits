import 'package:freezed_annotation/freezed_annotation.dart';

part 'evidence.freezed.dart';
part 'evidence.g.dart';

/// An uploaded screenshot and where its verification stands (`Evidence`
/// in the OpenAPI contract).
@freezed
abstract class Evidence with _$Evidence {
  const Evidence._();

  const factory Evidence({
    required String id,

    /// `pending`, `processing`, `completed`, `failed`, `rejected` or
    /// `expired`.
    required String status,

    /// Verified and ready to attach.
    @Default(false) bool ready,
    @JsonKey(name: 'processingErrorCode') String? errorCode,
  }) = _Evidence;

  factory Evidence.fromJson(Map<String, dynamic> json) =>
      _$EvidenceFromJson(json);

  /// Verification ended without a usable screenshot.
  bool get failed =>
      status == 'failed' || status == 'rejected' || status == 'expired';
}

/// A signed, short-lived permission to PUT one file to storage.
@freezed
abstract class UploadIntent with _$UploadIntent {
  const factory UploadIntent({
    required String id,
    @JsonKey(name: 'uploadUrl') required Uri url,

    /// Must be sent unchanged: the signature covers them.
    @JsonKey(name: 'requiredHeaders') required Map<String, String> headers,
  }) = _UploadIntent;

  factory UploadIntent.fromJson(Map<String, dynamic> json) =>
      _$UploadIntentFromJson(json);
}
