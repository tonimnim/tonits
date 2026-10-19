import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/core/countries.dart';
import 'package:tonits/features/auth/ui/validators.dart';

import 'support/fakes.dart';

void main() {
  group('username', () {
    test('accepts the API pattern', () {
      expect(AuthValidators.username('striker.9', en), isNull);
      expect(AuthValidators.username('abc', en), isNull);
    });

    test('rejects bad lengths and characters', () {
      expect(AuthValidators.username('ab', en), isNotNull);
      expect(AuthValidators.username('a' * 25, en), isNotNull);
      expect(AuthValidators.username('_striker', en), isNotNull);
      expect(AuthValidators.username('strik er', en), isNotNull);
    });
  });

  group('konamiId', () {
    test('accepts IDs with separators', () {
      expect(AuthValidators.konamiId('ABCD-1234-EFGH', en), isNull);
      expect(AuthValidators.konamiId('abcd1234efgh', en), isNull);
    });

    test('needs six letters or digits', () {
      expect(AuthValidators.konamiId('ab-c-d', en), isNotNull);
      expect(AuthValidators.konamiId('', en), isNotNull);
    });

    test('normalizes the way the API compares', () {
      expect(
        AuthValidators.normalizeKonamiId('ABCD-1234_EF.GH '),
        AuthValidators.normalizeKonamiId('abcd1234efgh'),
      );
    });
  });

  test('reset code is six digits', () {
    expect(AuthValidators.resetCode('123456', en), isNull);
    expect(AuthValidators.resetCode('12345', en), isNotNull);
    expect(AuthValidators.resetCode('12345a', en), isNotNull);
  });

  group('countries', () {
    test('codes are unique two-letter ISO codes', () {
      final codes = Country.all.map((c) => c.code).toList();
      expect(codes.toSet().length, codes.length);
      expect(codes, everyElement(matches(RegExp(r'^[A-Z]{2}$'))));
    });

    test('launch markets resolve with their calling codes', () {
      expect(Country.byCode('ke')!.dialCode, '254');
      expect(Country.byCode('IN')!.dialCode, '91');
      expect(Country.byCode('US')!.dialCode, '1');
      expect(Country.byCode('KE')!.flag, '🇰🇪');
    });
  });
}
