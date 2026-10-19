import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../auth/application/auth_controller.dart';
import 'widgets/about_section.dart';
import 'widgets/account_section.dart';
import 'widgets/contact_section.dart';
import 'widgets/profile_header.dart';
import 'widgets/security_section.dart';
import 'widgets/setup_checklist.dart';
import 'widgets/sign_out_row.dart';

/// Tab 5: who the player is, what's left to set up, and every account
/// setting, each one a row that opens where it's changed.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  static const _gap = SizedBox(height: TonitsSpace.lg);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(currentPlayerProvider);
    if (player == null) return const SizedBox.shrink();
    final pendingCountry = ref.watch(
      authControllerProvider.select((s) => s.pendingCountryCode),
    );

    return HeroScaffold(
      hero: ProfileHeader(player: player),
      children: [
        if (player.status != 'active') ...[
          const Notice(
            'Your account is restricted. Contact Tonits support to find '
            'out why.',
          ),
          _gap,
        ],
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
          _gap,
        ],
        if (SetupChecklist.isNeeded(player)) ...[
          SetupChecklist(player: player),
          _gap,
        ],
        AccountSection(player: player),
        _gap,
        ContactSection(player: player),
        _gap,
        SecuritySection(player: player),
        _gap,
        const AboutSection(),
        _gap,
        const SignOutRow(),
      ],
    );
  }
}
