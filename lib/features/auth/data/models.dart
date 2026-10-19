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
    this.onboardingCompleted = true,
    this.phoneVerified = false,
    this.signInMethods = const {},
  });

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    id: json['id'] as String,
    username: json['username'] as String?,
    konamiId: json['konamiId'] as String?,
    displayName: json['displayName'] as String,
    email: json['email'] as String?,
    emailVerified: json['emailVerified'] as bool? ?? false,
    phoneNumber: json['phoneNumber'] as String?,
    // Empty until onboarding for a new Google or Apple player.
    countryCode: json['countryCode'] as String? ?? '',
    status: json['status'] as String,
    // Accounts from before onboarding existed are complete.
    onboardingCompleted: json['onboardingCompleted'] as bool? ?? true,
    phoneVerified: json['phoneVerified'] as bool? ?? false,
    signInMethods: {
      for (final m in json['signInMethods'] as List? ?? const []) m as String,
    },
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

  /// False after a first Google or Apple sign-in, until the player adds
  /// their Konami ID, phone and country.
  final bool onboardingCompleted;

  /// Proven by a successful M-Pesa payment from the number.
  final bool phoneVerified;

  /// `google`, `apple` and, for test accounts, `password`.
  final Set<String> signInMethods;
}

class AuthSession {
  const AuthSession({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.player,
  });

  factory AuthSession.fromJson(Map<String, dynamic> json) => AuthSession(
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String,
    expiresIn: Duration(seconds: json['expiresInSeconds'] as int),
    player: Player.fromJson(json['player'] as Map<String, dynamic>),
  );

  final String accessToken;
  final String refreshToken;
  final Duration expiresIn;
  final Player player;
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
