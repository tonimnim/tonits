/// Route paths, in one place so screens never hard-code strings. The router
/// itself is in `app/router.dart`.
abstract final class Routes {
  static const splash = '/';
  static const offline = '/offline';

  static const signIn = '/sign-in';
  static const register = '/sign-in/register';
  static const forgotPassword = '/sign-in/forgot-password';

  // Bottom navigation tabs.
  static const home = '/home';
  static const competitions = '/competitions';
  static const matches = '/matches';
  static const rankings = '/rankings';
  static const profile = '/profile';

  /// Paths reachable while signed out.
  static bool isSignedOut(String path) => path.startsWith(signIn);
}
