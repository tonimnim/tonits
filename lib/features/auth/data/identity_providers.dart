import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// A signed statement from Google or Apple of who the player is, for the
/// API to verify.
class IdentityToken {
  const IdentityToken(this.token, {this.nonce});

  final String token;

  /// The raw nonce the token was requested with, when there is one.
  final String? nonce;
}

/// Asks the platform's account picker for an identity token. Returns null
/// when the player cancels.
abstract interface class IdentityProvider {
  Future<IdentityToken?> obtain();

  /// Forgets the chosen account, so the next sign-in asks again.
  Future<void> signOut();
}

/// Google Sign-In. On Android the token's audience is the Web client ID
/// ([serverClientId]), which the API must list in GOOGLE_CLIENT_IDS.
class GoogleIdentity implements IdentityProvider {
  GoogleIdentity({this.clientId, this.serverClientId});

  final String? clientId;
  final String? serverClientId;
  Future<void>? _ready;

  Future<void> _init() => _ready ??= GoogleSignIn.instance.initialize(
    clientId: clientId,
    serverClientId: serverClientId,
  );

  @override
  Future<IdentityToken?> obtain() async {
    await _init();
    try {
      final account = await GoogleSignIn.instance.authenticate(
        scopeHint: const ['email'],
      );
      final token = account.authentication.idToken;
      return token == null ? null : IdentityToken(token);
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) return null;
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _init();
    await GoogleSignIn.instance.signOut();
  }
}

/// Sign in with Apple. Apple embeds the SHA-256 of a fresh raw nonce in the
/// token; the API gets the raw nonce to check it.
class AppleIdentity implements IdentityProvider {
  @override
  Future<IdentityToken?> obtain() async {
    final rawNonce = _randomNonce();
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: const [AppleIDAuthorizationScopes.email],
        nonce: sha256.convert(utf8.encode(rawNonce)).toString(),
      );
      final token = credential.identityToken;
      return token == null ? null : IdentityToken(token, nonce: rawNonce);
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) return null;
      rethrow;
    }
  }

  // Apple has no account to forget on the device.
  @override
  Future<void> signOut() async {}

  static String _randomNonce([int length = 32]) {
    const chars =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
      length,
      (_) => chars[random.nextInt(chars.length)],
    ).join();
  }
}
