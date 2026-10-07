import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/core/countries.dart';
import 'package:tonits/features/auth/validators.dart';

void main() {
  group('username', () {
    test('accepts the API pattern', () {
      expect(AuthValidators.username('striker.9'), isNull);
      expect(AuthValidators.username('abc'), isNull);
    });

    test('rejects bad lengths and characters', () {
      expect(AuthValidators.username('ab'), isNotNull);
      expect(AuthValidators.username('a' * 25), isNotNull);
      expect(AuthValidators.username('_striker'), isNotNull);
      expect(AuthValidators.username('strik er'), isNotNull);
    });
  });

  group('konamiId', () {
    test('accepts IDs with separators', () {
      expect(AuthValidators.konamiId('ABCD-1234-EFGH'), isNull);
      expect(AuthValidators.konamiId('abcd1234efgh'), isNull);
    });

    test('needs six letters or digits', () {
      expect(AuthValidators.konamiId('ab-c-d'), isNotNull);
      expect(AuthValidators.konamiId(''), isNotNull);
    });

    test('normalizes the way the API compares', () {
      expect(
        AuthValidators.normalizeKonamiId('ABCD-1234_EF.GH '),
        AuthValidators.normalizeKonamiId('abcd1234efgh'),
      );
    });
  });

  group('newPassword', () {
    test('enforces length', () {
      expect(AuthValidators.newPassword('short'), isNotNull);
      expect(AuthValidators.newPassword('long enough'), isNull);
      expect(AuthValidators.newPassword('x' * 129), isNotNull);
    });

    test('rejects the username or Konami ID', () {
      expect(
        AuthValidators.newPassword('Striker.9x', username: 'striker.9x'),
        isNotNull,
      );
      expect(
        AuthValidators.newPassword('abcd-1234-efgh', konamiId: 'ABCD1234EFGH'),
        isNotNull,
      );
    });
  });

  test('reset code is six digits', () {
    expect(AuthValidators.resetCode('123456'), isNull);
    expect(AuthValidators.resetCode('12345'), isNotNull);
    expect(AuthValidators.resetCode('12345a'), isNotNull);
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
