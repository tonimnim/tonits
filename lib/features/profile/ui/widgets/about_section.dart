import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n.dart';
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
    final l = context.l10n;
    Future<void> open(LegalDocumentType type, String name) async {
      final opened = await openLegalDocument(ref, type);
      if (opened || !context.mounted) return;
      showMessage(context, context.l10n.profileCouldNotOpen(name));
    }

    final external = Icon(
      Icons.open_in_new_rounded,
      size: 18,
      color: p.mutedForeground,
    );
    return SettingsGroup(
      title: l.profileAboutTitle,
      rows: [
        SettingsRow(
          icon: Icons.description_outlined,
          label: l.profileTermsOfService,
          trailing: external,
          onTap: () => open(LegalDocumentType.terms, l.accountLegalTerms),
        ),
        SettingsRow(
          icon: Icons.privacy_tip_outlined,
          label: l.accountLegalPrivacy,
          trailing: external,
          onTap: () => open(LegalDocumentType.privacy, l.accountLegalPrivacy),
        ),
      ],
    );
  }
}
