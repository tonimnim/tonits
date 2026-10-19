import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/countries.dart';
import '../../../../core/format.dart';
import '../../../../core/l10n.dart';
import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../players/application/player_stats.dart';
import '../../../players/application/players_providers.dart';
import '../../../players/data/player_profile.dart';
import '../../../players/ui/widgets/result_chip.dart';
import 'section_message_card.dart';

/// The hero: the player's rating and where it places them, then how they
/// play: win rate, matches, goals, streak and record. Unrated players are
/// invited to play.
class PlayerCard extends ConsumerWidget {
  const PlayerCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (ref.watch(myProfileProvider)) {
      AsyncData(value: final profile) =>
        profile.rating == null || !profile.hasPlayed
            ? const _Shell(child: _Unrated())
            : _Shell(child: _Rated(profile, profile.rating!)),
      AsyncError(:final error) => SectionMessageCard.error(
        error: error,
        onRetry: () => ref.invalidate(myProfileProvider),
      ),
      _ => const _Shell(child: _Loading()),
    };
  }
}

/// The indigo card the hero sits on.
class _Shell extends StatelessWidget {
  const _Shell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: p.primary,
        borderRadius: BorderRadius.circular(TonitsRadius.panel),
      ),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: p.onPrimary),
        child: child,
      ),
    );
  }
}

class _Rated extends ConsumerWidget {
  const _Rated(this.profile, this.rating);

  final PlayerProfile profile;
  final GameRating rating;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final on = context.palette.onPrimary;
    final soft = on.withValues(alpha: 0.72);
    final l = context.l10n;
    final stats = ref.watch(myStatsProvider).value;
    final country = Country.byCode(profile.countryCode);
    final countryName = country == null
        ? profile.countryCode
        : '${country.flag} ${country.name}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              l.homeRating,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: soft,
              ),
            ),
            const Spacer(),
            if ((rating.rankMovement ?? 0) != 0)
              _Movement(places: rating.rankMovement!),
          ],
        ),
        const SizedBox(height: 2),
        Semantics(
          label: l.homeRatingSemantics(rating.rating),
          excludeSemantics: true,
          child: Text(
            Format.number(rating.rating),
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              letterSpacing: -1.6,
              height: 1.05,
              color: on,
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Where the rating places the player, in one quiet line.
        Text.rich(
          TextSpan(
            style: TextStyle(fontSize: 14, color: soft),
            children: [
              ..._rank(rating.countryRank, l.homeRankIn(countryName), on, l),
              const TextSpan(text: '   ·   '),
              ..._rank(rating.globalRank, l.homeRankGlobal, on, l),
            ],
          ),
        ),
        if (stats != null && stats.record.matchesPlayed > 0) ...[
          const SizedBox(height: 20),
          Container(height: 1, color: on.withValues(alpha: 0.16)),
          const SizedBox(height: 18),
          _Figures(stats: stats),
          const SizedBox(height: 18),
          _Record(record: stats.record),
        ],
      ],
    );
  }

  /// "#24 in Kenya", with the number bright; "Unranked" while provisional.
  static List<InlineSpan> _rank(
    int? rank,
    String where,
    Color on,
    AppLocalizations l,
  ) => rank == null
      ? [TextSpan(text: '${l.homeUnranked} $where')]
      : [
          TextSpan(
            text: '#${Format.number(rank)}',
            style: TextStyle(fontWeight: FontWeight.w700, color: on),
          ),
          TextSpan(text: ' $where'),
        ];
}

/// Win rate, matches, goals per match and the current streak, side by side.
class _Figures extends StatelessWidget {
  const _Figures({required this.stats});

  final PlayerStats stats;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final record = stats.record;
    final winRate = record.winRate;
    final goals = stats.goalsPerMatch;
    final streak = stats.streak;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Figure(
          value: winRate == null ? '—' : '${(winRate * 100).round()}%',
          label: l.homeWinRate,
        ),
        _Figure(value: '${record.matchesPlayed}', label: l.homeMatches),
        _Figure(
          value: goals == null ? '—' : goals.toStringAsFixed(1),
          label: l.homeGoalsPerMatchShort,
        ),
        _Figure(
          value: streak == null ? '—' : '${streak.$1.letter(l)}${streak.$2}',
          label: l.homeStreak,
        ),
      ],
    );
  }
}

class _Figure extends StatelessWidget {
  const _Figure({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final on = context.palette.onPrimary;
    return Expanded(
      child: MergeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.4,
                  color: on,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              maxLines: 2,
              style: TextStyle(
                fontSize: 12,
                height: 1.25,
                color: on.withValues(alpha: 0.72),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Wins, draws and losses as one thin bar in shades of white, with the
/// counts under it.
class _Record extends StatelessWidget {
  const _Record({required this.record});

  final MatchRecord record;

  @override
  Widget build(BuildContext context) {
    final on = context.palette.onPrimary;
    final l = context.l10n;
    final parts = [
      (record.wins, on),
      (record.draws, on.withValues(alpha: 0.5)),
      (record.losses, on.withValues(alpha: 0.24)),
    ].where((p) => p.$1 > 0).toList();
    return Semantics(
      label: l.playerRecordSemantics(record.wins, record.draws, record.losses),
      excludeSemantics: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: SizedBox(
              height: 6,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final (i, (count, color)) in parts.indexed) ...[
                    if (i > 0) const SizedBox(width: 3),
                    Expanded(
                      flex: count,
                      child: ColoredBox(color: color),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l.homeRecordLine(record.wins, record.draws, record.losses),
            style: TextStyle(fontSize: 12, color: on.withValues(alpha: 0.72)),
          ),
        ],
      ),
    );
  }
}

class _Movement extends StatelessWidget {
  const _Movement({required this.places});

  final int places;

  @override
  Widget build(BuildContext context) {
    final on = context.palette.onPrimary;
    final up = places > 0;
    final n = places.abs();
    final l = context.l10n;
    return Semantics(
      label: up ? l.homeMovedUp(n) : l.homeMovedDown(n),
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.fromLTRB(6, 3, 10, 3),
        decoration: BoxDecoration(
          color: on.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              up ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              size: 20,
              color: on,
            ),
            Text(
              l.homePlaces(n),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: on,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Unrated extends StatelessWidget {
  const _Unrated();

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l.homeRating,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: p.onPrimary.withValues(alpha: 0.75),
          ),
        ),
        Text(
          l.homeUnranked,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            letterSpacing: -1,
            color: p.onPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          l.homeUnratedMessage,
          style: TextStyle(color: p.onPrimary.withValues(alpha: 0.85)),
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () => context.go(Routes.competitions),
          style: FilledButton.styleFrom(
            backgroundColor: p.onPrimary,
            foregroundColor: p.primary,
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(TonitsRadius.control),
            ),
            textStyle: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          child: Text(l.homeFindCompetition),
        ),
      ],
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Center(
        child: SizedBox.square(
          dimension: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: context.palette.onPrimary,
          ),
        ),
      ),
    );
  }
}
