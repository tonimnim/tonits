import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n.dart';
import '../../../../core/routes.dart';
import '../../../../core/widgets/widgets.dart';

/// The player's competitions: what they've entered.
class EntriesSection extends StatelessWidget {
  const EntriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return SettingsGroup(
      title: l.entriesGroup,
      rows: [
        SettingsRow(
          icon: Icons.confirmation_number_outlined,
          label: l.entriesTitle,
          onTap: () => context.push(Routes.myEntries),
        ),
      ],
    );
  }
}
