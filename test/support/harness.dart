import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:tonits/app/app.dart';
import 'package:tonits/core/api/api_client.dart';
import 'package:tonits/core/clock.dart';
import 'package:tonits/core/providers.dart';
import 'package:tonits/features/auth/application/auth_controller.dart';

import 'fakes.dart';

/// A fake Tonits API: answers by path, with realistic defaults that a test
/// can replace per route.
class FakeApi {
  FakeApi({Map<String, http.Response Function(http.Request)>? routes})
    : routes = {..._defaults, ...?routes};

  final Map<String, http.Response Function(http.Request)> routes;
  final requests = <http.Request>[];

  late final client = MockClient((request) async {
    requests.add(request);
    final route = routes[request.url.path];
    if (route == null) return errorResponse(404, 'not_found');
    return route(request);
  });

  ApiClient api() => ApiClient(baseUrl: 'http://api.test', httpClient: client);

  static final _defaults = <String, http.Response Function(http.Request)>{
    '/v1/auth/refresh': (_) => jsonResponse(sessionJson(), 200),
    '/v1/auth/google': (_) => jsonResponse(sessionJson(), 200),
    '/v1/auth/apple': (_) => jsonResponse(sessionJson(), 200),
    '/v1/me/onboarding': (_) => jsonResponse(playerJson(), 200),
    '/v1/usernames/striker.9/availability': (_) =>
        jsonResponse({'username': 'striker.9', 'available': true}, 200),
    '/v1/usernames/$newPlayerHandle/availability': (_) =>
        jsonResponse({'username': newPlayerHandle, 'available': true}, 200),
    '/v1/auth/logout': (_) => http.Response('', 204),
    '/v1/me': (_) => jsonResponse(playerJson(), 200),
    '/v1/legal/documents/current': (_) => jsonResponse({
      'data': [
        {
          'documentType': 'terms',
          'version': '1.0',
          'contentUrl': 'https://example.test/terms',
          'effectiveAt': '2026-10-01T00:00:00Z',
        },
        {
          'documentType': 'privacy',
          'version': '1.0',
          'contentUrl': 'https://example.test/privacy',
          'effectiveAt': '2026-10-01T00:00:00Z',
        },
      ],
    }, 200),
    '/v1/competitions': (_) =>
        jsonResponse(pageJson([competitionJson(), paidCompetitionJson()]), 200),
    '/v1/competitions/c1': (_) =>
        jsonResponse({'data': competitionJson()}, 200),
    '/v1/competitions/c2': (_) =>
        jsonResponse({'data': paidCompetitionJson()}, 200),
    '/v1/competitions/c1/eligibility': (_) =>
        jsonResponse(eligibilityJson(), 200),
    '/v1/competitions/c2/eligibility': (_) =>
        jsonResponse(eligibilityJson(action: 'start_payment', fee: 10000), 200),
    '/v1/payments/mpesa/stk-push': (_) => jsonResponse(paymentJson(), 202),
    '/v1/payments/pay1': (_) => jsonResponse(paymentJson(), 200),
    '/v1/me/game-accounts': (_) => jsonResponse({
      'data': [
        {
          'id': myGameAccountId,
          'gameId': 'efootball-mobile',
          'platform': 'android',
          'inGameName': 'striker.9',
          'verificationStatus': 'unverified',
        },
      ],
    }, 200),
    '/v1/me/matches': (request) => jsonResponse(
      pageJson(
        request.url.queryParameters['state'] == 'history'
            ? [matchJson(id: 'm0', lifecycle: 'completed', outcome: 'won')]
            : [matchJson()],
      ),
      200,
    ),
    '/v1/matches/m1': (_) => jsonResponse({'data': matchRoomJson()}, 200),
    '/v1/rankings': (_) => jsonResponse({
      ...pageJson(ladderJson()),
      'snapshotAt': '2026-10-09T00:00:00Z',
    }, 200),
    '/v1/players/$myPlayerId': (_) => jsonResponse(profileJson(), 200),
    '/v1/players/$myPlayerId/matches': (_) => jsonResponse({
      ...pageJson(recentJson()),
      'snapshotAt': '2026-10-09T00:00:00Z',
    }, 200),
    '/v1/players/$myPlayerId/rating-history': (_) =>
        jsonResponse(ratingHistoryJson(), 200),
  };
}

/// Pumps the whole app against [api]. With a [refreshToken] the session
/// resumes and the app opens signed in.
Future<FakeApi> pumpTonits(
  WidgetTester tester, {
  FakeApi? api,
  String? refreshToken,
  Size size = const Size(390, 844),
  double textScale = 1,
  Brightness brightness = Brightness.light,
  Widget Function(Widget app)? wrap,
  List<Override> overrides = const [],
}) async {
  final fake = api ?? FakeApi();
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  tester.platformDispatcher.textScaleFactorTestValue = textScale;
  tester.platformDispatcher.platformBrightnessTestValue = brightness;
  addTearDown(tester.view.reset);
  addTearDown(tester.platformDispatcher.clearAllTestValues);

  final app = ProviderScope(
    overrides: [
      apiClientProvider.overrideWithValue(fake.api()),
      tokenStoreProvider.overrideWithValue(MemoryTokenStore(refreshToken)),
      googleIdentityProvider.overrideWithValue(FakeIdentity('google-token')),
      appleIdentityProvider.overrideWithValue(
        FakeIdentity('apple-token', nonce: 'raw-nonce'),
      ),
      // A fixed time, so countdowns don't keep the screen from settling.
      clockProvider.overrideWith((ref) => Stream.value(testNow)),
      ...overrides,
    ],
    // Fail fast in tests instead of backing off and retrying.
    retry: (_, _) => null,
    child: const TonitsApp(),
  );
  await tester.pumpWidget(wrap == null ? app : wrap(app));
  await tester.pumpAndSettle();
  return fake;
}

/// Scrolls the current page (its outermost scroll view, not a horizontal
/// row inside it) until [finder] is built and on screen.
Future<void> scrollPageTo(WidgetTester tester, Finder finder) => tester
    .scrollUntilVisible(finder, 200, scrollable: find.byType(Scrollable).first);
