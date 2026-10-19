/// An uploaded screenshot and where its verification stands (`Evidence`
/// in the OpenAPI contract).
class Evidence {
  const Evidence({
    required this.id,
    required this.status,
    required this.ready,
    required this.errorCode,
  });

  factory Evidence.fromJson(Map<String, dynamic> json) => Evidence(
    id: json['id'] as String,
    status: json['status'] as String,
    ready: json['ready'] as bool? ?? false,
    errorCode: json['processingErrorCode'] as String?,
  );

  final String id;

  /// `pending`, `processing`, `completed`, `failed`, `rejected` or
  /// `expired`.
  final String status;

  /// Verified and ready to attach.
  final bool ready;
  final String? errorCode;

  /// Verification ended without a usable screenshot.
  bool get failed =>
      status == 'failed' || status == 'rejected' || status == 'expired';
}

/// A signed, short-lived permission to PUT one file to storage.
class UploadIntent {
  const UploadIntent({
    required this.id,
    required this.url,
    required this.headers,
  });

  factory UploadIntent.fromJson(Map<String, dynamic> json) => UploadIntent(
    id: json['id'] as String,
    url: Uri.parse(json['uploadUrl'] as String),
    headers: (json['requiredHeaders'] as Map<String, dynamic>).map(
      (name, value) => MapEntry(name, value as String),
    ),
  );

  final String id;
  final Uri url;

  /// Must be sent unchanged: the signature covers them.
  final Map<String, String> headers;
}
