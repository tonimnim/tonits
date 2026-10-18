import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/features/competitions/data/eligibility.dart';
import 'package:tonits/features/payments/data/payment.dart';
import 'package:tonits/features/payments/ui/kenyan_phone.dart';

import 'support/fakes.dart';

void main() {
  group('Kenyan phone numbers', () {
    test('accept the ways Kenyans write them', () {
      for (final typed in [
        '0712345678',
        '0712 345 678',
        '254712345678',
        '+254 712 345 678',
        '712345678',
      ]) {
        expect(KenyanPhone.normalize(typed), '+254712345678', reason: typed);
      }
      expect(KenyanPhone.normalize('0110 123 456'), '+254110123456');
    });

    test('refuse numbers that are not Kenyan mobiles', () {
      expect(KenyanPhone.normalize('+919812345678'), isNull);
      expect(KenyanPhone.normalize('0212345678'), isNull);
      expect(KenyanPhone.normalize('07123'), isNull);
      expect(KenyanPhone.validate(''), isNotNull);
      expect(KenyanPhone.validate('0712 345 678'), isNull);
    });
  });

  group('payments', () {
    Payment payment(String status, String registration) => Payment.fromJson(
      paymentJson(status: status, registrationStatus: registration),
    );

    test('keep settling until the place is decided', () {
      expect(payment('pending', 'pending').isSettling, isTrue);
      expect(payment('callback_received', 'pending').isSettling, isTrue);
      // M-Pesa confirmed the money, but the place isn't decided yet.
      expect(payment('succeeded', 'pending').isSettling, isTrue);
      expect(payment('succeeded', 'registered').isSettling, isFalse);
      expect(payment('succeeded', 'refund_pending').isSettling, isFalse);
      expect(payment('failed', 'not_registered').isSettling, isFalse);
      // Under review is read again later, not polled fast.
      expect(payment('review', 'pending').isSettling, isFalse);
    });
  });

  test('eligibility exposes the action and the blocking reason', () {
    final e = Eligibility.fromJson(
      eligibilityJson(
            status: 'ineligible',
            action: 'none',
            fee: 10000,
            issues: [
              issueJson(
                'country_not_allowed',
                'Paid entry uses M-Pesa, which is only available to players in '
                    'Kenya.',
              ),
            ],
          )['data']
          as Map<String, dynamic>,
    );
    expect(e.requiredAction, RequiredAction.none);
    expect(e.eligible, isFalse);
    expect(e.blockingIssue!.code, 'country_not_allowed');
  });
}
