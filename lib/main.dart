import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'core/api/api_client.dart';
import 'core/config.dart';
import 'features/auth/auth_controller.dart';
import 'features/auth/auth_repository.dart';
import 'features/auth/token_store.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final api = ApiClient(baseUrl: AppConfig.apiUrl);
  final auth = AuthController(
    api: api,
    repository: AuthRepository(api),
    tokenStore: SecureTokenStore(),
    deviceName: 'Tonits on ${defaultTargetPlatform.name}',
  );

  runApp(TonitsApp(auth: auth));
}
