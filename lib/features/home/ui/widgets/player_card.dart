import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/countries.dart';
import '../../../../core/format.dart';
import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../players/application/players_providers.dart';
import '../../../players/data/player_profile.dart';
import 'section_message_card.dart';

/// The hero: the player's rating, its trend, and where it places them in
/// their country and the world. Unrated players are invited to play.
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: p.primary,
        borderRadius: BorderRadius.circular(TonitsRadius.card + 4),
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
    final p = context.palette;
    final history = ref.watch(myRatingHistoryProvider).value;
    final country = Country.byCode(profile.countryCode);
    final soft = p.onPrimary.withValues(alpha: 0.75);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Rating',
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
          label: 'Rating ${rating.rating}',
          excludeSemantics: true,
          child: Text(
            Format.number(rating.rating),
            style: TextStyle(
              fontSize: 44,
              fontWeight: FontWeight.w700,
              letterSpacing: -1.5,
              height: 1.1,
              color: p.onPrimary,
            ),
          ),
        ),
        if (history != null && history.length >= 2) ...[
          const SizedBox(height: 12),
          Sparkline(
            values: [for (final point in history) point.rating],
            color: p.onPrimary,
          ),
          Text('Last 30 days', style: TextStyle(fontSize: 11, color: soft)),
        ],
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _RankPill(
                rank: rating.countryRank,
                label: country == null
                    ? 'in ${profile.countryCode}'
                    : '${country.flag} ${country.name}',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _RankPill(rank: rating.globalRank, label: 'Global'),
            ),
          ],
        ),
      ],
    );
  }
}

class _RankPill extends StatelessWidget {
  const _RankPill({required this.rank, required this.label});

  final int? rank;
  final String label;

  @override
  Widget build(BuildContext context) {
    final on = context.palette.onPrimary;
    return MergeSemantics(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: on.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(TonitsRadius.control),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              rank == null ? 'Unranked' : '#${Format.number(rank!)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: on,
              ),
            ),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: on.withValues(alpha: 0.8)),
            ),
          ],
        ),
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
    return Semantics(
      label: '${up ? 'Up' : 'Down'} $n place${n == 1 ? '' : 's'}',
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
              '$n place${n == 1 ? '' : 's'}',
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rating',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: p.onPrimary.withValues(alpha: 0.75),
          ),
        ),
        Text(
          'Unranked',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            letterSpacing: -1,
            color: p.onPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Play your first rated match to get a rating and a place on '
          'the ladder.',
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
          child: const Text('Find a competition'),
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
