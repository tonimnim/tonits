import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:tonits/app/shell/tonits_navigation_bar.dart';
import 'package:tonits/features/payments/application/payments_providers.dart';

import 'support/fakes.dart';
import 'support/harness.dart';

Future<void> openCompete(WidgetTester tester) async {
  await tester.tap(
    find.descendant(
      of: find.byType(TonitsNavigationBar),
      matching: find.text('Compete'),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> tapText(WidgetTester tester, String text) async {
  await tester.ensureVisible(find.text(text).last);
  await tester.pumpAndSettle();
  await tester.tap(find.text(text).last);
  await tester.pumpAndSettle();
}

/// Pumps until the payment poll has had time to run.
Future<void> letPollRun(WidgetTester tester) async {
  for (var i = 0; i < 5; i++) {
    await tester.pump(const Duration(milliseconds: 20));
  }
  await tester.pumpAndSettle();
}

final fastPolling = [
  paymentPollIntervalProvider.overrideWithValue(
    const Duration(milliseconds: 10),
  ),
];

/// A session for a player in [country].
http.Response sessionIn(String country) => jsonResponse({
  ...sessionJson(),
  'player': playerJson(countryCode: country),
}, 200);

void main() {
  testWidgets('entering a free competition', (tester) async {
    var registered = false;
    final api = await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/competitions/c1/eligibility': (_) => jsonResponse(
            registered
                ? eligibilityJson(
                    status: 'registered',
                    action: 'view_registration',
                  )
                : eligibilityJson(),
            200,
          ),
          '/v1/competitions/c1/registrations': (_) {
            registered = true;
            return jsonResponse({
              'data': {
                'id': 'r1',
                'competitionId': 'c1',
                'status': 'registered',
                'entryFeeMinor': 0,
              },
            }, 201);
          },
        },
      ),
    );
    await openCompete(tester);
    await tapText(tester, 'Nairobi Weekend Cup');

    expect(find.text('Free'), findsWidgets);
    await tapText(tester, 'Enter for free');

    final entry = api.requests.singleWhere(
      (r) => r.url.path == '/v1/competitions/c1/registrations',
    );
    expect(jsonDecode(entry.body), {'gameAccountId': myGameAccountId});
    expect(entry.headers['Idempotency-Key'], isNotEmpty);
    expect(find.text("You're in"), findsOneWidget);
    expect(find.text('Withdraw'), findsOneWidget);
  });

  testWidgets('paying with M-Pesa until the place is confirmed', (
    tester,
  ) async {
    var polls = 0;
    final api = await pumpTonits(
      tester,
      refreshToken: 'stored',
      overrides: fastPolling,
      api: FakeApi(
        routes: {
          '/v1/payments/mpesa/stk-push': (_) =>
              jsonResponse(paymentJson(), 202),
          // Pending once, then confirmed.
          '/v1/payments/pay1': (_) => jsonResponse(
            ++polls < 2
                ? paymentJson()
                : paymentJson(
                    status: 'succeeded',
                    registrationStatus: 'registered',
                  ),
            200,
          ),
        },
      ),
    );
    await openCompete(tester);
    await tapText(tester, 'Mombasa Masters');
    await tapText(tester, 'Pay Ksh 100 with M-Pesa');

    expect(find.text('Ksh 100'), findsOneWidget);
    await tester.enterText(
      find.widgetWithText(TextFormField, '0712 345 678'),
      '0712 345 678',
    );
    await tester.tap(find.text('Send payment request'));
    await tester.pump();
    await tester.pump();

    final push = api.requests.singleWhere(
      (r) => r.url.path == '/v1/payments/mpesa/stk-push',
    );
    expect(jsonDecode(push.body), {
      'competitionId': 'c2',
      'gameAccountId': myGameAccountId,
      'phoneNumber': '+254712345678',
    });
    expect(push.headers['Idempotency-Key'], isNotEmpty);
    expect(find.text('Check your phone'), findsOneWidget);

    await letPollRun(tester);
    expect(find.text("You're in"), findsOneWidget);
    expect(find.text('Paid Ksh 100. Your place is confirmed.'), findsOneWidget);
  });

  testWidgets('a declined payment can be tried again', (tester) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      overrides: fastPolling,
      api: FakeApi(
        routes: {
          '/v1/payments/mpesa/stk-push': (_) =>
              jsonResponse(paymentJson(), 202),
          '/v1/payments/pay1': (_) => jsonResponse(
            paymentJson(
              status: 'failed',
              registrationStatus: 'not_registered',
              providerMessage: 'Request cancelled by user',
            ),
            200,
          ),
        },
      ),
    );
    await openCompete(tester);
    await tapText(tester, 'Mombasa Masters');
    await tapText(tester, 'Pay Ksh 100 with M-Pesa');
    await tester.enterText(
      find.widgetWithText(TextFormField, '0712 345 678'),
      '0712345678',
    );
    await tester.tap(find.text('Send payment request'));
    await letPollRun(tester);

    expect(find.text("Payment didn't go through"), findsOneWidget);
    expect(find.text('Request cancelled by user'), findsOneWidget);
    await tapText(tester, 'Try again');
    expect(find.text('Send payment request'), findsOneWidget);
  });

  testWidgets('an unfinished payment is picked up, not charged again', (
    tester,
  ) async {
    final api = await pumpTonits(
      tester,
      refreshToken: 'stored',
      overrides: fastPolling,
      api: FakeApi(
        routes: {
          '/v1/competitions/c2/eligibility': (_) => jsonResponse(
            eligibilityJson(
              action: 'poll_payment',
              fee: 10000,
              paymentId: 'pay1',
            ),
            200,
          ),
          '/v1/payments/pay1': (_) =>
              jsonResponse(paymentJson(status: 'review'), 200),
        },
      ),
    );
    await openCompete(tester);
    await tapText(tester, 'Mombasa Masters');
    await tapText(tester, 'Check your payment');

    expect(find.text('Payment under review'), findsOneWidget);
    expect(
      api.requests.where((r) => r.url.path == '/v1/payments/mpesa/stk-push'),
      isEmpty,
    );
  });

  testWidgets('a payment already in progress is followed, not repeated', (
    tester,
  ) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      overrides: fastPolling,
      api: FakeApi(
        routes: {
          '/v1/payments/mpesa/stk-push': (_) => jsonResponse({
            'error': 'payment_in_progress',
            'message': 'A payment for this competition is in progress.',
            'paymentId': 'pay7',
            'paymentStatus': 'pending',
          }, 409),
          '/v1/payments/pay7': (_) => jsonResponse(
            paymentJson(
              id: 'pay7',
              status: 'succeeded',
              registrationStatus: 'registered',
            ),
            200,
          ),
        },
      ),
    );
    await openCompete(tester);
    await tapText(tester, 'Mombasa Masters');
    await tapText(tester, 'Pay Ksh 100 with M-Pesa');
    await tester.enterText(
      find.widgetWithText(TextFormField, '0712 345 678'),
      '0712345678',
    );
    await tester.tap(find.text('Send payment request'));
    await letPollRun(tester);

    expect(find.text("You're in"), findsOneWidget);
  });

  testWidgets('a wrong number is caught before any request', (tester) async {
    final api = await pumpTonits(tester, refreshToken: 'stored');
    await openCompete(tester);
    await tapText(tester, 'Mombasa Masters');
    await tapText(tester, 'Pay Ksh 100 with M-Pesa');
    await tester.enterText(
      find.widgetWithText(TextFormField, '0712 345 678'),
      '+91 98123 45678',
    );
    await tester.tap(find.text('Send payment request'));
    await tester.pumpAndSettle();

    expect(
      find.text('Enter a Kenyan mobile number, like 0712 345 678'),
      findsOneWidget,
    );
    expect(
      api.requests.where((r) => r.url.path == '/v1/payments/mpesa/stk-push'),
      isEmpty,
    );
  });

  testWidgets('players outside Kenya see paid entry is Kenya only', (
    tester,
  ) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/auth/refresh': (_) => sessionIn('IN'),
          '/v1/competitions/c2/eligibility': (_) => jsonResponse(
            eligibilityJson(
              status: 'ineligible',
              action: 'none',
              fee: 10000,
              issues: [
                issueJson(
                  'country_not_allowed',
                  'Paid entry uses M-Pesa, which is only available to '
                      'players in Kenya.',
                ),
              ],
            ),
            200,
          ),
        },
      ),
    );
    await openCompete(tester);

    // Marked in the list before they tap in…
    expect(find.text('Kenya only'), findsOneWidget);
    await tapText(tester, 'Mombasa Masters');

    // …and the detail explains why there's no pay button.
    expect(
      find.text(
        'Paid entry uses M-Pesa, which is only available to players in Kenya.',
      ),
      findsOneWidget,
    );
    expect(find.textContaining('with M-Pesa'), findsNothing);
  });

  testWidgets('players in Kenya see no Kenya-only mark', (tester) async {
    await pumpTonits(tester, refreshToken: 'stored');
    await openCompete(tester);
    expect(find.text('Kenya only'), findsNothing);
  });
}
