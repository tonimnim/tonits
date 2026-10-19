import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../application/matches_providers.dart';
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
  int _mine = 0;
  int _theirs = 0;
  int _penMine = 0;
  int _penTheirs = 0;
  bool _declared = false;

  Future<void> _submit(MatchRoom room) async {
    final penalties = _needsPenalties(room);
    if (penalties && _penMine == _penTheirs) {
      setState(() => error = context.l10n.matchPenaltyNeedsWinner);
      return;
    }
    final home = room.summary.isHome;
    Score fromMySide(int mine, int theirs, {Score? penalties}) => home
        ? Score(mine, theirs, penalties: penalties)
        : Score(theirs, mine, penalties: penalties);
    final score = fromMySide(
      _mine,
      _theirs,
      penalties: penalties ? fromMySide(_penMine, _penTheirs) : null,
    );

    final sent = await runForMessage(
      () => ref
          .read(matchRoomProvider(widget.matchId).notifier)
          .reportScore(score),
    );
    if (!sent || !mounted) return;
    final l = context.l10n;
    final opponent =
        room.summary.opponent?.displayName ?? l.matchYourOpponentStart;
    popWithMessage(
      context,
      l.matchScoreSent(opponent, room.windows.confirm.inMinutes),
    );
  }

  bool _needsPenalties(MatchRoom room) => !room.drawAllowed && _mine == _theirs;

  @override
  Widget build(BuildContext context) {
    final room = ref.watch(matchRoomProvider(widget.matchId)).value;
    if (room == null) {
      return Scaffold(appBar: AppBar(), body: const LoadingState());
    }
    final p = context.palette;
    final l = context.l10n;
    final opponent = room.summary.opponent?.displayName ?? l.matchOpponent;
    final penalties = _needsPenalties(room);

    final me = room.summary.me?.displayName ?? l.matchYou;

    Widget scorePanel({
      required String title,
      required int mine,
      required int theirs,
      required ValueChanged<int> onMine,
      required ValueChanged<int> onTheirs,
    }) => Panel(
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
          ScoreStepper(
            label: l.matchYou,
            avatarName: me,
            value: mine,
            onChanged: onMine,
          ),
          const Divider(height: 1),
          ScoreStepper(label: opponent, value: theirs, onChanged: onTheirs),
        ],
      ),
    );

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
                l.matchReportIntro(opponent, room.windows.confirm.inMinutes),
                style: TextStyle(
                  fontSize: 15,
                  height: 1.45,
                  color: p.subtleForeground,
                ),
              ),
            ),
            const SizedBox(height: 20),
            scorePanel(
              title: l.matchFullTime,
              mine: _mine,
              theirs: _theirs,
              onMine: (v) => setState(() => _mine = v),
              onTheirs: (v) => setState(() => _theirs = v),
            ),
            if (penalties) ...[
              const SizedBox(height: TonitsSpace.md),
              scorePanel(
                title: l.matchPenaltyShootout,
                mine: _penMine,
                theirs: _penTheirs,
                onMine: (v) => setState(() => _penMine = v),
                onTheirs: (v) => setState(() => _penTheirs = v),
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
              onPressed: _declared ? () => _submit(room) : null,
            ),
          ],
        ),
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
