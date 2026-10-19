/// Route paths, in one place so screens never hard-code strings. The router
/// itself is in `app/router.dart`.
abstract final class Routes {
  static const splash = '/';
  static const offline = '/offline';

  /// Continue with Google or Apple.
  static const welcome = '/welcome';

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

  /// The notification inbox, opened from Home's bell.
  static const notifications = '$home/notifications';

  /// A match room, under the Matches tab.
  static String match(String id) => '$matches/$id';

  /// Reporting a match's final score.
  static String reportScore(String id) => '$matches/$id/report';

  // Account settings, under the Profile tab.
  static const editName = '$profile/name';
  static const editUsername = '$profile/username';
  static const email = '$profile/email';
  static const phone = '$profile/phone';

  /// The devices signed in to the account.
  static const devices = '$profile/devices';

  /// Requesting, finishing or cancelling the account's deletion.
  static const deleteAccount = '$profile/delete';

  /// The competitions the player has entered.
  static const myEntries = '$profile/entries';

  /// Paths reachable while signed out.
  static bool isSignedOut(String path) => path.startsWith(welcome);
}
