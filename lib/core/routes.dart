/// Route paths, in one place so screens never hard-code strings. The router
/// itself is in `app/router.dart`.
abstract final class Routes {
  static const splash = '/';
  static const offline = '/offline';

  static const signIn = '/sign-in';
  static const register = '/sign-in/register';
  static const forgotPassword = '/sign-in/forgot-password';

  /// Shows a just-issued recovery code until the player confirms saving it.
  static const recoveryCode = '/recovery-code';

  // Bottom navigation tabs.
  static const home = '/home';
  static const competitions = '/competitions';
  static const matches = '/matches';
  static const rankings = '/rankings';
  static const profile = '/profile';

  /// A competition's detail and entry, under the Compete tab.
  static String competition(String id) => '$competitions/$id';

  /// Paying a competition's entry fee with M-Pesa.
  static String checkout(String id) => '$competitions/$id/pay';

  /// Paths reachable while signed out.
  static bool isSignedOut(String path) => path.startsWith(signIn);
}
