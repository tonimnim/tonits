import '../../../core/countries.dart';
import '../../payments/ui/kenyan_phone.dart';

/// Turns a number typed the local way into international (E.164) format
/// for [country]. Kenyan numbers must be mobile numbers, since M-Pesa uses
/// them; elsewhere only the length is checked and the API decides.
abstract final class PhoneNumber {
  static final _nonDigits = RegExp(r'\D');

  /// Null when it can't be a phone number.
  static String? normalize(String input, Country country) {
    if (country.code == 'KE') return KenyanPhone.normalize(input);
    final trimmed = input.trim();
    var digits = trimmed.replaceAll(_nonDigits, '');
    if (trimmed.startsWith('+') || trimmed.startsWith('00')) {
      // Already international.
      if (trimmed.startsWith('00')) digits = digits.substring(2);
    } else {
      // Drop the trunk prefix most countries dial at home.
      if (digits.startsWith('0')) digits = digits.substring(1);
      digits = '${country.dialCode}$digits';
    }
    if (digits.length < 8 || digits.length > 15) return null;
    return '+$digits';
  }

  static String? validate(String? input, Country country) {
    if ((input ?? '').trim().isEmpty) return 'Enter your phone number';
    if (normalize(input!, country) != null) return null;
    return country.code == 'KE'
        ? 'Enter a Kenyan mobile number, like 0712 345 678'
        : 'Enter a valid phone number';
  }

  /// A saved number without its calling code, the way it's typed at home.
  static String local(String international, Country country) {
    final prefix = '+${country.dialCode}';
    if (!international.startsWith(prefix)) return international;
    final national = international.substring(prefix.length);
    return country.code == 'KE' ? '0$national' : national;
  }
}
