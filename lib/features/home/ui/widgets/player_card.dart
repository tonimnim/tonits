import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/countries.dart';
import '../../../../core/format.dart';
import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../../players/application/players_providers.dart';
import '../../../players/data/player_profile.dart';
import 'section_message_card.dart';

/// The hero: the player's rating, with their matches, wins and place on
/// their country's ladder under it. A new player gets the same card at
/// zero, from the rating everyone starts at, so nothing moves as their
/// numbers fill in.
class PlayerCard extends ConsumerWidget {
  const PlayerCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (ref.watch(myProfileProvider)) {
      AsyncData(value: final profile) => _Shell(child: _Numbers(profile)),
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

class _Numbers extends StatelessWidget {
  const _Numbers(this.profile);

  final PlayerProfile profile;

  @override
  Widget build(BuildContext context) {
    final on = context.palette.onPrimary;
    final l = context.l10n;
    // No rating until the first confirmed result.
    final rating = profile.hasPlayed ? profile.rating : null;
    final value = rating?.rating ?? PlayerProfile.startingRating;
    final movement = rating?.rankMovement ?? 0;
    final rank = rating?.countryRank;
    final country =
        Country.byCode(profile.countryCode)?.name ?? profile.countryCode;

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
                color: on.withValues(alpha: 0.72),
              ),
            ),
            const Spacer(),
            if (rating == null)
              _Tag(child: Text(l.homeNewPlayer))
            else if (movement != 0)
              _Movement(places: movement),
          ],
        ),
        const SizedBox(height: 4),
        Semantics(
          label: l.homeRatingSemantics(value),
          excludeSemantics: true,
          child: Text(
            Format.number(value),
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              letterSpacing: -1.6,
              height: 1.05,
              color: on,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Figure(
              value: Format.number(profile.record.matchesPlayed),
              label: l.homeMatches,
            ),
            _Figure(
              value: Format.number(profile.record.wins),
              label: l.playerWins,
            ),
            rank == null
                ? _Figure(
                    value: '—',
                    spoken: l.homeUnranked,
                    label: l.homeCountryRank(country),
                    faint: true,
                  )
                : _Figure(
                    value: '#${Format.number(rank)}',
                    label: l.homeCountryRank(country),
                  ),
          ],
        ),
      ],
    );
  }
}

/// One number under the rating, with what it counts.
class _Figure extends StatelessWidget {
  const _Figure({
    required this.value,
    required this.label,
    this.spoken,
    this.faint = false,
  });

  final String value;
  final String label;

  /// What a screen reader says for [value], when the text alone won't do.
  final String? spoken;

  /// For a number the player doesn't have yet.
  final bool faint;

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
                semanticsLabel: spoken,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.4,
                  color: faint ? on.withValues(alpha: 0.45) : on,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
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

/// A small tag in the card's top corner.
class _Tag extends StatelessWidget {
  const _Tag({
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final on = context.palette.onPrimary;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: on.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
      ),
      child: DefaultTextStyle.merge(
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: on),
        child: child,
      ),
    );
  }
}

/// Places gained or lost on the ladder since the last snapshot.
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
      child: _Tag(
        padding: const EdgeInsets.fromLTRB(4, 1, 10, 1),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              up ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              size: 20,
              color: on,
            ),
            Text(Format.number(n)),
          ],
        ),
      ),
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
