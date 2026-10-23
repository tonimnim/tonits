import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/l10n.dart';
import '../core/providers.dart';
import '../core/theme.dart';
import '../features/auth/application/auth_controller.dart';
import '../features/auth/application/auth_providers.dart';
import '../features/notifications/application/notifications_providers.dart';
import 'router.dart';

class TonitsApp extends ConsumerStatefulWidget {
  const TonitsApp({super.key});

  @override
  ConsumerState<TonitsApp> createState() => _TonitsAppState();
}

class _TonitsAppState extends ConsumerState<TonitsApp> {
  @override
  void initState() {
    super.initState();
    // Resume a stored session; the router shows the splash meanwhile.
    unawaited(
      Future.microtask(
        () => ref.read(authControllerProvider.notifier).restore(),
      ),
    );
    // Pushes: register this device whenever a player is signed in (every
    // sign-in and launch), and open a tapped push once they are.
    final push = ref.read(pushServiceProvider)..start();
    ref.listenManual(authControllerProvider.select((s) => s.status), (
      previous,
      status,
    ) {
      if (status == AuthStatus.signedIn && previous != AuthStatus.signedIn) {
        unawaited(push.register());
        push.openPending();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      onGenerateTitle: (context) => context.l10n.appName,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      routerConfig: ref.watch(routerProvider),
      scaffoldMessengerKey: ref.watch(scaffoldMessengerKeyProvider),
      // Status bar icons follow the theme on screens without an app bar.
      builder: (context, child) => AnnotatedRegion(
        value: systemUiFor(Theme.of(context).brightness),
        child: child!,
      ),
    );
  }
}
