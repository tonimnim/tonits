import 'package:flutter/material.dart';

import '../../../../core/countries.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../auth/data/models.dart';

/// The player's account facts, one per line.
class AccountDetailsCard extends StatelessWidget {
  const AccountDetailsCard({super.key, required this.player});

  final Player player;

  @override
  Widget build(BuildContext context) {
    final country = Country.byCode(player.countryCode);
    final active = player.status == 'active';
    return Card(
      child: Column(
        children: [
          _Row(
            label: 'Konami ID',
            child: Text(
              player.konamiId ?? '—',
              style: monoFont.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          const Divider(indent: TonitsSpace.md),
          _Row(
            label: 'Country',
            child: Text(
              country == null
                  ? player.countryCode
                  : '${country.flag}  ${country.name}',
            ),
          ),
          const Divider(indent: TonitsSpace.md),
          _Row(
            label: 'Email',
            child: player.email == null
                ? const StatusBadge('Not added', tone: StatusTone.muted)
                : StatusBadge(
                    player.emailVerified ? 'Verified' : 'Unverified',
                    tone: player.emailVerified
                        ? StatusTone.good
                        : StatusTone.warn,
                  ),
          ),
          const Divider(indent: TonitsSpace.md),
          _Row(
            label: 'Phone',
            child: player.phoneNumber == null
                ? const StatusBadge('Not added', tone: StatusTone.muted)
                : Text(player.phoneNumber!),
          ),
          const Divider(indent: TonitsSpace.md),
          _Row(
            label: 'Status',
            child: StatusBadge(
              active ? 'Active' : _humanize(player.status),
              tone: active ? StatusTone.good : StatusTone.bad,
            ),
          ),
        ],
      ),
    );
  }

  static String _humanize(String value) {
    final words = value.replaceAll('_', ' ');
    return words.isEmpty ? value : words[0].toUpperCase() + words.substring(1);
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 52),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: TonitsSpace.md,
            vertical: 12,
          ),
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(color: context.palette.subtleForeground),
              ),
              const SizedBox(width: TonitsSpace.md),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: DefaultTextStyle.merge(
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
