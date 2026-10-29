// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Player _$PlayerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_Player', json, ($checkedConvert) {
  final val = _Player(
    id: $checkedConvert('id', (v) => v as String),
    username: $checkedConvert('username', (v) => v as String?),
    konamiId: $checkedConvert('konamiId', (v) => v as String?),
    displayName: $checkedConvert('displayName', (v) => v as String),
    email: $checkedConvert('email', (v) => v as String?),
    emailVerified: $checkedConvert('emailVerified', (v) => v as bool? ?? false),
    phoneNumber: $checkedConvert('phoneNumber', (v) => v as String?),
    countryCode: $checkedConvert('countryCode', (v) => v as String? ?? ''),
    status: $checkedConvert('status', (v) => v as String),
    onboardingCompleted: $checkedConvert(
      'onboardingCompleted',
      (v) => v as bool? ?? true,
    ),
    phoneVerified: $checkedConvert('phoneVerified', (v) => v as bool? ?? false),
    signInMethods: $checkedConvert(
      'signInMethods',
      (v) =>
          (v as List<dynamic>?)?.map((e) => e as String).toSet() ??
          const <String>{},
    ),
    profile: $checkedConvert(
      'profile',
      (v) => v == null
          ? null
          : ProfileSettings.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

_ProfileSettings _$ProfileSettingsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ProfileSettings', json, ($checkedConvert) {
      final val = _ProfileSettings(
        handle: $checkedConvert('handle', (v) => v as String),
        analyticsConsent: $checkedConvert(
          'analyticsConsent',
          (v) => v as bool? ?? false,
        ),
        scoutingConsent: $checkedConvert(
          'scoutingConsent',
          (v) => v as bool? ?? false,
        ),
      );
      return val;
    });

_AuthSession _$AuthSessionFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_AuthSession', json, ($checkedConvert) {
      final val = _AuthSession(
        accessToken: $checkedConvert('accessToken', (v) => v as String),
        refreshToken: $checkedConvert('refreshToken', (v) => v as String),
        expiresIn: $checkedConvert(
          'expiresInSeconds',
          (v) => _seconds((v as num).toInt()),
        ),
        player: $checkedConvert(
          'player',
          (v) => Player.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    }, fieldKeyMap: const {'expiresIn': 'expiresInSeconds'});

_LegalDocument _$LegalDocumentFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_LegalDocument', json, ($checkedConvert) {
      final val = _LegalDocument(
        type: $checkedConvert(
          'documentType',
          (v) => $enumDecode(
            _$LegalDocumentTypeEnumMap,
            v,
            unknownValue: LegalDocumentType.unknown,
          ),
        ),
        version: $checkedConvert('version', (v) => v as String),
        contentUrl: $checkedConvert('contentUrl', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'type': 'documentType'});

const _$LegalDocumentTypeEnumMap = {
  LegalDocumentType.terms: 'terms',
  LegalDocumentType.privacy: 'privacy',
  LegalDocumentType.contestRules: 'contest_rules',
  LegalDocumentType.unknown: 'unknown',
};
