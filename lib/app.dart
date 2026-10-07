import 'package:flutter/material.dart';

import 'core/theme.dart';
import 'features/auth/auth_controller.dart';
import 'features/auth/auth_scope.dart';
import 'features/auth/sign_in_screen.dart';
import 'features/home/home_screen.dart';

class TonitsApp extends StatefulWidget {
  const TonitsApp({super.key, required this.auth, this.brandFonts = true});

  final AuthController auth;
  final bool brandFonts;

  @override
  State<TonitsApp> createState() => _TonitsAppState();
}

class _TonitsAppState extends State<TonitsApp> {
  final _navigator = GlobalKey<NavigatorState>();
  AuthStatus? _lastStatus;

  @override
  void initState() {
    super.initState();
    widget.auth.addListener(_onAuthChanged);
    widget.auth.restore();
  }

  @override
  void dispose() {
    widget.auth.removeListener(_onAuthChanged);
    super.dispose();
  }

  /// Signing in or out swaps the root screen, so drop any screens pushed on
  /// top of the old one (such as registration).
  void _onAuthChanged() {
    final status = widget.auth.status;
    if (status != _lastStatus) {
      _navigator.currentState?.popUntil((route) => route.isFirst);
    }
    _lastStatus = status;
  }

  @override
  Widget build(BuildContext context) {
    return AuthScope(
      controller: widget.auth,
      child: MaterialApp(
        title: 'Tonits',
        navigatorKey: _navigator,
        debugShowCheckedModeBanner: false,
        theme: buildTheme(brandFonts: widget.brandFonts),
        home: const _Root(),
      ),
    );
  }
}

class _Root extends StatelessWidget {
  const _Root();

  @override
  Widget build(BuildContext context) {
    final auth = AuthScope.of(context);
    return switch (auth.status) {
      AuthStatus.restoring => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      AuthStatus.unreachable => _Unreachable(onRetry: auth.restore),
      AuthStatus.signedOut => const SignInScreen(),
      AuthStatus.signedIn => const HomeScreen(),
    };
  }
}

class _Unreachable extends StatelessWidget {
  const _Unreachable({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "CAN'T REACH TONITS",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 12),
              const Text(
                "Check your connection. You're still signed in.",
                style: TextStyle(color: TonitsColors.muted),
              ),
              const SizedBox(height: 32),
              FilledButton(onPressed: onRetry, child: const Text('Try again')),
            ],
          ),
        ),
      ),
    );
  }
}
