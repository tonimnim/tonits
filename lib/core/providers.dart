import 'package:flutter/foundation.dart';
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
