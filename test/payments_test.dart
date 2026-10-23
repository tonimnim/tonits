import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/app/shell/tonits_navigation_bar.dart';
import 'package:tonits/features/payments/application/payments_providers.dart';

import 'support/fakes.dart';
import 'support/harness.dart';
import 'support/match_room_helpers.dart';

Future<void> _startPayment(WidgetTester tester) async {
  await tester.tap(
    find.descendant(
      of: find.byType(TonitsNavigationBar),
      matching: find.text('Compete'),
    ),
  );
  await tester.pumpAndSettle();
  await tapText(tester, 'Mombasa Masters');
  await tapText(tester, 'Pay Ksh 100 with M-Pesa');
  await tester.enterText(
    find.widgetWithText(TextFormField, '0712 345 678'),
    '0712 345 678',
  );
  await tester.tap(find.text('Send payment request'));
  await tester.pump();
  await tester.pump();
}

Map<String, dynamic> _refund(String status) => {
  'id': 'rf-$status',
  'paymentId': 'pay',
  'entryId': 'e1',
  'amountMinor': 10000,
  'currency': 'KES',
  'reasonCode': 'player_withdrawal',
  'mandatory': false,
  'playerNote': '',
  'status': status,
  'requestedAt': '2026-10-18T09:00:00Z',
  'updatedAt': '2026-10-18T09:00:00Z',
};

void main() {
  testWidgets('a payment that never settles stops being read, and can be '
      'checked again', (tester) async {
    var reads = 0;
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      overrides: [
        paymentPollIntervalProvider.overrideWithValue(
          const Duration(milliseconds: 10),
        ),
        paymentPollLimitsProvider.overrideWithValue((
          slowAfter: const Duration(milliseconds: 40),
          slow: const Duration(milliseconds: 20),
          stopAfter: const Duration(milliseconds: 100),
        )),
      ],
      api: FakeApi(
        routes: {
          '/v1/payments/mpesa/stk-push': (_) =>
              jsonResponse(paymentJson(), 202),
          '/v1/payments/pay1': (_) {
            reads++;
            return jsonResponse(paymentJson(), 200);
          },
        },
      ),
    );
    await _startPayment(tester);
    expect(find.text('Check your phone'), findsOneWidget);

    for (var i = 0; i < 20; i++) {
      await tester.pump(const Duration(milliseconds: 20));
    }
    await tester.pumpAndSettle();

    // Often at first, then less: four fast reads, three slow, then none.
    expect(reads, 7);
    expect(
      find.text(
        "Still no answer from M-Pesa. Check again in a bit. You won't be "
        'charged twice.',
      ),
      findsOneWidget,
    );
    await tester.pump(const Duration(seconds: 5));
    expect(reads, 7);

    await tapText(tester, 'Check again');
    expect(reads, greaterThan(7));
  });

  testWidgets('M-Pesa being down says so', (tester) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/payments/mpesa/stk-push': (_) =>
              errorResponse(503, 'mpesa_unavailable'),
        },
      ),
    );
    await _startPayment(tester);
    await tester.pumpAndSettle();

    expect(
      find.text("M-Pesa isn't available right now. Try again in a bit."),
      findsOneWidget,
    );
  });

  testWidgets('Payments lists each payment with where it stands, and opens '
      'its receipt', (tester) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/me/payments': (_) => jsonResponse(
            pageJson([
              {
                ...paymentJson(
                  id: 'p1',
                  status: 'succeeded',
                  registrationStatus: 'registered',
                ),
              },
              {
                ...paymentJson(
                  id: 'p2',
                  status: 'succeeded',
                  registrationStatus: 'refund_pending',
                ),
                'refund': _refund('requested'),
              },
              {
                ...paymentJson(
                  id: 'p3',
                  status: 'succeeded',
                  registrationStatus: 'refunded',
                ),
                'refund': _refund('succeeded'),
              },
              paymentJson(
                id: 'p4',
                status: 'failed',
                registrationStatus: 'not_registered',
                providerMessage: 'Request cancelled by user',
              ),
            ]),
            200,
          ),
        },
      ),
    );
    await openProfileFromHome(tester);
    await tapText(tester, 'Payments');

    for (final standing in ['Paid', 'Refund pending', 'Refunded', 'Not paid']) {
      expect(find.text(standing), findsOneWidget, reason: standing);
    }
    // The name comes from the competition when the payment lacks it.
    expect(find.text('Mombasa Masters'), findsNWidgets(4));
    await tester.tap(find.text('Paid'));
    await tester.pumpAndSettle();
    expect(find.textContaining('From +2547******78'), findsOneWidget);
    await tester.tap(find.text('Open competition'));
    await tester.pumpAndSettle();
    expect(find.text('by Ozone'), findsOneWidget);
  });

  testWidgets('a payment notification opens Payments', (tester) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/me/payments': (_) => jsonResponse(pageJson([]), 200),
          '/v1/me/notifications': (_) => jsonResponse(
            pageJson([
              notificationJson(
                category: 'payment',
                title: 'Payment received',
                body: 'Ksh 100 for Mombasa Masters.',
                data: const {'kind': 'payment.succeeded', 'paymentId': 'pay1'},
                actionUrl: '/payments/pay1',
              ),
            ]),
            200,
          ),
          '/v1/me/notifications/n1/read': (_) =>
              jsonResponse({'readAt': testNow.toIso8601String()}, 200),
        },
      ),
    );
    await tester.tap(find.byTooltip('Notifications'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Payment received'));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'Payments'), findsOneWidget);
    expect(find.text('No payments yet'), findsOneWidget);
  });
}
