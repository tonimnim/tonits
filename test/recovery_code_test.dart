import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/app/router.dart';
import 'package:tonits/core/routes.dart';
import 'package:tonits/features/auth/application/auth_controller.dart';
import 'package:tonits/features/auth/ui/validators.dart';
import 'package:tonits/features/auth/ui/widgets/recovery_code_formatter.dart';

String format(String typed) => const RecoveryCodeFormatter()
    .formatEditUpdate(TextEditingValue.empty, TextEditingValue(text: typed))
    .text;

void main() {
  group('formatter', () {
    test('groups in fours as the player types', () {
      expect(format('7kq'), '7KQ');
      expect(format('7kq01'), '7KQ0-1');
      expect(format('7kq01xrp9'), '7KQ0-1XRP-9');
    });

    test('accepts a pasted code with spaces or dashes', () {
      expect(format('7kq0 1xrp 9tvd 4hnw c3ja'), '7KQ0-1XRP-9TVD-4HNW-C3JA');
      expect(format('7KQ0-1XRP-9TVD-4HNW-C3JA'), '7KQ0-1XRP-9TVD-4HNW-C3JA');
    });

    test('stops at 20 characters', () {
      expect(format('7KQ01XRP9TVD4HNWC3JAEXTRA'), '7KQ0-1XRP-9TVD-4HNW-C3JA');
    });
  });

  group('validator', () {
    test('needs all 20 characters', () {
      expect(AuthValidators.recoveryCode(''), isNotNull);
      expect(AuthValidators.recoveryCode('7KQ0-1XRP'), isNotNull);
      expect(AuthValidators.recoveryCode('7KQ0-1XRP-9TVD-4HNW-C3JA'), isNull);
    });

    test('ignores case, spaces and dashes like the server', () {
      expect(
        AuthValidators.normalizeRecoveryCode('7kq0 1xrp-9tvd 4hnw-c3ja'),
        '7KQ01XRP9TVD4HNWC3JA',
      );
    });
  });

  group('router', () {
    test('holds a player with an unsaved code on the code screen', () {
      expect(
        redirectFor(
          AuthStatus.signedIn,
          Routes.signIn,
          mustSaveRecoveryCode: true,
        ),
        Routes.recoveryCode,
      );
      expect(
        redirectFor(
          AuthStatus.signedIn,
          Routes.home,
          mustSaveRecoveryCode: true,
        ),
        Routes.recoveryCode,
      );
      expect(
        redirectFor(
          AuthStatus.signedIn,
          Routes.recoveryCode,
          mustSaveRecoveryCode: true,
        ),
        isNull,
      );
    });

    test('sends them home once the code is saved', () {
      expect(
        redirectFor(AuthStatus.signedIn, Routes.recoveryCode),
        Routes.home,
      );
    });
  });
}
