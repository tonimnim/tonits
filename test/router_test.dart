import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/app/router.dart';
import 'package:tonits/core/routes.dart';
import 'package:tonits/features/auth/application/auth_controller.dart';

void main() {
  test('restoring holds everyone on the splash', () {
    expect(redirectFor(AuthStatus.restoring, Routes.home), Routes.splash);
    expect(redirectFor(AuthStatus.restoring, Routes.splash), isNull);
  });

  test('signed out players stay on sign-in routes', () {
    expect(redirectFor(AuthStatus.signedOut, Routes.home), Routes.signIn);
    expect(redirectFor(AuthStatus.signedOut, Routes.splash), Routes.signIn);
    expect(redirectFor(AuthStatus.signedOut, Routes.register), isNull);
    expect(redirectFor(AuthStatus.signedOut, Routes.forgotPassword), isNull);
  });

  test('signed in players leave sign-in, splash and offline for Home', () {
    expect(redirectFor(AuthStatus.signedIn, Routes.signIn), Routes.home);
    expect(redirectFor(AuthStatus.signedIn, Routes.register), Routes.home);
    expect(redirectFor(AuthStatus.signedIn, Routes.splash), Routes.home);
    expect(redirectFor(AuthStatus.signedIn, Routes.offline), Routes.home);
    expect(redirectFor(AuthStatus.signedIn, Routes.rankings), isNull);
  });

  test('an unreachable API shows the offline screen', () {
    expect(redirectFor(AuthStatus.unreachable, Routes.home), Routes.offline);
    expect(redirectFor(AuthStatus.unreachable, Routes.offline), isNull);
  });
}
