/// Client-side checks that mirror the API's rules, so players see mistakes
/// before a round trip. The API remains authoritative.
abstract final class AuthValidators {
  static final _username = RegExp(r'^[A-Za-z0-9][A-Za-z0-9_.]{2,23}$');
  static final _konamiId = RegExp(r'^[A-Za-z0-9][A-Za-z0-9 _.\-]{5,63}$');
  static final _alphanumeric = RegExp(r'[A-Za-z0-9]');
  static final _resetCode = RegExp(r'^[0-9]{6}$');

  static String? username(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Choose a username';
    if (v.length < 3 || v.length > 24) return 'Use 3 to 24 characters';
    if (!_username.hasMatch(v)) {
      return 'Use letters, numbers, underscores or dots, starting with a letter or number';
    }
    return null;
  }

  static String? konamiId(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Enter your Konami ID';
    if (!_konamiId.hasMatch(v) || _alphanumeric.allMatches(v).length < 6) {
      return 'Enter the Konami ID exactly as eFootball shows it';
    }
    return null;
  }

  /// For registration and new passwords. [username] and [konamiId] are
  /// compared the way the API compares them.
  static String? newPassword(
    String? value, {
    String? username,
    String? konamiId,
  }) {
    final v = value ?? '';
    final length = v.runes.length;
    if (length < 8) return 'Use at least 8 characters';
    if (length > 128) return 'Use at most 128 characters';
    final lower = v.toLowerCase();
    if (username != null && lower == username.trim().toLowerCase()) {
      return "Your password can't be your username";
    }
    if (konamiId != null &&
        normalizeKonamiId(v) == normalizeKonamiId(konamiId) &&
        normalizeKonamiId(v).isNotEmpty) {
      return "Your password can't be your Konami ID";
    }
    return null;
  }

  static String? password(String? value) =>
      (value ?? '').isEmpty ? 'Enter your password' : null;

  static String? resetCode(String? value) =>
      _resetCode.hasMatch(value?.trim() ?? '')
      ? null
      : 'Enter the 6-digit code';

  /// Case, spaces, dots, dashes and underscores don't count.
  static String normalizeKonamiId(String value) =>
      value.toLowerCase().replaceAll(RegExp(r'[\s._\-]'), '');
}
