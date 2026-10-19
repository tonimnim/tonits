import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/api/error_text.dart';
import '../../../../core/countries.dart';
import '../../../../core/l10n.dart';
import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../account/application/account_providers.dart';
import '../../../auth/data/models.dart';
import 'change_country.dart';

/// How the player appears to others: name, username, bio, country and
/// Konami ID, and whether their profile is public.
class AccountSection extends ConsumerWidget {
  const AccountSection({super.key, required this.player});

  final Player player;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final l = context.l10n;
    final country = Country.byCode(player.countryCode);
    final konamiId = player.konamiId;
    return SettingsGroup(
      title: l.profileAccountTitle,
      rows: [
        SettingsRow(
          icon: Icons.person_outline,
          label: l.accountDisplayName,
          value: player.displayName,
          onTap: () => context.push(Routes.editName),
        ),
        SettingsRow(
          icon: Icons.alternate_email,
          label: l.accountUsername,
          value: switch (player.handle) {
            final handle? => '@$handle',
            null => l.profileAdd,
          },
          onTap: () => context.push(Routes.editUsername),
        ),
        SettingsRow(
          icon: Icons.notes_outlined,
          label: l.accountBio,
          value: switch (player.profile?.bio.trim()) {
            final bio? when bio.isNotEmpty => bio,
            _ => l.profileAdd,
          },
          onTap: () => context.push(Routes.editBio),
        ),
        SettingsRow(
          icon: Icons.public,
          label: l.countryLabel,
          value: country == null
              ? player.countryCode
              : '${country.flag}  ${country.name}',
          onTap: () => changeCountry(context, ref),
        ),
        SettingsRow(
          icon: Icons.badge_outlined,
          label: l.accountKonamiIdLabel,
          value: konamiId ?? l.profileNotLinked,
          valueStyle: konamiId == null
              ? null
              : monoFont.copyWith(color: p.subtleForeground, fontSize: 14),
          trailing: konamiId == null
              ? null
              : Icon(Icons.copy_rounded, size: 18, color: p.mutedForeground),
          onTap: konamiId == null
              ? null
              : () => copyToClipboard(
                  context,
                  konamiId,
                  what: l.accountKonamiIdLabel,
                ),
        ),
        _PublicProfileRow(public: player.profile?.discoverable ?? true),
      ],
    );
  }
}

/// Whether others can find the player and see their photo. Saved as soon
/// as it's switched.
class _PublicProfileRow extends ConsumerStatefulWidget {
  const _PublicProfileRow({required this.public});

  final bool public;

  @override
  ConsumerState<_PublicProfileRow> createState() => _PublicProfileRowState();
}

class _PublicProfileRowState extends ConsumerState<_PublicProfileRow> {
  /// The switch as the player set it, until the server agrees.
  bool? _pending;

  Future<void> _set(bool public) async {
    if (_pending != null) return;
    final l = context.l10n;
    setState(() => _pending = public);
    try {
      await ref
          .read(accountServiceProvider)
          .updateProfile(discoverable: public);
      if (mounted) {
        showMessage(
          context,
          public ? l.accountProfilePublic : l.accountProfileHidden,
        );
      }
    } catch (e) {
      if (mounted) showMessage(context, describeError(e, l));
    } finally {
      if (mounted) setState(() => _pending = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final value = _pending ?? widget.public;
    return SettingsRow(
      icon: Icons.visibility_outlined,
      label: context.l10n.accountPublicProfile,
      trailing: Switch(value: value, onChanged: _pending == null ? _set : null),
      onTap: _pending == null ? () => _set(!value) : null,
    );
  }
}
