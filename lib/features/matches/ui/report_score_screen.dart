import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../application/match_room_controller.dart';
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

class _ReportScoreScreenState extends ConsumerState<ReportScoreScreen> {
  int _mine = 0;
  int _theirs = 0;
  int _penMine = 0;
  int _penTheirs = 0;
  bool _declared = false;
  bool _busy = false;
  String? _error;

  Future<void> _submit(MatchRoom room) async {
    final penalties = _needsPenalties(room);
    if (penalties && _penMine == _penTheirs) {
      setState(() => _error = 'A penalty shootout needs a winner.');
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

    setState(() {
      _busy = true;
      _error = null;
    });
    final error = await ref
        .read(matchRoomProvider(widget.matchId).notifier)
        .reportScore(score);
    if (!mounted) return;
    if (error != null) {
      setState(() {
        _busy = false;
        _error = error;
      });
      return;
    }
    final opponent = room.summary.opponent?.displayName ?? 'Your opponent';
    final messenger = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          'Score sent. $opponent has ${room.windows.confirm.inMinutes} '
          'minutes to confirm it.',
        ),
      ),
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
    final opponent = room.summary.opponent?.displayName ?? 'Opponent';
    final penalties = _needsPenalties(room);

    return Scaffold(
      appBar: AppBar(title: const Text('Report the score')),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            TonitsSpace.lg,
            TonitsSpace.sm,
            TonitsSpace.lg,
            TonitsSpace.xl,
          ),
          children: [
            Text(
              'Enter the final score from the Full Time screen. $opponent '
              'confirms it, and if they don\'t answer within '
              '${room.windows.confirm.inMinutes} minutes, it stands.',
              style: TextStyle(color: p.subtleForeground),
            ),
            const SizedBox(height: TonitsSpace.lg),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: TonitsSpace.md,
                  vertical: 6,
                ),
                child: Column(
                  children: [
                    ScoreStepper(
                      label: 'You',
                      value: _mine,
                      onChanged: (v) => setState(() => _mine = v),
                    ),
                    const Divider(),
                    ScoreStepper(
                      label: opponent,
                      value: _theirs,
                      onChanged: (v) => setState(() => _theirs = v),
                    ),
                  ],
                ),
              ),
            ),
            if (penalties) ...[
              const SizedBox(height: TonitsSpace.lg),
              const Padding(
                padding: EdgeInsets.only(left: 4),
                child: SectionLabel('Penalty shootout'),
              ),
              const SizedBox(height: TonitsSpace.sm),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: TonitsSpace.md,
                    vertical: 6,
                  ),
                  child: Column(
                    children: [
                      ScoreStepper(
                        label: 'You',
                        value: _penMine,
                        onChanged: (v) => setState(() => _penMine = v),
                      ),
                      const Divider(),
                      ScoreStepper(
                        label: opponent,
                        value: _penTheirs,
                        onChanged: (v) => setState(() => _penTheirs = v),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: TonitsSpace.sm),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  'A level knockout match is decided on penalties.',
                  style: TextStyle(fontSize: 13, color: p.mutedForeground),
                ),
              ),
            ],
            const SizedBox(height: TonitsSpace.lg),
            _Declaration(
              value: _declared,
              onChanged: (v) => setState(() => _declared = v),
            ),
            const SizedBox(height: TonitsSpace.lg),
            if (_error != null) ...[
              Notice(_error!),
              const SizedBox(height: TonitsSpace.md),
            ],
            PrimaryButton(
              label: 'Send score',
              busy: _busy,
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
      child: InkWell(
        borderRadius: BorderRadius.circular(TonitsRadius.control),
        onTap: () => onChanged(!value),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(value: value, onChanged: (v) => onChanged(v ?? false)),
              const SizedBox(width: 4),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    'This is the real score. Reporting a false score can get '
                    'me removed from the competition.',
                    style: TextStyle(color: p.subtleForeground),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
