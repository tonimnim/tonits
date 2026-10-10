import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../auth/application/auth_controller.dart';
import 'widgets/account_details_card.dart';
import 'widgets/profile_header.dart';
import 'widgets/sign_out_button.dart';

/// Tab 5: who the player is, their account details and sign-out.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(currentPlayerProvider);
    if (player == null) return const SizedBox.shrink();
    final pendingCountry = ref.watch(
      authControllerProvider.select((s) => s.pendingCountryCode),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          TonitsSpace.lg,
          TonitsSpace.md,
          TonitsSpace.lg,
          TonitsSpace.xl,
        ),
        children: [
          ProfileHeader(player: player),
          const SizedBox(height: TonitsSpace.xl),
          if (pendingCountry != null) ...[
            Notice(
              "Your country wasn't saved.",
              action: TextButton(
                onPressed: () => ref
                    .read(authControllerProvider.notifier)
                    .savePendingCountry(),
                child: const Text('Retry'),
              ),
            ),
            const SizedBox(height: TonitsSpace.md),
          ],
          const SectionLabel('Account'),
          const SizedBox(height: TonitsSpace.sm),
          AccountDetailsCard(player: player),
          const SizedBox(height: TonitsSpace.xl),
          const SignOutButton(),
        ],
      ),
    );
  }
}
