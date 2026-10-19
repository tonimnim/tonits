import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../data/match_room.dart';
import '../../data/match_summary.dart';

/// How to find the opponent in eFootball and set up the Friend Match:
/// their User ID and in-game name to copy, then the server's steps.
class FriendMatchCard extends StatelessWidget {
  const FriendMatchCard({
    super.key,
    required this.opponent,
    required this.instructions,
  });

  final MatchParticipant opponent;
  final List<FriendMatchInstruction> instructions;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final account = opponent.gameAccount;

    void copy(String what, String value) {
      Clipboard.setData(ClipboardData(text: value));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('$what copied')));
    }

    final copyIcon = Icon(
      Icons.copy_rounded,
      size: 18,
      color: p.mutedForeground,
    );
    final mono = monoFont.copyWith(color: p.subtleForeground, fontSize: 14);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SettingsGroup(
          title: 'Find ${opponent.displayName} in eFootball',
          rows: account == null
              ? [
                  const SettingsRow(
                    icon: Icons.sports_esports_outlined,
                    label: 'No eFootball account linked',
                  ),
                ]
              : [
                  if (account.userId case final id?)
                    SettingsRow(
                      icon: Icons.tag,
                      label: 'User ID',
                      value: id,
                      valueStyle: mono,
                      trailing: copyIcon,
                      onTap: () => copy('User ID', id),
                    ),
                  SettingsRow(
                    icon: Icons.person_search_outlined,
                    label: 'In-game name',
                    value: account.inGameName,
                    trailing: copyIcon,
                    onTap: () => copy('In-game name', account.inGameName),
                  ),
                  SettingsRow(
                    icon: account.platform == 'ios'
                        ? Icons.phone_iphone
                        : Icons.phone_android,
                    label: 'Plays on',
                    value: account.platform == 'ios' ? 'iPhone' : 'Android',
                  ),
                ],
        ),
        if (account != null && account.userId == null) ...[
          const SizedBox(height: TonitsSpace.sm),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              "They haven't added their User ID, so search for their "
              'in-game name.',
              style: TextStyle(fontSize: 13, color: p.mutedForeground),
            ),
          ),
        ],
        if (instructions.isNotEmpty) ...[
          const SizedBox(height: TonitsSpace.lg),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: const SectionLabel('Setting up the Friend Match'),
          ),
          const SizedBox(height: TonitsSpace.sm),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(TonitsSpace.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final (i, step) in instructions.indexed) ...[
                    if (i > 0) const SizedBox(height: TonitsSpace.md),
                    _Instruction(number: i + 1, step: step),
                  ],
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _Instruction extends StatelessWidget {
  const _Instruction({required this.number, required this.step});

  final int number;
  final FriendMatchInstruction step;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: p.soft, shape: BoxShape.circle),
          child: Text(
            '$number',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: p.onSoft,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                step.title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 2),
              Text(
                step.detail,
                style: TextStyle(fontSize: 13, color: p.subtleForeground),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
