import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

/// The signed-in player (`Player` in the OpenAPI contract). Only the fields
/// the app uses are read.
@freezed
abstract class Player with _$Player {
  const factory Player({
    required String id,
    required String? username,
    required String? konamiId,
    required String displayName,
    required String? email,
    @Default(false) bool emailVerified,
    required String? phoneNumber,

    /// Empty until onboarding for a new Google or Apple player.
    @Default('') String countryCode,
    required String status,

    /// False after a first Google or Apple sign-in, until the player adds
    /// their Konami ID, phone and country. Accounts from before onboarding
    /// existed are complete.
    @Default(true) bool onboardingCompleted,

    /// Proven by a successful M-Pesa payment from the number.
    @Default(false) bool phoneVerified,

    /// `google`, `apple` and, for staff accounts, `password`.
    @Default(<String>{}) Set<String> signInMethods,
  }) = _Player;

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
}

@freezed
abstract class AuthSession with _$AuthSession {
  const factory AuthSession({
    required String accessToken,
    required String refreshToken,
    @JsonKey(name: 'expiresInSeconds', fromJson: _seconds)
    required Duration expiresIn,
    required Player player,
  }) = _AuthSession;

  factory AuthSession.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionFromJson(json);
}

Duration _seconds(int value) => Duration(seconds: value);

enum LegalDocumentType { terms, privacy }

/// A Terms or Privacy Notice version the player accepts.
@freezed
abstract class LegalDocument with _$LegalDocument {
  const factory LegalDocument({
    @JsonKey(name: 'documentType') required LegalDocumentType type,
    required String version,

    /// May be relative to the API origin.
    required String contentUrl,
  }) = _LegalDocument;

  factory LegalDocument.fromJson(Map<String, dynamic> json) =>
      _$LegalDocumentFromJson(json);
}
