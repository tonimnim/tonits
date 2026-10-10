import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../application/auth_controller.dart';

/// Shown while a stored session is being resumed at launch.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: BrandMark(size: 48)));
  }
}

/// Shown when a stored session exists but the API can't be reached.
class OfflineScreen extends ConsumerWidget {
  const OfflineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TonitsSpace.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off_rounded, color: p.mutedForeground, size: 32),
              const SizedBox(height: TonitsSpace.md),
              Text(
                "Can't reach Tonits",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: TonitsSpace.sm),
              Text(
                "Check your connection. You're still signed in.",
                textAlign: TextAlign.center,
                style: TextStyle(color: p.subtleForeground),
              ),
              const SizedBox(height: TonitsSpace.xl),
              PrimaryButton(
                label: 'Try again',
                onPressed: () =>
                    ref.read(authControllerProvider.notifier).restore(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
