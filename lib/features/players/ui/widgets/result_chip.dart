import 'package:flutter/material.dart';

import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../data/played_match.dart';

/// A small square W, D or L in the result's colour.
class ResultChip extends StatelessWidget {
  const ResultChip(this.result, {super.key, this.size = 24});

  final MatchResult result;
  final double size;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final (text, fill) = switch (result) {
      MatchResult.win => p.good,
      MatchResult.loss => (
        p.destructive,
        p.destructive.withValues(alpha: 0.14),
      ),
      MatchResult.draw => (p.mutedForeground, p.muted),
    };
    return Semantics(
      label: result.label(context.l10n),
      excludeSemantics: true,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: fill,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          result.letter(context.l10n),
          style: TextStyle(
            fontSize: size * 0.46,
            fontWeight: FontWeight.w700,
            color: text,
          ),
        ),
      ),
    );
  }
}

/// A result's player-facing words.
extension MatchResultText on MatchResult {
  /// Win, Draw or Loss.
  String label(AppLocalizations l) => switch (this) {
    MatchResult.win => l.playerResultWin,
    MatchResult.draw => l.playerResultDraw,
    MatchResult.loss => l.playerResultLoss,
  };

  /// W, D or L.
  String letter(AppLocalizations l) => switch (this) {
    MatchResult.win => l.playerResultWinLetter,
    MatchResult.draw => l.playerResultDrawLetter,
    MatchResult.loss => l.playerResultLossLetter,
  };
}
