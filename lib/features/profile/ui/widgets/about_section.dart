import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../account/application/legal_links.dart';
import '../../../auth/data/models.dart';

/// The Terms and Privacy Notice the player accepted.
class AboutSection extends ConsumerWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    Future<void> open(LegalDocumentType type, String name) async {
      final opened = await openLegalDocument(ref, type);
      if (opened || !context.mounted) return;
      showMessage(context, "Couldn't open the $name. Try again.");
    }

    final external = Icon(
      Icons.open_in_new_rounded,
      size: 18,
      color: p.mutedForeground,
    );
    return SettingsGroup(
      title: 'About',
      rows: [
        SettingsRow(
          icon: Icons.description_outlined,
          label: 'Terms of Service',
          trailing: external,
          onTap: () => open(LegalDocumentType.terms, 'Terms'),
        ),
        SettingsRow(
          icon: Icons.privacy_tip_outlined,
          label: 'Privacy Notice',
          trailing: external,
          onTap: () => open(LegalDocumentType.privacy, 'Privacy Notice'),
        ),
      ],
    );
  }
}
