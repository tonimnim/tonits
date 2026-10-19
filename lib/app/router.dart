import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/routes.dart';
import '../features/account/ui/edit_name_screen.dart';
import '../features/account/ui/email_screen.dart';
import '../features/account/ui/phone_screen.dart';
import '../features/auth/application/auth_controller.dart';
import '../features/auth/application/auth_providers.dart';
import '../features/auth/ui/session_screens.dart';
import '../features/auth/ui/welcome_screen.dart';
import '../features/competitions/ui/competition_screen.dart';
import '../features/competitions/ui/competitions_screen.dart';
import '../features/competitions/ui/my_entries_screen.dart';
import '../features/home/ui/home_screen.dart';
import '../features/matches/ui/match_room_screen.dart';
import '../features/matches/ui/matches_screen.dart';
import '../features/matches/ui/report_score_screen.dart';
import '../features/notifications/ui/notifications_screen.dart';
import '../features/onboarding/ui/onboarding_screen.dart';
import '../features/payments/ui/checkout_screen.dart';
import '../features/profile/ui/profile_screen.dart';
import '../features/rankings/ui/rankings_screen.dart';
import 'shell/app_shell.dart';
import 'shell/app_tab.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // The router is built once; this notifier re-runs its redirect whenever the
  // session changes.
  _Gate gate(AuthState s) => (s.status, s.needsOnboarding);
  final authChanges = ValueNotifier(gate(ref.read(authControllerProvider)));
  ref.listen(
    authControllerProvider.select(gate),
    (_, value) => authChanges.value = value,
  );
  ref.onDispose(authChanges.dispose);

  final router = GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: authChanges,
    redirect: (context, state) => redirectFor(
      authChanges.value.$1,
      state.matchedLocation,
      needsOnboarding: authChanges.value.$2,
    ),
    routes: [
      GoRoute(path: Routes.splash, builder: (_, _) => const SplashScreen()),
      GoRoute(path: Routes.offline, builder: (_, _) => const OfflineScreen()),
      GoRoute(path: Routes.welcome, builder: (_, _) => const WelcomeScreen()),
      GoRoute(
        path: Routes.onboarding,
        builder: (_, _) => const OnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (_, _, shell) => AppShell(shell: shell),
        branches: [
          for (final tab in AppTab.values)
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: tab.path,
                  builder: (_, _) => _tabRoot(tab),
                  routes: _tabRoutes(tab),
                ),
              ],
            ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});

/// Screens pushed within a tab, so the bottom bar stays.
List<RouteBase> _tabRoutes(AppTab tab) => switch (tab) {
  AppTab.competitions => [
    GoRoute(
      path: ':id',
      builder: (_, state) =>
          CompetitionScreen(competitionId: state.pathParameters['id']!),
      routes: [
        GoRoute(
          path: 'pay',
          builder: (_, state) =>
              CheckoutScreen(competitionId: state.pathParameters['id']!),
        ),
      ],
    ),
  ],
  AppTab.home => [
    GoRoute(
      path: 'notifications',
      builder: (_, _) => const NotificationsScreen(),
    ),
  ],
  AppTab.matches => [
    GoRoute(
      path: ':id',
      builder: (_, state) =>
          MatchRoomScreen(matchId: state.pathParameters['id']!),
      routes: [
        GoRoute(
          path: 'report',
          builder: (_, state) =>
              ReportScoreScreen(matchId: state.pathParameters['id']!),
        ),
      ],
    ),
  ],
  AppTab.profile => [
    GoRoute(path: 'name', builder: (_, _) => const EditNameScreen()),
    GoRoute(path: 'email', builder: (_, _) => const EmailScreen()),
    GoRoute(path: 'phone', builder: (_, _) => const PhoneScreen()),
    GoRoute(path: 'entries', builder: (_, _) => const MyEntriesScreen()),
  ],
  _ => const [],
};

Widget _tabRoot(AppTab tab) => switch (tab) {
  AppTab.home => const HomeScreen(),
  AppTab.competitions => const CompetitionsScreen(),
  AppTab.matches => const MatchesScreen(),
  AppTab.rankings => const RankingsScreen(),
  AppTab.profile => const ProfileScreen(),
};

/// What the redirect depends on: the session status, and whether the
/// signed-in player still has to finish onboarding.
typedef _Gate = (AuthStatus, bool);

/// Where the session allows the player to be. Null keeps them where they
/// are.
@visibleForTesting
String? redirectFor(
  AuthStatus status,
  String location, {
  bool needsOnboarding = false,
}) {
  final signedOutRoute = Routes.isSignedOut(location);
  return switch (status) {
    AuthStatus.restoring => location == Routes.splash ? null : Routes.splash,
    AuthStatus.unreachable =>
      location == Routes.offline ? null : Routes.offline,
    AuthStatus.signedOut => signedOutRoute ? null : Routes.welcome,
    // Nothing else opens until the Konami ID, phone and country are in.
    AuthStatus.signedIn when needsOnboarding =>
      location == Routes.onboarding ? null : Routes.onboarding,
    AuthStatus.signedIn =>
      signedOutRoute ||
              location == Routes.splash ||
              location == Routes.offline ||
              location == Routes.onboarding
          ? Routes.home
          : null,
  };
}
