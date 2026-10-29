import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../account/application/account_providers.dart';
import '../../../account/application/legal_links.dart';
import '../../../auth/data/models.dart';

/// The foot of a competition: its official rules, once the server serves
/// them, and that the stores take no part in it (App Store 5.3.2).
class ContestRulesFooter extends ConsumerWidget {
  const ContestRulesFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final l = context.l10n;
    final hasRules =
        ref
            .watch(legalDocumentsProvider)
            .value
            ?.any((d) => d.type == LegalDocumentType.contestRules) ??
        false;

    return Column(
      children: [
        if (hasRules)
          TextButton(
            onPressed: () async {
              final opened = await openLegalDocument(
                ref,
                LegalDocumentType.contestRules,
              );
              if (opened || !context.mounted) return;
              showMessage(context, l.profileCouldNotOpen(l.contestRules));
            },
            child: Text(l.contestRules),
          ),
        Text(
          l.contestNotSponsored,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: p.mutedForeground),
        ),
      ],
    );
  }
}
