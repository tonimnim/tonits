import '../../../core/l10n.dart';

/// Client-side checks that mirror the API's rules, so players see mistakes
/// before a round trip. The API remains authoritative.
abstract final class AuthValidators {
  static final _username = RegExp(r'^[A-Za-z0-9][A-Za-z0-9_.]{2,23}$');
  static final _konamiId = RegExp(r'^[A-Za-z0-9][A-Za-z0-9 _.\-]{5,63}$');
  static final _alphanumeric = RegExp(r'[A-Za-z0-9]');
  static final _code = RegExp(r'^[0-9]{6}$');

  static String? username(String? value, AppLocalizations l) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return l.validateChooseUsername;
    if (v.length < 3 || v.length > 24) return l.validateUsernameLength;
    if (!_username.hasMatch(v)) {
      return l.validateUsernameCharacters;
    }
    return null;
  }

  static String? konamiId(String? value, AppLocalizations l) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return l.validateEnterKonamiId;
    if (!_konamiId.hasMatch(v) || _alphanumeric.allMatches(v).length < 6) {
      return l.validateKonamiIdFormat;
    }
    return null;
  }

  /// A 6-digit code, such as an email verification code.
  static String? resetCode(String? value, AppLocalizations l) =>
      _code.hasMatch(value?.trim() ?? '') ? null : l.validateCode;

  /// Case, spaces, dots, dashes and underscores don't count.
  static String normalizeKonamiId(String value) =>
      value.toLowerCase().replaceAll(RegExp(r'[\s._\-]'), '');
}
