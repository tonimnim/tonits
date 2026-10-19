import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/api/error_text.dart';
import '../../../../core/l10n.dart';
import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../application/competitions_providers.dart';
import '../../application/draw_rounds.dart';
import '../../data/competition.dart';
import '../../data/draw.dart';
import 'bracket_match_row.dart';
import 'standings_table.dart';

/// A running or finished competition's draw: its final standings once
/// it's over, then a knockout's rounds, or a round robin's tables and
/// matchdays. Nothing shows before the draw is made.
class CompetitionDraw extends ConsumerWidget {
  const CompetitionDraw({super.key, required this.competitionId});

  final String competitionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bracket = ref.watch(bracketProvider(competitionId));
    final standings = ref.watch(standingsProvider(competitionId)).value;
    final me = ref.watch(myEntryIdProvider(competitionId)).value;

    return switch (bracket) {
      AsyncData(:final value) => _Draw(
        bracket: value,
        standings: standings,
        myEntryId: me,
      ),
      AsyncError(:final error) => Padding(
        padding: const EdgeInsets.only(bottom: 28),
        child: ErrorState(
          message: describeError(error, context.l10n),
          onRetry: () => ref
            ..invalidate(bracketProvider(competitionId))
            ..invalidate(standingsProvider(competitionId)),
        ),
      ),
      _ => const Padding(
        padding: EdgeInsets.only(bottom: 28),
        child: LoadingState(height: 160),
      ),
    };
  }
}

class _Draw extends StatelessWidget {
  const _Draw({required this.bracket, this.standings, this.myEntryId});

  final Bracket bracket;
  final Standings? standings;
  final String? myEntryId;

  @override
  Widget build(BuildContext context) {
    final stages = [
      for (final stage in bracket.stages)
        if (playableRounds(stage).isNotEmpty) stage,
    ]..sort((a, b) => a.position.compareTo(b.position));
    if (stages.isEmpty) return const SizedBox.shrink();
    // A round robin's table already ranks everyone.
    final roundRobin = stages.any(
      (s) => s.format == CompetitionFormat.roundRobin,
    );
    final placements = standings?.placements ?? const <Placement>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (placements.isNotEmpty && !roundRobin) ...[
          _Placements(placements: placements, myEntryId: myEntryId),
          const SizedBox(height: 28),
        ],
        for (final stage in stages) ...[
          if (stage.format == CompetitionFormat.roundRobin)
            _GroupStage(
              stage: stage,
              tables: standings?.stages
                  .where((s) => s.id == stage.id)
                  .firstOrNull,
              myEntryId: myEntryId,
            )
          else
            _KnockoutStage(stage: stage, myEntryId: myEntryId),
          const SizedBox(height: 28),
        ],
      ],
    );
  }
}

/// The podium, and the player's own placing if they finished lower.
class _Placements extends StatelessWidget {
  const _Placements({required this.placements, this.myEntryId});

