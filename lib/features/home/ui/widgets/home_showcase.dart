import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/countries.dart';
import '../../../../core/format.dart';
import '../../../../core/l10n.dart';
import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../auth/application/auth_providers.dart';
import '../../../competitions/data/competition.dart';
import '../../application/showcase_providers.dart';

/// Home's rotating cards, to show the place is alive: the top of the
/// player's country, the latest champion, and a competition still to open.
/// Only the ones with something to say take part; with none, nothing
/// shows. They turn every [interval], and hold while a finger is on them.
class HomeShowcase extends ConsumerStatefulWidget {
  const HomeShowcase({super.key, this.interval = const Duration(seconds: 4)});

  final Duration interval;

  @override
  ConsumerState<HomeShowcase> createState() => _HomeShowcaseState();
}

class _HomeShowcaseState extends ConsumerState<HomeShowcase> {
  final _pages = PageController();
  Timer? _timer;
  var _page = 0;
  var _count = 0;
  var _held = false;

  @override
  void dispose() {
    _timer?.cancel();
    _pages.dispose();
    super.dispose();
  }

  /// Runs only while there's more than one card and no finger on them.
  void _schedule() {
    _timer?.cancel();
    if (_count < 2 || _held) return;
    _timer = Timer(widget.interval, () {
      if (!mounted || !_pages.hasClients) return;
      unawaited(
        _pages.animateToPage(
          (_page + 1) % _count,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final top = ref.watch(countryTopProvider).value;
    final champion = ref.watch(recentChampionProvider).value;
    final coming = ref.watch(comingUpProvider).value;
    // Keyed, so a card that appears or goes doesn't hand its place (and
    // state) to the next one.
    final cards = [
      if (top != null) _TopCard(top, key: const ValueKey('top')),
      if (champion != null)
        _ChampionCard(champion, key: const ValueKey('champion')),
      if (coming != null) _ComingUpCard(coming, key: const ValueKey('coming')),
    ];

    if (cards.length != _count) {
      _count = cards.length;
      if (_page >= _count) _page = 0;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _schedule();
      });
    }
    if (cards.isEmpty) return const SizedBox.shrink();

    final p = context.palette;
    final height = MediaQuery.textScalerOf(context).scale(176);
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        children: [
          Listener(
            onPointerDown: (_) {
              _held = true;
              _timer?.cancel();
            },
            onPointerUp: (_) {
              _held = false;
              _schedule();
            },
            onPointerCancel: (_) {
              _held = false;
              _schedule();
            },
            child: SizedBox(
              height: height,
              child: PageView(
                controller: _pages,
                onPageChanged: (i) {
                  setState(() => _page = i);
                  _schedule();
                },
                children: [
                  for (final card in cards)
                    Padding(
                      key: card.key,
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: card,
                    ),
                ],
              ),
            ),
          ),
          if (cards.length > 1) ...[
            const SizedBox(height: 10),
            ExcludeSemantics(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < cards.length; i++)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: i == _page ? 18 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: i == _page ? p.foreground : p.input,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// The colours each card wears, the same by day and at night.
abstract final class _Tone {
  static const blue = (Color(0xFF2424F2), Colors.white);
  static const gold = (Color(0xFFF5B301), Color(0xFF16130A));
  static const violet = (Color(0xFF6A3DF2), Colors.white);
}

/// One rotating card: a coloured panel with a small label, its content,
/// and the whole panel as the button.
class _ShowcaseCard extends StatelessWidget {
  const _ShowcaseCard({
    required this.tone,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.child,
  });

  final (Color, Color) tone;
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final (fill, ink) = tone;
    return Semantics(
      button: true,
      child: Material(
        color: fill,
        shape: TonitsShape.rounded(TonitsRadius.panel),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: DefaultTextStyle.merge(
              style: TextStyle(color: ink),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon, size: 16, color: ink.withValues(alpha: 0.8)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: ink.withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(child: child),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TopCard extends ConsumerWidget {
  const _TopCard(this.top, {super.key});

  final CountryTop top;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final (_, ink) = _Tone.blue;
    final code = ref.watch(currentPlayerProvider.select((p) => p?.countryCode));
    final country = Country.byCode(code)?.name ?? code ?? '';
    final myRank = top.me?.rank;
    return _ShowcaseCard(
      tone: _Tone.blue,
      icon: Icons.leaderboard_rounded,
      label: l.showcaseTopTitle(country),
      onTap: () => context.go(Routes.rankings),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final player in top.top)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  SizedBox(
                    width: 30,
                    child: Text(
                      '${player.rank ?? '–'}',
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      player.displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (player.rating != null)
                    Text(
                      Format.number(player.rating!),
                      style: TextStyle(
                        fontSize: 14,
                        color: ink.withValues(alpha: 0.85),
                      ),
                    ),
                ],
              ),
            ),
          const Spacer(),
          Text(
            myRank == null
                ? l.showcaseUnranked
                : l.showcaseYourSpot(Format.number(myRank)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: ink.withValues(alpha: 0.85),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChampionCard extends StatelessWidget {
  const _ChampionCard(this.champion, {super.key});

  final Champion champion;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final (_, ink) = _Tone.gold;
    return _ShowcaseCard(
      tone: _Tone.gold,
      icon: Icons.emoji_events_rounded,
      label: l.showcaseChampionTitle,
      onTap: () => context.go(Routes.competition(champion.competition.id)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  champion.winner.displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.8,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l.showcaseChampionWon(champion.competition.name),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: ink.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Icon(
            Icons.emoji_events_rounded,
            size: 64,
            color: ink.withValues(alpha: 0.15),
          ),
        ],
      ),
    );
  }
}

class _ComingUpCard extends ConsumerWidget {
  const _ComingUpCard(this.competition, {super.key});

  final Competition competition;

  Future<void> _toggle(BuildContext context, WidgetRef ref, bool on) async {
    // Read before the await: the row may turn past this card meanwhile.
    final messenger = ScaffoldMessenger.maybeOf(context);
    final failed = context.l10n.showcaseReminderFailed;
    try {
      await ref
          .read(reminderChoicesProvider.notifier)
          .choose(competition, on: !on);
    } on Object {
      messenger?.showSnackBar(SnackBar(content: Text(failed)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final (fill, ink) = _Tone.violet;
    final c = competition;
    final choices = ref.watch(reminderChoicesProvider);
    final reminder = choices.set[c.id] ?? c.reminderSet;
    final busy = choices.sending.contains(c.id);
    return _ShowcaseCard(
      tone: _Tone.violet,
      icon: Icons.event_rounded,
      label: l.showcaseComingTitle,
      onTap: () => context.go(Routes.competition(c.id)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            c.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.6,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l.showcaseOpens(Format.dateTime(c.registrationOpensAt!, l)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14, color: ink.withValues(alpha: 0.85)),
          ),
          const Spacer(),
          // Only when the API offers reminders.
          if (reminder != null)
            SizedBox(
              height: 36,
              child: FilledButton.icon(
                onPressed: busy ? null : () => _toggle(context, ref, reminder),
                icon: Icon(
                  reminder
                      ? Icons.notifications_active_rounded
                      : Icons.notifications_none_rounded,
                  size: 18,
                ),
                label: Text(
                  reminder ? l.showcaseReminderOn : l.showcaseRemindMe,
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: reminder ? Colors.transparent : ink,
                  foregroundColor: reminder ? ink : fill,
                  disabledBackgroundColor: ink.withValues(alpha: 0.5),
                  disabledForegroundColor: fill,
                  side: reminder ? BorderSide(color: ink) : null,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
