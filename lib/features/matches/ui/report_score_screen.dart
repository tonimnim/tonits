import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../application/matches_providers.dart';
import '../application/series_draft.dart';
import '../data/match_room.dart';
import 'widgets/score_stepper.dart';

/// Reports the final score from the Full Time screen. The opponent is then
/// asked to confirm it.
class ReportScoreScreen extends ConsumerStatefulWidget {
  const ReportScoreScreen({super.key, required this.matchId});

  final String matchId;

  @override
  ConsumerState<ReportScoreScreen> createState() => _ReportScoreScreenState();
}

class _ReportScoreScreenState extends ConsumerState<ReportScoreScreen>
    with BusyState {
  SeriesDraft? _draft;
  bool _declared = false;

  Future<void> _submit(MatchRoom room, SeriesDraft draft) async {
    final l = context.l10n;
    final problem = draft.problem;
    if (problem != null) {
      setState(
        () => error = switch (problem) {
          SeriesProblem.penaltiesNeedWinner => l.matchPenaltyNeedsWinner,
          SeriesProblem.noWinnerYet => l.seriesNeedsWinner(draft.gamesToWin),
          SeriesProblem.gamesMissing => l.seriesNeedsAllGames(
            draft.bestOf,
            draft.gamesToWin,
          ),
        },
      );
      return;
    }
    final report = draft.toReport(home: room.summary.isHome);
    final sent = await runForMessage(
      () => ref
          .read(matchRoomProvider(widget.matchId).notifier)
          .reportScore(report.score, games: report.games),
    );
    if (!sent || !mounted) return;
    final opponent =
        room.summary.opponent?.displayName ?? l.matchYourOpponentStart;
    popWithMessage(
      context,
      l.matchScoreSent(opponent, room.windows.confirm.inMinutes),
    );
  }

  void _edit(SeriesDraft draft) => setState(() {
    _draft = draft;
    error = null;
  });

  @override
  Widget build(BuildContext context) {
    final room = ref.watch(matchRoomProvider(widget.matchId)).value;
    if (room == null) {
      return Scaffold(appBar: AppBar(), body: const LoadingState());
    }
    final p = context.palette;
    final l = context.l10n;
    final draft = _draft ??= SeriesDraft.of(room);
    final opponent = room.summary.opponent?.displayName ?? l.matchOpponent;
    final me = room.summary.me?.displayName ?? l.matchYou;
    final minutes = room.windows.confirm.inMinutes;

    return Scaffold(
      appBar: AppBar(title: Text(l.matchReportScore)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            TonitsSpace.md,
            TonitsSpace.sm,
            TonitsSpace.md,
            TonitsSpace.xl,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                draft.isSeries
                    ? l.seriesReportIntro(opponent, minutes)
                    : l.matchReportIntro(opponent, minutes),
                style: TextStyle(
                  fontSize: 15,
                  height: 1.45,
                  color: p.subtleForeground,
                ),
              ),
            ),
            if (draft.isSeries) ...[
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Pill(
                  _standing(draft, opponent, l),
                  icon: Icons.emoji_events_outlined,
                  color: p.primary,
                ),
              ),
            ],
            const SizedBox(height: 16),
            for (final (i, game) in draft.games.indexed) ...[
              if (i > 0) const SizedBox(height: TonitsSpace.md),
              _GameCard(
                number: i + 1,
                title: draft.isSeries ? l.seriesGame(i + 1) : l.matchFullTime,
                game: game,
                me: me,
                opponent: opponent,
                penalties: draft.needsPenalties(game),
                series: draft.isSeries,
                onChanged: (g) => _edit(draft.update(i, g)),
                onRemove: draft.isSeries && i > 0 && i == draft.games.length - 1
                    ? () => _edit(draft.removeLastGame())
                    : null,
              ),
            ],
            if (draft.canAddGame) ...[
              const SizedBox(height: TonitsSpace.md),
              SecondaryButton(
                label: l.seriesAddGame(draft.games.length + 1),
                icon: Icons.add,
                onPressed: () => _edit(draft.addGame()),
              ),
            ],
            const SizedBox(height: TonitsSpace.md),
            _Declaration(
              value: _declared,
              onChanged: (v) => setState(() => _declared = v),
            ),
            const SizedBox(height: TonitsSpace.lg),
            if (error != null) ...[
              Notice(error!),
              const SizedBox(height: TonitsSpace.md),
            ],
            PrimaryButton(
              label: l.matchSendScore,
              busy: busy,
              onPressed: _declared ? () => _submit(room, draft) : null,
            ),
          ],
        ),
      ),
    );
  }

  static String _standing(
    SeriesDraft draft,
    String opponent,
    AppLocalizations l,
  ) {
    final (mine, theirs) = (draft.myWins, draft.theirWins);
    if (draft.decided) {
      return mine > theirs
          ? l.seriesYouWin(mine, theirs)
          : l.seriesTheyWin(opponent, theirs, mine);
    }
    if (mine > theirs) return l.seriesYouLead(mine, theirs);
    if (theirs > mine) return l.seriesTheyLead(opponent, theirs, mine);
    return l.seriesLevel(mine, theirs);
  }
}

