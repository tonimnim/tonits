import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/format.dart';
import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../data/match_room.dart';

/// The match's facts: its competition, format, times and reference code.
class MatchDetails extends StatelessWidget {
  const MatchDetails({super.key, required this.room});

  final MatchRoom room;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final match = room.summary;
    return SettingsGroup(
      title: 'Details',
      rows: [
        SettingsRow(
          icon: Icons.emoji_events_outlined,
          label: 'Competition',
          value: match.competitionName,
          onTap: () => context.go(Routes.competition(match.competitionId)),
        ),
        SettingsRow(
          icon: Icons.sports_soccer_outlined,
          label: 'Format',
          value: [
            room.bestOf == 1 ? 'One game' : 'Best of ${room.bestOf}',
            room.drawAllowed ? 'draws count' : 'penalties if level',
          ].join(', '),
        ),
        if (match.scheduledAt != null)
          SettingsRow(
            icon: Icons.event_outlined,
            label: 'Kick-off',
            value: Format.dateTime(match.scheduledAt!),
          ),
        if (room.code.isNotEmpty)
          SettingsRow(
            icon: Icons.confirmation_number_outlined,
            label: 'Match code',
            value: room.code,
            valueStyle: monoFont.copyWith(
              color: p.subtleForeground,
              fontSize: 14,
            ),
            trailing: Icon(
              Icons.copy_rounded,
              size: 18,
              color: p.mutedForeground,
            ),
            onTap: () {
              Clipboard.setData(ClipboardData(text: room.code));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Match code copied')),
              );
            },
          ),
      ],
    );
  }
}
