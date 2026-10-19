import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../data/auth_repository.dart';
import '../data/identity_providers.dart';
import '../data/models.dart';
import '../data/token_store.dart';
import 'auth_controller.dart';

final tokenStoreProvider = Provider<TokenStore>((ref) => SecureTokenStore());

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(ref.watch(apiClientProvider)),
);

/// Google's client IDs come from the build:
/// `--dart-define=GOOGLE_SERVER_CLIENT_ID=…` (the Web client, required on
/// Android) and `--dart-define=GOOGLE_IOS_CLIENT_ID=…`.
final googleIdentityProvider = Provider<IdentityProvider>(
  (ref) => GoogleIdentity(
    clientId: _define(const String.fromEnvironment('GOOGLE_IOS_CLIENT_ID')),
    serverClientId: _define(
      const String.fromEnvironment('GOOGLE_SERVER_CLIENT_ID'),
    ),
  ),
);

final appleIdentityProvider = Provider<IdentityProvider>(
  (ref) => AppleIdentity(),
);

/// Sign in with Apple is offered on iOS, where the App Store requires it
/// next to Google.
final appleSignInOfferedProvider = Provider<bool>(
  (ref) => defaultTargetPlatform == TargetPlatform.iOS,
);

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);

/// The signed-in player, or null for a moment while signing out (before the
/// router leaves the signed-in screens).
final currentPlayerProvider = Provider<Player?>(
  (ref) => ref.watch(authControllerProvider).player,
);

String? _define(String value) => value.isEmpty ? null : value;
