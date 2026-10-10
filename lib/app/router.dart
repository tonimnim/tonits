import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/routes.dart';
import '../features/auth/application/auth_controller.dart';
import '../features/auth/ui/forgot_password_screen.dart';
import '../features/auth/ui/register_screen.dart';
import '../features/auth/ui/session_screens.dart';
import '../features/auth/ui/sign_in_screen.dart';
import '../features/competitions/ui/competitions_screen.dart';
import '../features/home/ui/home_screen.dart';
import '../features/matches/ui/matches_screen.dart';
import '../features/profile/ui/profile_screen.dart';
import '../features/rankings/ui/rankings_screen.dart';
import 'shell/app_shell.dart';
import 'shell/app_tab.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // The router is built once; this notifier re-runs its redirect whenever the
  // session changes.
  final authChanges = ValueNotifier(ref.read(authControllerProvider).status);
  ref.listen(
    authControllerProvider.select((s) => s.status),
    (_, status) => authChanges.value = status,
  );
  ref.onDispose(authChanges.dispose);

  final router = GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: authChanges,
    redirect: (context, state) =>
        redirectFor(authChanges.value, state.matchedLocation),
    routes: [
      GoRoute(path: Routes.splash, builder: (_, _) => const SplashScreen()),
      GoRoute(path: Routes.offline, builder: (_, _) => const OfflineScreen()),
      GoRoute(
        path: Routes.signIn,
        builder: (_, _) => const SignInScreen(),
        routes: [
          GoRoute(path: 'register', builder: (_, _) => const RegisterScreen()),
          GoRoute(
            path: 'forgot-password',
            builder: (_, state) => ForgotPasswordScreen(
              initialKonamiId: state.extra as String? ?? '',
            ),
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (_, _, shell) => AppShell(shell: shell),
        branches: [
          for (final tab in AppTab.values)
            StatefulShellBranch(
              routes: [
                GoRoute(path: tab.path, builder: (_, _) => _tabRoot(tab)),
              ],
            ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});

Widget _tabRoot(AppTab tab) => switch (tab) {
  AppTab.home => const HomeScreen(),
  AppTab.competitions => const CompetitionsScreen(),
  AppTab.matches => const MatchesScreen(),
  AppTab.rankings => const RankingsScreen(),
  AppTab.profile => const ProfileScreen(),
};

/// Where the session allows the player to be. Null keeps them where they
/// are.
@visibleForTesting
String? redirectFor(AuthStatus status, String location) {
  final signedOutRoute = Routes.isSignedOut(location);
  return switch (status) {
    AuthStatus.restoring => location == Routes.splash ? null : Routes.splash,
    AuthStatus.unreachable =>
      location == Routes.offline ? null : Routes.offline,
    AuthStatus.signedOut => signedOutRoute ? null : Routes.signIn,
    AuthStatus.signedIn =>
      signedOutRoute || location == Routes.splash || location == Routes.offline
          ? Routes.home
          : null,
  };
}
