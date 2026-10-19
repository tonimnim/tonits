import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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
    final match = room.summary;
    final kickOff = match.scheduledAt?.toLocal();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FactRow(
          children: [
            FactTile(
              icon: Icons.sports_soccer_outlined,
              label: 'Format',
              value: room.bestOf == 1 ? '1 game' : 'Best of ${room.bestOf}',
            ),
            FactTile(
              icon: Icons.schedule,
              label: kickOff == null
                  ? 'Kick-off'
                  : DateFormat('d MMM').format(kickOff),
              value: kickOff == null
                  ? 'Not set'
                  : DateFormat.Hm().format(kickOff),
            ),
            FactTile(
              icon: Icons.tag,
              label: 'Code',
              value: room.code.isEmpty ? '—' : room.code,
              mono: true,
              onTap: room.code.isEmpty
                  ? null
                  : () {
                      Clipboard.setData(ClipboardData(text: room.code));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Match code copied')),
                      );
                    },
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
                      room.drawAllowed ? 'Draws count' : 'Penalties if level',
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
