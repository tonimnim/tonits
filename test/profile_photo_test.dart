import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:tonits/core/widgets/widgets.dart';
import 'package:tonits/features/account/application/account_providers.dart';
import 'package:tonits/features/profile/ui/widgets/profile_photo.dart';

import 'support/fakes.dart';
import 'support/harness.dart';

const _photoUrl = 'https://storage.test/avatars/av1?signed=1';

/// The avatar flow: declare, store, check, select. [complete] answers the
/// check.
FakeApi _api({http.Response Function()? complete}) {
  var selected = false;
  return FakeApi(
    routes: {
      '/v1/me/avatar/uploads': (_) => jsonResponse({
        'data': {
          'id': 'av1',
          'uploadUrl': 'https://storage.test/avatars/av1',
          'requiredHeaders': {'Content-Type': 'image/png'},
          'expiresAt': testNow.toIso8601String(),
        },
      }, 201),
      '/avatars/av1': (_) => http.Response('', 200),
      '/v1/me/avatar/uploads/av1/complete': (_) =>
          complete?.call() ??
          jsonResponse({
            'data': {
              'id': 'av1',
              'status': 'completed',
              'mediaType': 'image/png',
              'byteSize': pngBytes.length,
              'completedAt': testNow.toIso8601String(),
            },
          }, 200),
      '/v1/me/avatar': (request) {
        if (request.method == 'PATCH') {
          selected = true;
          return jsonResponse({
            'data': {
              'uploadId': 'av1',
              'status': 'active',
              'updatedAt': testNow.toIso8601String(),
              'accessEndpoint': '/v1/me/avatar',
            },
          }, 200);
        }
        return selected
            ? jsonResponse({
                'data': {
                  'mediaType': 'image/png',
                  'downloadUrl': _photoUrl,
                  'expiresAt': testNow.toIso8601String(),
                },
              }, 200)
            : errorResponse(404, 'avatar_not_found');
      },
    },
  );
}

Future<FakeApi> _openProfile(
  WidgetTester tester, {
  required FakeApi api,
  Uint8List? picked,
}) async {
  await pumpTonits(
    tester,
    refreshToken: 'stored',
    api: api,
    overrides: [photoPickerProvider.overrideWithValue(() async => picked)],
  );
  await openProfileFromHome(tester);
  return api;
}

Future<void> _tapPhoto(WidgetTester tester) async {
  await tester.tap(find.byType(ProfilePhoto));
  await tester.pumpAndSettle();
}

Uri? _shownPhoto(WidgetTester tester) =>
    tester.widget<InitialsAvatar>(find.byType(InitialsAvatar).first).image;

void main() {
  testWidgets('a new photo is uploaded, checked, chosen and shown', (
    tester,
  ) async {
    final api = await _openProfile(tester, api: _api(), picked: pngBytes);
    expect(_shownPhoto(tester), isNull);
    // Screen readers find it as a button.
    expect(find.bySemanticsLabel('Change photo'), findsOneWidget);

    await _tapPhoto(tester);

    final declared = jsonDecode(
      api.requests
          .singleWhere((r) => r.url.path == '/v1/me/avatar/uploads')
          .body,
    ) as Map<String, dynamic>;
    expect(declared['mediaType'], 'image/png');
    expect(declared['byteSize'], pngBytes.length);
    expect(declared['sha256'], matches(RegExp(r'^[0-9a-f]{64}$')));
    final stored = api.requests.singleWhere((r) => r.method == 'PUT');
    expect(stored.bodyBytes, pngBytes);
    // Storage is signed; the session token never goes there.
    expect(stored.headers.containsKey('Authorization'), isFalse);
    final chosen = api.requests.singleWhere((r) => r.method == 'PATCH');
    expect(jsonDecode(chosen.body), {'uploadId': 'av1'});

    expect(find.text('Photo updated'), findsOneWidget);
    expect(_shownPhoto(tester), Uri.parse(_photoUrl));
  });

  testWidgets('a file that is not a photo is refused before uploading', (
    tester,
  ) async {
    final api = await _openProfile(
      tester,
      api: _api(),
      picked: Uint8List.fromList(utf8.encode('GIF89a')),
    );
    await _tapPhoto(tester);

    expect(find.text('Use a JPEG, PNG or WebP photo.'), findsOneWidget);
    expect(
      api.requests.where((r) => r.url.path.startsWith('/v1/me/avatar/')),
      isEmpty,
    );
  });

  testWidgets('a photo the check rejects is never chosen', (tester) async {
    final api = await _openProfile(
      tester,
      api: _api(
        complete: () => errorResponse(422, 'avatar_verification_failed'),
      ),
      picked: pngBytes,
    );
    await _tapPhoto(tester);

    expect(find.text("That photo can't be used. Try another."), findsOneWidget);
    expect(api.requests.where((r) => r.method == 'PATCH'), isEmpty);
    expect(_shownPhoto(tester), isNull);
  });

  testWidgets('cancelling the picker changes nothing', (tester) async {
    final api = await _openProfile(tester, api: _api());
    await _tapPhoto(tester);

    expect(
      api.requests.where((r) => r.url.path.startsWith('/v1/me/avatar/')),
      isEmpty,
    );
  });
}
