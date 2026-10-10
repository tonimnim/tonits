import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme.dart';
import '../features/auth/application/auth_controller.dart';
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
    Future.microtask(() => ref.read(authControllerProvider.notifier).restore());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Tonits',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      routerConfig: ref.watch(routerProvider),
      // Status bar icons follow the theme on screens without an app bar.
      builder: (context, child) => AnnotatedRegion(
        value: systemUiFor(Theme.of(context).brightness),
        child: child!,
      ),
    );
  }
}
