import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

/// The signed-in player (`Player` in the OpenAPI contract). Only the fields
/// the app uses are read.
@freezed
abstract class Player with _$Player {
  const Player._();

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

    /// What the player can change about their public profile.
    ProfileSettings? profile,
  }) = _Player;

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  /// The @handle: the username, which the profile's handle replaces when
  /// it's changed.
  String? get handle => switch (profile?.handle ?? username) {
    final handle? when handle.isNotEmpty => handle,
    _ => null,
  };
}

/// The player's public profile settings (`ProfileInput`). Saving sends
/// every field back, so the consents travel unchanged.
@freezed
abstract class ProfileSettings with _$ProfileSettings {
  const factory ProfileSettings({
    /// The username, as `@handle`: 3 to 24 letters, digits, `_` or `.`,
    /// starting with a letter or digit.
    required String handle,
    @Default('') String bio,

    /// Shown in rankings and search, with a photo others can see.
    @Default(true) bool discoverable,
    @Default(false) bool analyticsConsent,
    @Default(false) bool scoutingConsent,
  }) = _ProfileSettings;

  factory ProfileSettings.fromJson(Map<String, dynamic> json) =>
      _$ProfileSettingsFromJson(json);
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
