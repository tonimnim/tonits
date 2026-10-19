import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/error_text.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../application/match_room_controller.dart';
import '../data/match_room.dart';
import '../data/match_summary.dart';
import 'widgets/friend_match_card.dart';
import 'widgets/match_facts.dart';
import 'widgets/next_step_panel.dart';
import 'widgets/room_hero.dart';

/// One match, from check-in to the final result. Everything the player can
/// do comes from the server's lifecycle and allowed actions.
class MatchRoomScreen extends ConsumerStatefulWidget {
  const MatchRoomScreen({super.key, required this.matchId});

  final String matchId;

  @override
  ConsumerState<MatchRoomScreen> createState() => _MatchRoomScreenState();
}

class _MatchRoomScreenState extends ConsumerState<MatchRoomScreen> {
  /// The bar is clear over the hero, and solid once content slides under.
  bool _scrolled = false;

  String get matchId => widget.matchId;

  bool _onScroll(ScrollNotification n) {
    final scrolled = n.metrics.axis == Axis.vertical && n.metrics.pixels > 24;
    if (scrolled != _scrolled) setState(() => _scrolled = scrolled);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final room = ref.watch(matchRoomProvider(matchId));
    final p = context.palette;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: _scrolled ? p.background : Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          room.value?.summary.competitionName ?? '',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            letterSpacing: 0,
            color: p.subtleForeground,
          ),
        ),
        leadingWidth: 64,
        leading: Navigator.of(context).canPop()
            ? Padding(
                padding: const EdgeInsets.only(left: TonitsSpace.md),
                child: Center(
                  child: RoundIconButton(
                    icon: Icons.arrow_back,
                    tooltip: 'Back',
                    background: p.card.withValues(alpha: 0.85),
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                ),
              )
            : null,
      ),
      body: switch (room) {
        AsyncData(:final value) => RefreshIndicator(
          edgeOffset: MediaQuery.paddingOf(context).top + kToolbarHeight,
          onRefresh: () =>
              ref.read(matchRoomProvider(matchId).notifier).refresh(),
          child: NotificationListener<ScrollNotification>(
            onNotification: _onScroll,
            child: _Room(room: value),
          ),
        ),
        AsyncError(:final error) => SafeArea(
          child: ErrorState(
            message: describeError(error),
            onRetry: () => ref.invalidate(matchRoomProvider(matchId)),
          ),
        ),
        _ => const LoadingState(),
      },
    );
  }
}

class _Room extends StatelessWidget {
  const _Room({required this.room});

  final MatchRoom room;

  /// How far the sheet reaches up over the hero.
  static const _overlap = 28.0;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final opponent = room.summary.opponent;
    final live =
        !room.lifecycle.isOver &&
        room.lifecycle != MatchLifecycle.outOfCompetition &&
        opponent != null;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        RoomHero(room: room, overlap: _overlap),
        Transform.translate(
          offset: const Offset(0, -_overlap),
          child: Container(
            decoration: BoxDecoration(
              color: p.background,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(TonitsRadius.sheet),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(
              TonitsSpace.md,
              20,
              TonitsSpace.md,
              TonitsSpace.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (room.verification.entryRemoved) ...[
                  const Notice('This match removed you from the competition.'),
                  const SizedBox(height: TonitsSpace.md),
                ],
                NextStepPanel(room: room),
                if (live) ...[
                  const SizedBox(height: TonitsSpace.md),
                  FriendMatchCard(
                    opponent: opponent,
                    instructions: room.instructions,
                  ),
                ],
                const SizedBox(height: 28),
                const Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: SectionLabel('Match info'),
                ),
                const SizedBox(height: 10),
                MatchFacts(room: room),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
