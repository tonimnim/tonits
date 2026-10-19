import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../evidence/application/screenshot_uploader.dart';
import '../../application/matches_providers.dart';
import '../../data/match_room.dart';

/// After a series result is rejected: one slot per game played for its
/// Full Time screenshot, all sent together. Any one counts as responding.
class SeriesScreenshots extends ConsumerStatefulWidget {
  const SeriesScreenshots({super.key, required this.room});

  final MatchRoom room;

  @override
  ConsumerState<SeriesScreenshots> createState() => _SeriesScreenshotsState();
}

class _SeriesScreenshotsState extends ConsumerState<SeriesScreenshots>
    with BusyState {
  final _picked = <int, Uint8List>{};
  (int, int, UploadStage)? _progress;

  MatchRoom get room => widget.room;

  /// The games the reported result has, or every possible game.
  List<Score> get _games => room.verification.submitted?.games ?? const [];
  int get _slots => _games.isEmpty ? room.bestOf : _games.length;

  Future<void> _pick(int game) async {
    final bytes = await ref.read(screenshotPickerProvider)();
    if (bytes == null || !mounted) return;
    setState(() => _picked[game] = bytes);
  }

  Future<void> _send() async {
    await runForMessage(
      () => ref
          .read(matchRoomProvider(room.id).notifier)
          .sendScreenshots(
            Map.of(_picked),
            onProgress: (done, total, stage) {
              if (mounted) setState(() => _progress = (done, total, stage));
            },
          ),
    );
    if (mounted) setState(() => _progress = null);
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final progress = _progress;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var game = 1; game <= _slots; game++) ...[
          if (game > 1) const SizedBox(height: 8),
          _Slot(
            label: l.seriesGame(game),
            score: game <= _games.length
                ? _scoreText(_games[game - 1], l)
                : null,
            picked: _picked.containsKey(game),
            onPick: busy ? null : () => _pick(game),
          ),
        ],
        const SizedBox(height: 18),
        PrimaryButton(
          label: l.seriesSendScreenshots(_picked.length),
          busy: busy,
          onPressed: _picked.isEmpty ? null : _send,
        ),
        if (progress != null) ...[
          const SizedBox(height: 12),
          Text(
            progress.$3 == UploadStage.uploading
                ? l.seriesUploadingGame(progress.$1, progress.$2)
                : l.seriesCheckingGame(progress.$1, progress.$2),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: p.mutedForeground),
          ),
        ],
        if (error != null) ...[
          const SizedBox(height: TonitsSpace.md),
          Notice(error!),
        ],
      ],
    );
  }

  String _scoreText(Score game, AppLocalizations l) {
    final (mine, theirs) = game.forSide(home: room.summary.isHome);
    final pens = game.penalties?.forSide(home: room.summary.isHome);
    return pens == null
        ? '$mine–$theirs'
        : l.matchScoreWithPens(mine, theirs, pens.$1, pens.$2);
  }
}

/// One game's screenshot: the game and its reported score, and whether one
/// is chosen.
class _Slot extends StatelessWidget {
  const _Slot({
    required this.label,
    required this.score,
    required this.picked,
    required this.onPick,
  });

  final String label;
  final String? score;
  final bool picked;
  final VoidCallback? onPick;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 8, 8, 8),
      decoration: BoxDecoration(
        color: p.muted,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(
            picked ? Icons.check_circle : Icons.image_outlined,
            size: 22,
            color: picked ? p.good.$1 : p.mutedForeground,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                if (score != null)
                  Text(
                    score!,
                    style: TextStyle(fontSize: 13, color: p.subtleForeground),
                  ),
              ],
            ),
          ),
          TextButton(
            onPressed: onPick,
            child: Text(picked ? l.seriesChange : l.seriesChoose),
          ),
        ],
      ),
    );
  }
}
