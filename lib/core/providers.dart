import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'api/api_client.dart';
import 'config.dart';

/// Root dependencies. Tests override these with fakes.

final apiClientProvider = Provider<ApiClient>(
  (ref) => ApiClient(baseUrl: AppConfig.apiUrl),
);

/// Sent with sign-in so the player can recognise this device in their
/// session list.
final deviceNameProvider = Provider<String>(
  (ref) => switch (defaultTargetPlatform) {
    TargetPlatform.android => 'Ozone on Android',
    TargetPlatform.iOS => 'Ozone on iOS',
    final platform => 'Ozone on ${platform.name}',
  },
);

/// The app's snack bars, for messages from outside any screen, such as a
/// push that arrives while the app is open.
final scaffoldMessengerKeyProvider =
    Provider<GlobalKey<ScaffoldMessengerState>>(
      (ref) => GlobalKey<ScaffoldMessengerState>(),
    );
