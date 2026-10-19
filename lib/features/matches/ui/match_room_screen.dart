import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/error_text.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../data/match_room.dart';
import '../data/match_summary.dart';
import 'widgets/friend_match_card.dart';
import 'widgets/match_facts.dart';
import 'widgets/next_step_panel.dart';
import 'widgets/room_hero.dart';
import '../application/matches_providers.dart';

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
        hero: RoomHero(room: value),
        onRefresh: () =>
            ref.read(matchRoomProvider(matchId).notifier).refresh(),
        children: _sheet(value),
      ),
      AsyncError(:final error) => Scaffold(
        appBar: AppBar(),
        body: ErrorState(
          message: describeError(error),
          onRetry: () => ref.invalidate(matchRoomProvider(matchId)),
        ),
      ),
      _ => Scaffold(appBar: AppBar(), body: const LoadingState()),
    };
  }

  static List<Widget> _sheet(MatchRoom room) {
    final opponent = room.summary.opponent;
    final live =
        !room.lifecycle.isOver &&
        room.lifecycle != MatchLifecycle.outOfCompetition &&
        opponent != null;
    return [
      if (room.verification.entryRemoved) ...[
        const Notice('This match removed you from the competition.'),
        const SizedBox(height: TonitsSpace.md),
      ],
      NextStepPanel(room: room),
      if (live) ...[
        const SizedBox(height: TonitsSpace.md),
        FriendMatchCard(opponent: opponent, instructions: room.instructions),
      ],
      const SizedBox(height: 28),
      const Padding(
        padding: EdgeInsets.only(left: 4),
        child: SectionLabel('Match info'),
      ),
      const SizedBox(height: 10),
      MatchFacts(room: room),
    ];
  }
}
