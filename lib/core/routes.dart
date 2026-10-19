/// Route paths, in one place so screens never hard-code strings. The router
/// itself is in `app/router.dart`.
abstract final class Routes {
  static const splash = '/';
  static const offline = '/offline';

  /// Continue with Google or Apple.
  static const welcome = '/welcome';

  /// Konami ID and password, for local test accounts in debug builds.
  static const devSignIn = '/welcome/developer';

  /// Username, Konami ID, country and phone after a first sign-in.
  static const onboarding = '/onboarding';

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

  /// A match room, under the Matches tab.
  static String match(String id) => '$matches/$id';

  /// Reporting a match's final score.
  static String reportScore(String id) => '$matches/$id/report';

  // Account settings, under the Profile tab.
  static const editName = '$profile/name';
  static const email = '$profile/email';
  static const phone = '$profile/phone';

  /// Paths reachable while signed out.
  static bool isSignedOut(String path) => path.startsWith(welcome);
}
