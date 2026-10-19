import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/error_text.dart';
import '../../../core/format.dart';
import '../../../core/l10n.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../application/competitions_providers.dart';
import '../data/competition.dart';
import 'widgets/capacity_bar.dart';
import 'widgets/competition_draw.dart';
import 'widgets/competition_status_badge.dart';
import 'widgets/entry_bar.dart';
import 'widgets/kenya_only_badge.dart';
import 'widgets/match_format_panel.dart';

/// One competition: what it is, its facts, and how to enter. Once the draw
/// is made, its bracket or tables come first.
class CompetitionScreen extends ConsumerWidget {
  const CompetitionScreen({super.key, required this.competitionId});

  final String competitionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final competition = ref.watch(competitionProvider(competitionId));
    return switch (competition) {
      AsyncData(value: final c) => HeroScaffold(
        title: c.gameName,
        hero: _Hero(competition: c),
        onRefresh: () async {
          ref
            ..invalidate(competitionProvider(competitionId))
            ..invalidate(eligibilityProvider(competitionId))
            ..invalidate(bracketProvider(competitionId))
            ..invalidate(standingsProvider(competitionId));
          await ref.read(competitionProvider(competitionId).future);
        },
        bottom: SafeArea(top: false, child: EntryBar(competition: c)),
        children: _sheet(context, c),
      ),
      AsyncError(:final error) => Scaffold(
        appBar: AppBar(),
        body: ErrorState(
          message: describeError(error, context.l10n),
          onRetry: () => ref.invalidate(competitionProvider(competitionId)),
        ),
      ),
      _ => Scaffold(appBar: AppBar(), body: const LoadingState(height: 320)),
    };
  }

  static List<Widget> _sheet(BuildContext context, Competition c) {
    final p = context.palette;
    final l = context.l10n;
    final closes = c.registrationClosesAt;
    return [
      if (_drawn.contains(c.status)) CompetitionDraw(competitionId: c.id),
      FactRow(
        children: [
          FactTile(
            icon: Icons.confirmation_number_outlined,
            label: l.competitionFactEntry,
            value: c.isPaid
                ? Format.money(c.entryFeeMinor, c.currency)
                : l.competitionFree,
          ),
          FactTile(
            icon: Icons.emoji_events_outlined,
            label: l.competitionFactPrize,
            value: c.prizeAmountMinor > 0
                ? Format.money(c.prizeAmountMinor, c.currency)
                : '—',
          ),
          FactTile(
            icon: Icons.account_tree_outlined,
            label: l.competitionFactFormat,
            value: c.format.label(l),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Panel(
        radius: TonitsRadius.tile,
        padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
        child: Column(
          children: [
            _When(
              icon: Icons.event_outlined,
              label: l.competitionStarts,
              value: Format.dateTime(c.startsAt, l),
            ),
            if (closes != null) ...[
              const Divider(indent: 50),
              _When(
                icon: Icons.how_to_reg_outlined,
                label: l.competitionRegistration,
                value: _closing(closes, l),
              ),
            ],
          ],
        ),
      ),
      const SizedBox(height: 10),
      Panel(
        radius: TonitsRadius.tile,
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l.competitionPlayers,
              style: TextStyle(fontSize: 13, color: p.mutedForeground),
            ),
            const SizedBox(height: 8),
            CapacityBar(entries: c.entryCount, max: c.maxEntries),
          ],
        ),
      ),
      if (c.matchFormat case final format? when format.hasSeries) ...[
        const SizedBox(height: 28),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: SectionLabel(l.seriesFormatTitle),
        ),
        const SizedBox(height: 10),
        MatchFormatPanel(format: format),
      ],
      if (c.description.trim().isNotEmpty) ...[
        const SizedBox(height: 28),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: SectionLabel(l.competitionAbout),
        ),
        const SizedBox(height: 10),
        Panel(
          child: Text(
            c.description,
            style: TextStyle(height: 1.55, color: p.subtleForeground),
          ),
        ),
      ],
    ];
  }

  /// Statuses a draw can exist in. A competition cancelled before its draw
  /// has none, and the section stays away.
  static const _drawn = {
    CompetitionStatus.checkIn,
    CompetitionStatus.running,
    CompetitionStatus.completed,
    CompetitionStatus.cancelled,
  };

  /// The countdown when it's close, the date when it isn't.
  static String _closing(DateTime closes, AppLocalizations l) {
    final left = closes.difference(DateTime.now());
    if (left.isNegative) return l.closed;
    if (left < const Duration(days: 3)) return Format.closesIn(closes, l);
    return l.competitionClosesOn(Format.dateTime(closes, l));
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.competition});

  final Competition competition;

  @override
  Widget build(BuildContext context) {
    final c = competition;
    final p = context.palette;
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
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
        const SizedBox(height: 14),
        Semantics(
          header: true,
          child: Text(
            c.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.8,
              height: 1.15,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          context.l10n.competitionByOrganizer(c.organizerName),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: p.subtleForeground),
        ),
      ],
    );
  }
}

/// When something happens, with its icon.
class _When extends StatelessWidget {
  const _When({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return MergeSemantics(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            IconDot(icon: icon),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(fontSize: 12, color: p.mutedForeground),
                  ),
                  Text(
                    value,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
