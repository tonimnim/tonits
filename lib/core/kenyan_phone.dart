import 'l10n.dart';

/// M-Pesa numbers: Kenyan mobile numbers, typed the way people write them
/// (0712 345 678, 254712345678, +254 712 345 678). The API is the authority
/// on whether it's a Safaricom number.
abstract final class KenyanPhone {
  static final _digits = RegExp(r'\D');

  /// `+2547XXXXXXXX` or `+2541XXXXXXXX`, or null when it isn't a Kenyan
  /// mobile number.
  static String? normalize(String input) {
    final digits = input.replaceAll(_digits, '');
    final national = switch (digits) {
      _ when digits.length == 10 && digits.startsWith('0') => digits.substring(
        1,
      ),
      _ when digits.length == 12 && digits.startsWith('254') =>
        digits.substring(3),
      _ when digits.length == 9 => digits,
      _ => null,
    };
    if (national == null || !RegExp(r'^[71]\d{8}$').hasMatch(national)) {
      return null;
    }
    return '+254$national';
  }

  static String? validate(String? input, AppLocalizations l) {
    if ((input ?? '').trim().isEmpty) return l.validateEnterMpesaNumber;
    return normalize(input!) == null ? l.validateKenyanMobile : null;
  }
}
