import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/error_text.dart';
import '../../../core/l10n.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../application/matches_providers.dart';
import '../data/match_room.dart';
import '../data/match_summary.dart';
import 'widgets/friend_match_card.dart';
import 'widgets/match_facts.dart';
import 'widgets/room_actions.dart';
import 'widgets/room_hero.dart';
import 'widgets/series_games.dart';

/// One match, from check-in to the final result. Everything the player can
/// do comes from the server's lifecycle and allowed actions.
class MatchRoomScreen extends ConsumerWidget {
  const MatchRoomScreen({super.key, required this.matchId});

  final String matchId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final room = ref.watch(matchRoomProvider(matchId));
    return switch (room) {
      AsyncData(:final value) => HeroScaffold(
        title: value.summary.competitionName,
        hero: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RoomHero(room: value),
            const SizedBox(height: TonitsSpace.lg),
            RoomActions(room: value),
          ],
        ),
        onRefresh: () =>
            ref.read(matchRoomProvider(matchId).notifier).refresh(),
        children: _sheet(value, context.l10n),
      ),
      AsyncError(:final error) => Scaffold(
        appBar: AppBar(),
        body: ErrorState(
          message: describeError(error, context.l10n),
          onRetry: () => ref.invalidate(matchRoomProvider(matchId)),
        ),
      ),
      _ => Scaffold(appBar: AppBar(), body: const LoadingState()),
    };
  }

  static List<Widget> _sheet(MatchRoom room, AppLocalizations l) {
    final opponent = room.summary.opponent;
    // Finding each other only matters until the match is played.
    final beforeResult = switch (room.lifecycle) {
      MatchLifecycle.assigned ||
      MatchLifecycle.readyForCheckIn ||
      MatchLifecycle.checkedIn ||
      MatchLifecycle.reportRequired => true,
      _ => false,
    };
    final games = room.result?.games ?? const <Score>[];
    return [
      if (room.verification.entryRemoved) ...[
        Notice(l.matchRemovedNotice),
        const SizedBox(height: TonitsSpace.md),
      ],
      if (beforeResult && opponent != null) ...[
        FriendMatchCard(
          opponent: opponent,
          instructions: room.instructions,
          series: room.isSeries,
        ),
        const SizedBox(height: 28),
      ],
      if (room.isSeries && games.isNotEmpty) ...[
        SeriesGames(
          games: games,
          home: room.summary.isHome,
          opponent: opponent?.displayName ?? l.matchOpponent,
        ),
        const SizedBox(height: 28),
      ],
      Padding(
        padding: const EdgeInsets.only(left: 4),
        child: SectionLabel(l.matchInfoLabel),
      ),
      const SizedBox(height: 10),
      MatchFacts(room: room),
    ];
  }
}
