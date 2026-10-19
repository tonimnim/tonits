import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/error_text.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../application/match_room_controller.dart';
import '../data/match_room.dart';
import '../data/match_summary.dart';
import 'widgets/friend_match_card.dart';
import 'widgets/match_details.dart';
import 'widgets/matchup_header.dart';
import 'widgets/next_step_panel.dart';

/// One match, from check-in to the final result. Everything the player can
/// do comes from the server's lifecycle and allowed actions.
class MatchRoomScreen extends ConsumerWidget {
  const MatchRoomScreen({super.key, required this.matchId});

  final String matchId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final room = ref.watch(matchRoomProvider(matchId));
    return Scaffold(
      appBar: AppBar(title: const Text('Match')),
      body: switch (room) {
        AsyncData(:final value) => RefreshIndicator(
          onRefresh: () =>
              ref.read(matchRoomProvider(matchId).notifier).refresh(),
          child: _Room(room: value),
        ),
        AsyncError(:final error) => ErrorState(
          message: describeError(error),
          onRetry: () => ref.invalidate(matchRoomProvider(matchId)),
        ),
        _ => const LoadingState(),
      },
    );
  }
}

class _Room extends StatelessWidget {
  const _Room({required this.room});

  final MatchRoom room;

  @override
  Widget build(BuildContext context) {
    final opponent = room.summary.opponent;
    final live =
        !room.lifecycle.isOver &&
        room.lifecycle != MatchLifecycle.outOfCompetition &&
        opponent != null;
    const gap = SizedBox(height: TonitsSpace.lg);

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        TonitsSpace.md,
        TonitsSpace.sm,
        TonitsSpace.md,
        TonitsSpace.xl,
      ),
      children: [
        MatchupHeader(room: room),
        const SizedBox(height: TonitsSpace.xl),
        if (room.verification.entryRemoved) ...[
          const Notice('This match removed you from the competition.'),
          gap,
        ],
        NextStepPanel(room: room),
        if (live) ...[
          gap,
          FriendMatchCard(opponent: opponent, instructions: room.instructions),
        ],
        gap,
        MatchDetails(room: room),
      ],
    );
  }
}
