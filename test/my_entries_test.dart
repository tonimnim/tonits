import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/app/shell/tonits_navigation_bar.dart';

import 'support/fakes.dart';
import 'support/harness.dart';
import 'support/match_room_helpers.dart';

Map<String, dynamic> _entry(
  String id,
  String name, {
  String status = 'registered',
  String competitionStatus = 'registration_open',
  String competitionId = 'c1',
  int fee = 0,
}) => {
  'id': id,
  'competitionId': competitionId,
  'competitionName': name,
  'competitionSlug': competitionId,
  'gameId': 'efootball-mobile',
  'gameName': 'eFootball Mobile',
  'displayName': 'striker.9',
  'gameAccountId': myGameAccountId,
  'status': status,
  'entryFeeMinor': fee,
  'currency': 'KES',
  'startsAt': '2027-01-14T16:00:00Z',
  'createdAt': '2026-10-01T09:00:00Z',
  'competitionStatus': competitionStatus,
};

Future<void> _openTab(WidgetTester tester, String label) async {
  await tester.tap(
    find.descendant(
      of: find.byType(TonitsNavigationBar),
      matching: find.text(label),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('My entries lists each entry with where it stands', (
    tester,
  ) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/me/registrations': (_) => jsonResponse(
            pageJson([
              _entry('r1', 'Nairobi Weekend Cup'),
              _entry('r2', 'Mombasa Masters', status: 'accepted', fee: 10000),
              _entry('r3', 'Kisumu Open', status: 'withdrawal_pending'),
              _entry('r4', 'Nakuru Derby', status: 'withdrawn'),
              _entry('r5', 'Eldoret Classic', status: 'disqualified'),
              _entry('r6', 'Thika Cup', competitionStatus: 'cancelled'),
              _entry('r7', 'October Kickoff', competitionStatus: 'completed'),
            ]),
            200,
          ),
        },
      ),
    );
    await _openTab(tester, 'Profile');
    await tapText(tester, 'My entries');

    for (final (name, standing) in [
      ('Nairobi Weekend Cup', 'Entered'),
      ('Mombasa Masters', 'Confirmed'),
      ('Kisumu Open', 'Refund pending'),
      ('Nakuru Derby', 'Withdrawn'),
      ('Eldoret Classic', 'Removed'),
      ('Thika Cup', 'Cancelled'),
      ('October Kickoff', 'Finished'),
    ]) {
      await scrollPageTo(tester, find.text(name));
      final row = find.ancestor(
        of: find.text(name),
        matching: find.byType(Row),
      );
      expect(
        find.descendant(of: row.first, matching: find.text(standing)),
        findsOneWidget,
        reason: name,
      );
    }
    await tester.drag(find.byType(Scrollable).first, const Offset(0, 2000));
    await tester.pumpAndSettle();
    expect(find.textContaining('Ksh 100'), findsOneWidget);

    await tester.tap(find.text('Nairobi Weekend Cup'));
    await tester.pumpAndSettle();
    expect(find.text('Enter for free'), findsOneWidget);
  });

  testWidgets('without entries, My entries points to the competitions', (
    tester,
  ) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/me/registrations': (_) => jsonResponse(pageJson([]), 200),
        },
      ),
    );
    await _openTab(tester, 'Profile');
    await tapText(tester, 'My entries');

    expect(find.text('No entries yet'), findsOneWidget);
    await tester.tap(find.text('Find a competition'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'Competitions'), findsOneWidget);
  });

  testWidgets('a paid entry asks for a refund to withdraw', (tester) async {
    var requested = false;
    final api = await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/competitions/c2/eligibility': (_) => jsonResponse(
            requested
                ? eligibilityJson(status: 'registered', action: 'view_refund')
                : eligibilityJson(
                    status: 'registered',
                    action: 'view_registration',
                  ),
            200,
          ),
          '/v1/competitions/c2/registrations/me/withdrawal-requests': (_) {
            requested = true;
            return jsonResponse({
              'data': {
                'id': 'rf1',
                'paymentId': 'pay1',
                'entryId': 'r2',
                'amountMinor': 10000,
                'currency': 'KES',
                'reasonCode': 'player_withdrawal',
                'mandatory': false,
                'playerNote': '',
                'status': 'requested',
                'requestedAt': testNow.toIso8601String(),
                'updatedAt': testNow.toIso8601String(),
              },
            }, 202);
          },
        },
      ),
    );
    await _openTab(tester, 'Compete');
    await tapText(tester, 'Mombasa Masters');
    expect(find.text("You're in"), findsOneWidget);

    await tester.tap(find.text('Withdraw'));
    await tester.pumpAndSettle();
    expect(find.text('Withdraw and get a refund?'), findsOneWidget);
    expect(find.textContaining('refund Ksh 100'), findsOneWidget);
    await tester.tap(find.text('Ask for refund'));
    await tester.pumpAndSettle();

    final request = api.requests.singleWhere(
      (r) => r.url.path.endsWith('/withdrawal-requests'),
    );
    expect(jsonDecode(request.body), {'reasonCode': 'player_withdrawal'});
    expect(request.headers['Idempotency-Key'], isNotEmpty);
    // A paid entry is never deleted outright.
    expect(api.requests.where((r) => r.method == 'DELETE'), isEmpty);
    expect(find.text('Refund requested.'), findsOneWidget);
    expect(find.text('Your entry fee is being refunded.'), findsOneWidget);
    expect(find.text('Withdraw'), findsNothing);
  });

  testWidgets('a closed withdrawal says why', (tester) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/competitions/c2/eligibility': (_) => jsonResponse(
            eligibilityJson(status: 'registered', action: 'view_registration'),
            200,
          ),
          '/v1/competitions/c2/registrations/me/withdrawal-requests': (_) =>
              errorResponse(409, 'withdrawal_closed'),
        },
      ),
    );
    await _openTab(tester, 'Compete');
    await tapText(tester, 'Mombasa Masters');
    await tester.tap(find.text('Withdraw'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ask for refund'));
    await tester.pumpAndSettle();

    expect(
      find.text("Registration has closed, so you can't withdraw now."),
      findsOneWidget,
    );
  });
}
