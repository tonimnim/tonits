import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/config.dart';
import '../../../../core/l10n.dart';
import '../../../../core/providers.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../account/application/account_providers.dart';
import '../../../account/application/legal_links.dart';
import '../../../auth/data/models.dart';

/// Support, the Terms and Privacy Notice the player accepted, which the
/// stores require to stay reachable after sign-up, and the contest rules.
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
    final hasRules =
        ref
            .watch(legalDocumentsProvider)
            .value
            ?.any((d) => d.type == LegalDocumentType.contestRules) ??
        false;
    const support = AppConfig.supportEmail;
    return SettingsGroup(
      title: l.profileAboutTitle,
      rows: [
        if (support.isNotEmpty)
          SettingsRow(
            icon: Icons.support_agent_outlined,
            label: l.profileSupport,
            value: support,
            onTap: () async {
              final opened = await launchUrl(
                Uri(
                  scheme: 'mailto',
                  path: support,
                  query:
                      'subject=${Uri.encodeComponent(l.profileSupportSubject)}',
                ),
              );
              if (opened || !context.mounted) return;
              showMessage(context, l.profileSupportWriteTo(support));
            },
          ),
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
        if (hasRules)
          SettingsRow(
            icon: Icons.gavel_outlined,
            label: l.contestRules,
            trailing: external,
            onTap: () => open(LegalDocumentType.contestRules, l.contestRules),
          ),
      ],
    );
  }
}

/// This build's version, quietly at the foot of Profile, for support.
class AppVersionLine extends ConsumerWidget {
  const AppVersionLine({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final version = ref.watch(appVersionProvider).value;
    if (version == null) return const SizedBox.shrink();
    return Text(
      context.l10n.profileVersion(version),
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 12, color: context.palette.mutedForeground),
    );
  }
}
