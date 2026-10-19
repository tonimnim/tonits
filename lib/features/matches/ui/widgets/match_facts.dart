import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/l10n.dart';
import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../data/match_room.dart';

/// The match's facts as three small tiles, then its competition.
class MatchFacts extends StatelessWidget {
  const MatchFacts({super.key, required this.room});

  final MatchRoom room;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final match = room.summary;
    final kickOff = match.scheduledAt?.toLocal();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FactRow(
          children: [
            FactTile(
              icon: Icons.sports_soccer_outlined,
              label: l.matchFormat,
              value: room.bestOf == 1
                  ? l.matchFormatOneGame
                  : l.matchFormatBestOf(room.bestOf),
            ),
            FactTile(
              icon: Icons.schedule,
              label: kickOff == null
                  ? l.matchKickOff
                  : DateFormat('d MMM').format(kickOff),
              value: kickOff == null
                  ? l.matchNotSet
                  : DateFormat.Hm().format(kickOff),
            ),
            FactTile(
              icon: Icons.tag,
              label: l.matchCode,
              value: room.code.isEmpty ? '—' : room.code,
              mono: true,
              onTap: room.code.isEmpty
                  ? null
                  : () => copyToClipboard(
                      context,
                      room.code,
                      what: l.matchCodeName,
                    ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Panel(
          radius: TonitsRadius.tile,
          padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
          onTap: () => context.go(Routes.competition(match.competitionId)),
          child: Row(
            children: [
              const IconDot(icon: Icons.emoji_events_outlined),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      match.competitionName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      room.drawAllowed
                          ? l.matchDrawsCount
                          : l.matchPenaltiesIfLevel,
                      style: TextStyle(fontSize: 13, color: p.mutedForeground),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, size: 20, color: p.mutedForeground),
            ],
          ),
        ),
      ],
    );
  }
}
