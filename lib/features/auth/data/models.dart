/// The signed-in player (`Player` in the OpenAPI contract). Only the fields
/// the app uses so far are parsed.
class Player {
  const Player({
    required this.id,
    required this.username,
    required this.konamiId,
    required this.displayName,
    required this.email,
    required this.emailVerified,
    required this.phoneNumber,
    required this.countryCode,
    required this.status,
    this.recoveryCodeSet = false,
    this.recoveryCodeCreatedAt,
  });

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    id: json['id'] as String,
    username: json['username'] as String?,
    konamiId: json['konamiId'] as String?,
    displayName: json['displayName'] as String,
    email: json['email'] as String?,
    emailVerified: json['emailVerified'] as bool? ?? false,
    phoneNumber: json['phoneNumber'] as String?,
    countryCode: json['countryCode'] as String,
    status: json['status'] as String,
    recoveryCodeSet: json['recoveryCodeSet'] as bool? ?? false,
    recoveryCodeCreatedAt: json['recoveryCodeCreatedAt'] is String
        ? DateTime.parse(json['recoveryCodeCreatedAt'] as String)
        : null,
  );

  final String id;
  final String? username;
  final String? konamiId;
  final String displayName;
  final String? email;
  final bool emailVerified;
  final String? phoneNumber;
  final String countryCode;
  final String status;

  /// Whether the player has a recovery code; the code itself is never sent.
  final bool recoveryCodeSet;
  final DateTime? recoveryCodeCreatedAt;

  /// With neither a recovery code nor a verified email, a forgotten
  /// password can't be reset without support.
  bool get canRecoverAccount => recoveryCodeSet || emailVerified;

  Player withRecoveryCode(DateTime createdAt) => Player(
    id: id,
    username: username,
    konamiId: konamiId,
    displayName: displayName,
    email: email,
    emailVerified: emailVerified,
    phoneNumber: phoneNumber,
    countryCode: countryCode,
    status: status,
    recoveryCodeSet: true,
    recoveryCodeCreatedAt: createdAt,
  );
}

class AuthSession {
  const AuthSession({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.player,
    this.recoveryCode,
  });

  factory AuthSession.fromJson(Map<String, dynamic> json) => AuthSession(
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String,
    expiresIn: Duration(seconds: json['expiresInSeconds'] as int),
    player: Player.fromJson(json['player'] as Map<String, dynamic>),
    recoveryCode: json['recoveryCode'] as String?,
  );

  final String accessToken;
  final String refreshToken;
  final Duration expiresIn;
  final Player player;

  /// Sent once, by registration and by a recovery-code reset: the server
  /// keeps only its hash, so this is the only chance to show it.
  final String? recoveryCode;
}

/// A recovery code issued from the signed-in account.
class IssuedRecoveryCode {
  const IssuedRecoveryCode({required this.code, required this.createdAt});

  factory IssuedRecoveryCode.fromJson(Map<String, dynamic> json) =>
      IssuedRecoveryCode(
        code: json['recoveryCode'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  final String code;
  final DateTime createdAt;
}

enum LegalDocumentType { terms, privacy }

/// A terms or privacy-notice version the registration screen must present.
class LegalDocument {
  const LegalDocument({
    required this.type,
    required this.version,
    required this.contentUrl,
  });

  factory LegalDocument.fromJson(Map<String, dynamic> json) => LegalDocument(
    type: LegalDocumentType.values.byName(json['documentType'] as String),
    version: json['version'] as String,
    contentUrl: json['contentUrl'] as String,
  );

  final LegalDocumentType type;
  final String version;

  /// May be relative to the API origin.
  final String contentUrl;
}
