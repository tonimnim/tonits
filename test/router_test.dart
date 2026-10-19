import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/app/router.dart';
import 'package:tonits/core/routes.dart';
import 'package:tonits/features/auth/application/auth_controller.dart';

void main() {
  test('restoring holds everyone on the splash', () {
    expect(redirectFor(AuthStatus.restoring, Routes.home), Routes.splash);
    expect(redirectFor(AuthStatus.restoring, Routes.splash), isNull);
  });

  test('signed out players stay on the welcome routes', () {
    expect(redirectFor(AuthStatus.signedOut, Routes.home), Routes.welcome);
    expect(redirectFor(AuthStatus.signedOut, Routes.splash), Routes.welcome);
    expect(
      redirectFor(AuthStatus.signedOut, Routes.onboarding),
      Routes.welcome,
    );
  });

  test('signed in players leave welcome, splash and offline for Home', () {
    expect(redirectFor(AuthStatus.signedIn, Routes.welcome), Routes.home);
    expect(redirectFor(AuthStatus.signedIn, Routes.splash), Routes.home);
    expect(redirectFor(AuthStatus.signedIn, Routes.offline), Routes.home);
    expect(redirectFor(AuthStatus.signedIn, Routes.onboarding), Routes.home);
    expect(redirectFor(AuthStatus.signedIn, Routes.rankings), isNull);
  });

  test('an unfinished account goes to onboarding, wherever it was', () {
    for (final location in [Routes.home, Routes.welcome, Routes.profile]) {
      expect(
        redirectFor(AuthStatus.signedIn, location, needsOnboarding: true),
        Routes.onboarding,
      );
    }
    expect(
      redirectFor(
        AuthStatus.signedIn,
        Routes.onboarding,
        needsOnboarding: true,
      ),
      isNull,
    );
  });

  test('an unreachable API shows the offline screen', () {
    expect(redirectFor(AuthStatus.unreachable, Routes.home), Routes.offline);
    expect(redirectFor(AuthStatus.unreachable, Routes.offline), isNull);
  });
}
