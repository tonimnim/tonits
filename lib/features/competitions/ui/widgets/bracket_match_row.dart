import 'package:flutter/material.dart';

import '../../../../core/format.dart';
import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../data/draw.dart';

/// One match of the draw on the page: both players with their scores, the
/// winner in bold, and a line for how it ended or when it's due. The
/// player's own match is tinted and opens its room.
class BracketMatchRow extends StatelessWidget {
  const BracketMatchRow({
    super.key,
    required this.match,
    this.myEntryId,
    this.onTap,
  });

  final BracketMatch match;
  final String? myEntryId;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final mine = match.involves(myEntryId);
    final note = _note(l);
    final score = match.score;

    return MergeSemantics(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(TonitsRadius.control),
        child: Ink(
          decoration: mine
              ? BoxDecoration(
                  color: p.soft,
                  borderRadius: BorderRadius.circular(TonitsRadius.control),
                )
              : null,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _Side(
                      slot: match.home,
                      score: score?.home,
                      match: match,
                      myEntryId: myEntryId,
                    ),
                    const SizedBox(height: 6),
                    _Side(
                      slot: match.away,
                      score: score?.away,
                      match: match,
                      myEntryId: myEntryId,
                    ),
                    if (note != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        note,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: match.state == BracketMatchState.disputed
                              ? p.warn.$1
                              : p.mutedForeground,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (onTap != null) ...[
                const SizedBox(width: 8),
                Icon(Icons.chevron_right, color: p.mutedForeground),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// How it ended when that isn't just the score, or when it's due.
  String? _note(AppLocalizations l) {
    if (match.score?.penalties case final pens?) {
      return l.drawPenalties(pens.home, pens.away);
    }
    final reason = switch (match.completionReason) {
      'walkover' => l.drawWalkover,
      'double_no_show' => l.drawNoShow,
      'timeout_forfeit' ||
      'response_timeout' ||
      'no_result_reported' => l.drawForfeit,
      'platform_review' || 'referee' => l.drawDecidedOnReview,
      'competition_cancelled' => l.drawCancelled,
      _ => null,
    };
    if (reason != null) return reason;
    if (match.state == BracketMatchState.disputed) return l.drawDisputed;
    if (match.state == BracketMatchState.cancelled) return l.drawCancelled;
    final at = match.scheduledAt;
    final known =
        match.home.participant != null || match.away.participant != null;
    return !match.isOver && known && at != null ? Format.dateTime(at, l) : null;
  }
}

/// One player and their score, or who will fill the place.
class _Side extends StatelessWidget {
  const _Side({
    required this.slot,
    required this.score,
    required this.match,
    required this.myEntryId,
  });

  final BracketSlot slot;
  final int? score;
  final BracketMatch match;
  final String? myEntryId;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final player = slot.participant;
    final winner = match.winnerEntryId;
    final won = player != null && winner == player.entryId;
    final lost = player != null && winner != null && !won;
    final color = player == null || lost ? p.mutedForeground : p.foreground;
    final weight = won ? FontWeight.w700 : FontWeight.w500;

    return Row(
      children: [
        Expanded(
          child: Text(
            switch (player) {
              final p? when p.entryId == myEntryId => l.rankingsYou(
                p.displayName,
              ),
              final p? => p.displayName,
              null when slot.voided || match.isOver => l.drawNoOpponent,
              null => l.drawToBeDecided,
            },
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 15, fontWeight: weight, color: color),
          ),
        ),
        if (score != null) ...[
          const SizedBox(width: 12),
          Text(
            '$score',
            style: TextStyle(
              fontSize: 15,
              fontWeight: weight,
              color: color,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ],
    );
  }
}
