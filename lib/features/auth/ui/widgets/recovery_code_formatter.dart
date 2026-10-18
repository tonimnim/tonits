import 'package:flutter/services.dart';

import '../validators.dart';

/// Formats a recovery code as it's typed or pasted: uppercase, letters and
/// digits only, in groups of four ("7KQ0-1XRP-…"), at most 20 characters.
class RecoveryCodeFormatter extends TextInputFormatter {
  const RecoveryCodeFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final raw = AuthValidators.normalizeRecoveryCode(newValue.text);
    final chars = raw.length > 20 ? raw.substring(0, 20) : raw;
    final grouped = [
      for (var i = 0; i < chars.length; i += 4)
        chars.substring(i, (i + 4).clamp(0, chars.length)),
    ].join('-');
    return TextEditingValue(
      text: grouped,
      selection: TextSelection.collapsed(offset: grouped.length),
    );
  }
}
