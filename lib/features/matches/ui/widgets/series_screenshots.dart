import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../evidence/application/screenshot_uploader.dart';
import '../../application/matches_providers.dart';
import '../../data/match_room.dart';
import 'screenshot_preview.dart';

/// After a series result is rejected: one slot per game played for its
/// Full Time screenshot, all sent together. Any one counts as responding.
class SeriesScreenshots extends ConsumerStatefulWidget {
  const SeriesScreenshots({super.key, required this.room, this.onSent});

  final MatchRoom room;

  /// Called once the screenshots are sent, such as to close the sheet.
  final VoidCallback? onSent;

  @override
  ConsumerState<SeriesScreenshots> createState() => _SeriesScreenshotsState();
}

class _SeriesScreenshotsState extends ConsumerState<SeriesScreenshots>
    with BusyState {
  final _picked = <int, Uint8List>{};
  (int, int, UploadStage)? _progress;

  MatchRoom get room => widget.room;

  /// The games the reported result has, when it lists them.
  List<Score> get _games => room.verification.submitted?.games ?? const [];

  /// One slot per game played: the games won in a knockout series (2–1 is
  /// three games). A round-robin series can have drawn games, so it offers
  /// every game.
  int get _slots {
    if (_games.isNotEmpty) return _games.length;
    final reported = room.verification.submitted?.score;
    if (room.drawAllowed || reported == null) return room.bestOf;
    return (reported.home + reported.away).clamp(1, room.bestOf);
  }

  /// Picks a game's screenshot. One that can't be sent says why at once,
  /// before anything is uploaded.
  Future<void> _pick(int game) async {
    final bytes = await ref.read(screenshotPickerProvider)();
    if (bytes == null || !mounted) return;
    final problem = ScreenshotUploader.problemWith(bytes, context.l10n);
    final message = problem == null
        ? null
        : context.l10n.matchScreenshotProblemForGame(game, problem);
    setState(() {
      error = message;
      if (problem == null) _picked[game] = bytes;
    });
  }

  /// Shows a game's chosen screenshot big, to keep or replace.
  Future<void> _preview(int game) async {
    final bytes = _picked[game];
    if (bytes == null) return;
    final l = context.l10n;
    final choice = await previewScreenshot(
      context,
      bytes,
      title: l.seriesGame(game),
      confirmLabel: l.matchScreenshotKeep,
    );
    if (choice == PreviewChoice.pickAnother && mounted) await _pick(game);
  }

  Future<void> _send() async {
    final sent = await runForMessage(
      () => ref
          .read(matchRoomProvider(room.id).notifier)
          .sendScreenshots(
            Map.of(_picked),
            onProgress: (done, total, stage) {
              if (mounted) setState(() => _progress = (done, total, stage));
            },
          ),
    );
    if (!mounted) return;
    setState(() => _progress = null);
    if (sent) widget.onSent?.call();
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
            picked: _picked[game],
            onPick: busy ? null : () => _pick(game),
            onPreview: busy ? null : () => _preview(game),
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

/// One game's screenshot: the game and its reported score, and the chosen
/// screenshot as a thumbnail that opens it big.
class _Slot extends StatelessWidget {
  const _Slot({
    required this.label,
    required this.score,
    required this.picked,
    required this.onPick,
    required this.onPreview,
  });

  final String label;
  final String? score;
  final Uint8List? picked;
  final VoidCallback? onPick;
  final VoidCallback? onPreview;

  static const _thumb = 44.0;

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
          if (picked case final bytes?)
            Semantics(
              button: true,
              label: label,
              child: GestureDetector(
                onTap: onPreview,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ScreenshotImage(
                    bytes: bytes,
                    width: _thumb,
                    height: _thumb,
                  ),
                ),
              ),
            )
          else
            SizedBox.square(
              dimension: _thumb,
              child: Icon(
                Icons.image_outlined,
                size: 22,
                color: p.mutedForeground,
              ),
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
            child: Text(picked != null ? l.seriesChange : l.seriesChoose),
          ),
        ],
      ),
    );
  }
}