  final List<Placement> placements;
  final String? myEntryId;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final shown = [
      for (final place in placements)
        if (place.placement <= 3 || place.entryId == myEntryId) place,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(title: l.drawFinalStandings),
        const SizedBox(height: TonitsSpace.sm),
        for (final (i, place) in shown.indexed) ...[
          if (i > 0) const Divider(height: 1),
          MergeSemantics(
            child: Container(
              decoration: place.entryId == myEntryId
                  ? BoxDecoration(
                      color: p.soft,
                      borderRadius: BorderRadius.circular(TonitsRadius.control),
                    )
                  : null,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: place.placement == 1 ? p.primary : p.muted,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${place.placement}',
                      semanticsLabel: l.drawPlacing(place.placement),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: place.placement == 1
                            ? p.onPrimary
                            : p.subtleForeground,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      place.entryId == myEntryId
                          ? l.rankingsYou(place.displayName)
                          : place.displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// A knockout's rounds as tabs over the matches in the chosen one.
class _KnockoutStage extends StatefulWidget {
  const _KnockoutStage({required this.stage, this.myEntryId});

  final BracketStage stage;
  final String? myEntryId;

  @override
  State<_KnockoutStage> createState() => _KnockoutStageState();
}

class _KnockoutStageState extends State<_KnockoutStage> {
  int? _picked;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final rounds = playableRounds(widget.stage);
    final selected = (_picked ?? openingRound(rounds, widget.myEntryId)).clamp(
      0,
      rounds.length - 1,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(title: l.drawBracket),
        const SizedBox(height: TonitsSpace.sm),
        ChoiceChips<int>(
          // Until the player picks, follow the opening round as their entry
          // loads, and bring it into view again.
          key: ValueKey(_picked == null ? 'opening-$selected' : 'picked'),
          options: {
            for (final (i, round) in rounds.indexed)
              i: roundTitle(round, widget.stage, l),
          },
          selected: selected,
          onChanged: (i) => setState(() => _picked = i),
        ),
        _RoundMatches(round: rounds[selected], myEntryId: widget.myEntryId),
      ],
    );
  }
}

/// A round robin: the chosen group's table, then its matchdays.
class _GroupStage extends StatefulWidget {
  const _GroupStage({required this.stage, this.tables, this.myEntryId});

  final BracketStage stage;
  final StandingsStage? tables;
  final String? myEntryId;

  @override
  State<_GroupStage> createState() => _GroupStageState();
}

class _GroupStageState extends State<_GroupStage> {
  String? _group;
  int? _matchday;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final rounds = playableRounds(widget.stage);
    final groups = widget.tables?.groups ?? const <StandingsGroup>[];
    final keys = groups.isNotEmpty
        ? [for (final g in groups) g.key]
        : {for (final r in rounds) r.bracket}.toList();
    final mine = groups
        .where((g) => g.rows.any((r) => r.entryId == widget.myEntryId))
        .firstOrNull
        ?.key;
    final group = _group ?? mine ?? keys.first;
    final table = groups.where((g) => g.key == group).firstOrNull;
    final matchdays = [
      for (final r in rounds)
        if (r.bracket == group) r,
    ];
    final series = rounds.any((r) => r.matches.any((m) => m.bestOf > 1));
    final selected = matchdays.isEmpty
        ? 0
        : (_matchday ?? openingRound(matchdays, widget.myEntryId)).clamp(
            0,
            matchdays.length - 1,
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(title: l.drawStandings),
        if (keys.length > 1) ...[
          const SizedBox(height: TonitsSpace.sm),
          ChoiceChips<String>(
            key: ValueKey(_group == null ? 'opening-$group' : 'picked'),
            options: {for (final key in keys) key: groupTitle(key, l) ?? key},
            selected: group,
            onChanged: (key) => setState(() {
              _group = key;
              _matchday = null;
            }),
          ),
        ],
        const SizedBox(height: TonitsSpace.sm),
        if (table != null)
          StandingsTable(
            group: table,
            series: series,
            myEntryId: widget.myEntryId,
          ),
        if (matchdays.isNotEmpty) ...[
          const SizedBox(height: 28),
          SectionHeader(title: l.drawMatches),
          const SizedBox(height: TonitsSpace.sm),
          ChoiceChips<int>(
            key: ValueKey(
              _matchday == null ? 'opening-$group-$selected' : 'picked-$group',
            ),
            options: {
              for (final (i, round) in matchdays.indexed)
                i: roundTitle(round, widget.stage, l),
            },
            selected: selected,
            onChanged: (i) => setState(() => _matchday = i),
          ),
          _RoundMatches(
            round: matchdays[selected],
            myEntryId: widget.myEntryId,
          ),
        ],
      ],
    );
  }
}

/// One round's matches, split by hairlines. The player's own open their
/// room.
class _RoundMatches extends StatelessWidget {
  const _RoundMatches({required this.round, this.myEntryId});

  final BracketRound round;
  final String? myEntryId;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final matches = [...round.matches]
      ..sort((a, b) => a.matchNumber.compareTo(b.matchNumber));
    final bestOf = matches
        .map((m) => m.bestOf)
        .fold(1, (a, b) => a > b ? a : b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (bestOf > 1)
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
            child: Text(
              context.l10n.seriesBestOf(bestOf),
              style: TextStyle(fontSize: 12, color: p.mutedForeground),
            ),
          ),
        const SizedBox(height: TonitsSpace.sm),
        for (final (i, match) in matches.indexed) ...[
          if (i > 0) const Divider(height: 1),
          BracketMatchRow(
            match: match,
            myEntryId: myEntryId,
            onTap: match.involves(myEntryId)
                ? () => context.go(Routes.match(match.id))
                : null,
          ),
        ],
      ],
    );
  }
}
