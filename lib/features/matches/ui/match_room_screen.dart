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
import 'widgets/next_step_panel.dart';
import 'widgets/room_hero.dart';

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
    final live =
        !room.lifecycle.isOver &&
        room.lifecycle != MatchLifecycle.outOfCompetition &&
        opponent != null;
    return [
      if (room.verification.entryRemoved) ...[
        Notice(l.matchRemovedNotice),
        const SizedBox(height: TonitsSpace.md),
      ],
      NextStepPanel(room: room),
      if (live) ...[
        const SizedBox(height: TonitsSpace.md),
        FriendMatchCard(
          opponent: opponent,
          instructions: room.instructions,
          series: room.isSeries,
        ),
      ],
      const SizedBox(height: 28),
      Padding(
        padding: const EdgeInsets.only(left: 4),
        child: SectionLabel(l.matchInfoLabel),
      ),
      const SizedBox(height: 10),
      MatchFacts(room: room),
    ];
  }
}
