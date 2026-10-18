import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/error_text.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../application/competitions_providers.dart';
import '../data/competition.dart';
import 'widgets/competition_facts.dart';
import 'widgets/competition_status_badge.dart';
import 'widgets/entry_bar.dart';
import 'widgets/kenya_only_badge.dart';

/// One competition: what it is, its facts, and how to enter.
class CompetitionScreen extends ConsumerWidget {
  const CompetitionScreen({super.key, required this.competitionId});

  final String competitionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final competition = ref.watch(competitionProvider(competitionId));
    return Scaffold(
      appBar: AppBar(),
      body: switch (competition) {
        AsyncData(:final value) => _Body(competition: value),
        AsyncError(:final error) => ErrorState(
          message: describeError(error),
          onRetry: () => ref.invalidate(competitionProvider(competitionId)),
        ),
        _ => const LoadingState(height: 320),
      },
      bottomNavigationBar: competition.hasValue
          ? SafeArea(
              top: false,
              child: EntryBar(competition: competition.requireValue),
            )
          : null,
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.competition});

  final Competition competition;

  @override
  Widget build(BuildContext context) {
    final c = competition;
    final p = context.palette;
    final text = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        TonitsSpace.lg,
        TonitsSpace.sm,
        TonitsSpace.lg,
        TonitsSpace.xl,
      ),
      children: [
        Wrap(
          spacing: TonitsSpace.sm,
          runSpacing: TonitsSpace.sm,
          children: [
            CompetitionStatusBadge(
              c.status,
              registrationEnded: c.registrationEnded,
            ),
            KenyaOnlyBadge(competition: c),
          ],
        ),
        const SizedBox(height: TonitsSpace.md),
        Semantics(
          header: true,
          child: Text(c.name, style: text.headlineMedium),
        ),
        const SizedBox(height: TonitsSpace.xs),
        Text(
          '${c.gameName} · by ${c.organizerName}',
          style: TextStyle(color: p.subtleForeground),
        ),
        const SizedBox(height: TonitsSpace.lg),
        CompetitionFacts(competition: c),
        if (c.description.trim().isNotEmpty) ...[
          const SizedBox(height: TonitsSpace.xl),
          const SectionLabel('About'),
          const SizedBox(height: TonitsSpace.sm),
          Text(c.description, style: text.bodyLarge),
        ],
      ],
    );
  }
}
