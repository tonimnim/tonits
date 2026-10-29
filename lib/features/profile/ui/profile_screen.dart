import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../auth/application/auth_providers.dart';
import 'widgets/about_section.dart';
import 'widgets/account_section.dart';
import 'widgets/contact_section.dart';
import 'widgets/entries_section.dart';
import 'widgets/profile_header.dart';
import 'widgets/settings_section.dart';
import 'widgets/sign_out_row.dart';

/// Who the player is and every account setting, each one a row that opens
/// where it's changed. Opened from the avatar on Home.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  static const _gap = SizedBox(height: TonitsSpace.lg);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(currentPlayerProvider);
    if (player == null) return const SizedBox.shrink();

    return HeroScaffold(
      hero: ProfileHeader(player: player),
      children: [
        if (player.status != 'active') ...[
          Notice(context.l10n.profileRestricted),
          _gap,
        ],
        const EntriesSection(),
        _gap,
        AccountSection(player: player),
        _gap,
        ContactSection(player: player),
        _gap,
        const SettingsSection(),
        _gap,
        const AboutSection(),
        _gap,
        const SignOutRow(),
        _gap,
        const AppVersionLine(),
      ],
    );
  }
}
