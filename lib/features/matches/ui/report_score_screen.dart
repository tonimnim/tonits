import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../application/matches_providers.dart';
import '../application/score_draft.dart';
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
  ScoreDraft? _draft;
  bool _declared = false;

  Future<void> _submit(MatchRoom room, ScoreDraft draft) async {
    final l = context.l10n;
    final problem = draft.problem;
    if (problem != null) {
      setState(
        () => error = switch (problem) {
          ScoreProblem.penaltiesNeedWinner => l.matchPenaltyNeedsWinner,
          ScoreProblem.noWinnerYet => l.seriesNeedsWinner(draft.gamesToWin),
        },
      );
      return;
    }
    final sent = await runForMessage(
      () => ref
          .read(matchRoomProvider(widget.matchId).notifier)
          .reportScore(draft.toReport(home: room.summary.isHome)),
    );
    if (!sent || !mounted) return;
    final opponent =
        room.summary.opponent?.displayName ?? l.matchYourOpponentStart;
    popWithMessage(
      context,
      l.matchScoreSent(opponent, room.windows.confirm.inMinutes),
    );
  }

  void _edit(ScoreDraft draft) => setState(() {
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
    final draft = _draft ??= ScoreDraft.of(room);
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
            const SizedBox(height: 20),
            _ScorePanel(
              title: draft.isSeries ? l.seriesGamesWon : l.matchFullTime,
              caption: draft.isSeries
                  ? l.seriesBestOfFirstTo(draft.bestOf, draft.gamesToWin)
                  : null,
              me: me,
              opponent: opponent,
              mine: draft.mine,
              theirs: draft.theirs,
              maxMine: draft.maxFor(mine: true),
              maxTheirs: draft.maxFor(mine: false),
              onMine: (v) => _edit(draft.copyWith(mine: v)),
              onTheirs: (v) => _edit(draft.copyWith(theirs: v)),
            ),
            if (draft.needsPenalties) ...[
              const SizedBox(height: TonitsSpace.md),
              _ScorePanel(
                title: l.matchPenaltyShootout,
                me: me,
                opponent: opponent,
                mine: draft.penMine,
                theirs: draft.penTheirs,
                onMine: (v) => _edit(draft.copyWith(penMine: v)),
                onTheirs: (v) => _edit(draft.copyWith(penTheirs: v)),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  l.matchLevelKnockoutNote,
                  style: TextStyle(fontSize: 13, color: p.mutedForeground),
                ),
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
}

/// Two steppers, the player's side and the opponent's: goals, a shootout
/// or games won.
class _ScorePanel extends StatelessWidget {
  const _ScorePanel({
    required this.title,
    required this.me,
    required this.opponent,
    required this.mine,
    required this.theirs,
    required this.onMine,
    required this.onTheirs,
    this.caption,
    this.maxMine = 99,
    this.maxTheirs = 99,
  });

  final String title;
  final String? caption;
  final String me;
  final String opponent;
  final int mine;
  final int theirs;
  final int maxMine;
  final int maxTheirs;
  final ValueChanged<int> onMine;
  final ValueChanged<int> onTheirs;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    return Panel(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: p.mutedForeground,
            ),
          ),
          if (caption != null)
            Text(
              caption!,
              style: TextStyle(fontSize: 12, color: p.mutedForeground),
            ),
          ScoreStepper(
            label: l.matchYou,
            avatarName: me,
            value: mine,
            max: maxMine,
            onChanged: onMine,
          ),
          const Divider(height: 1),
          ScoreStepper(
            label: opponent,
            value: theirs,
            max: maxTheirs,
            onChanged: onTheirs,
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