/// One game's score, with its penalty shootout when a knockout game is
/// level.
class _GameCard extends StatelessWidget {
  const _GameCard({
    required this.number,
    required this.title,
    required this.game,
    required this.me,
    required this.opponent,
    required this.penalties,
    required this.series,
    required this.onChanged,
    this.onRemove,
  });

  final int number;
  final String title;
  final GameDraft game;
  final String me;
  final String opponent;
  final bool penalties;
  final bool series;
  final ValueChanged<GameDraft> onChanged;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final heading = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: p.mutedForeground,
    );
    return Panel(
      padding: const EdgeInsets.fromLTRB(20, 14, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 32,
            child: Row(
              children: [
                Expanded(child: Text(title, style: heading)),
                if (onRemove != null)
                  IconButton(
                    tooltip: l.seriesRemoveGame(number),
                    icon: Icon(Icons.close, size: 18, color: p.mutedForeground),
                    onPressed: onRemove,
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Column(
              children: [
                ScoreStepper(
                  label: l.matchYou,
                  avatarName: me,
                  value: game.mine,
                  onChanged: (v) => onChanged(game.copyWith(mine: v)),
                ),
                const Divider(height: 1),
                ScoreStepper(
                  label: opponent,
                  value: game.theirs,
                  onChanged: (v) => onChanged(game.copyWith(theirs: v)),
                ),
                if (penalties) ...[
                  const Divider(height: 1),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(l.matchPenaltyShootout, style: heading),
                  ),
                  ScoreStepper(
                    label: l.matchYou,
                    avatarName: me,
                    value: game.penMine,
                    onChanged: (v) => onChanged(game.copyWith(penMine: v)),
                  ),
                  const Divider(height: 1),
                  ScoreStepper(
                    label: opponent,
                    value: game.penTheirs,
                    onChanged: (v) => onChanged(game.copyWith(penTheirs: v)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      series ? l.seriesLevelGameNote : l.matchLevelKnockoutNote,
                      style: TextStyle(fontSize: 13, color: p.mutedForeground),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The player vouches for the score before sending it.
class _Declaration extends StatelessWidget {
  const _Declaration({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return MergeSemantics(
      child: Panel(
        radius: TonitsRadius.tile,
        padding: const EdgeInsets.fromLTRB(8, 8, 16, 12),
        onTap: () => onChanged(!value),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(value: value, onChanged: (v) => onChanged(v ?? false)),
            const SizedBox(width: 4),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  context.l10n.matchDeclaration,
                  style: TextStyle(height: 1.4, color: p.subtleForeground),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
