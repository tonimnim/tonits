import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/error_text.dart';
import '../../../core/l10n.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../application/notifications_providers.dart';
import '../data/notification_preferences.dart';

/// Which notifications the player gets, on the phone and by email. Each
/// switch saves at once.
class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l.notifSettings)),
      body: switch (ref.watch(notificationPreferencesProvider)) {
        AsyncData(value: final prefs) => ListView(
          padding: const EdgeInsets.fromLTRB(
            TonitsSpace.md,
            TonitsSpace.sm,
            TonitsSpace.md,
            TonitsSpace.xl,
          ),
          children: [
            SettingsGroup(
              title: l.notifOnPhone,
              rows: [
                _Switch(
                  prefs: prefs,
                  channel: NotificationChannel.matchPush,
                  icon: Icons.sports_esports_outlined,
                  label: l.notifMatches,
                  hint: l.notifMatchesHint,
                ),
                _Switch(
                  prefs: prefs,
                  channel: NotificationChannel.resultPush,
                  icon: Icons.scoreboard_outlined,
                  label: l.notifResults,
                  hint: l.notifResultsHint,
                ),
                _Switch(
                  prefs: prefs,
                  channel: NotificationChannel.competitionPush,
                  icon: Icons.emoji_events_outlined,
                  label: l.notifCompetitions,
                  hint: l.notifCompetitionsHint,
                ),
              ],
            ),
            const SizedBox(height: TonitsSpace.lg),
            SettingsGroup(
              title: l.notifByEmail,
              rows: [
                _Switch(
                  prefs: prefs,
                  channel: NotificationChannel.matchEmail,
                  icon: Icons.mail_outline,
                  label: l.notifEmailMatches,
                ),
                _Switch(
                  prefs: prefs,
                  channel: NotificationChannel.competitionEmail,
                  icon: Icons.mail_outline,
                  label: l.notifEmailCompetitions,
                ),
                _Switch(
                  prefs: prefs,
                  channel: NotificationChannel.marketingEmail,
                  icon: Icons.campaign_outlined,
                  label: l.notifMarketing,
                  hint: l.notifMarketingHint,
                ),
              ],
            ),
          ],
        ),
        AsyncError(:final error) => ErrorState(
          message: describeError(error, l),
          onRetry: () => ref.invalidate(notificationPreferencesProvider),
        ),
        _ => const LoadingState(),
      },
    );
  }
}

class _Switch extends ConsumerWidget {
  const _Switch({
    required this.prefs,
    required this.channel,
    required this.icon,
    required this.label,
    this.hint,
  });

  final NotificationPreferences prefs;
  final NotificationChannel channel;
  final IconData icon;
  final String label;
  final String? hint;

  Future<void> _set(BuildContext context, WidgetRef ref, bool on) async {
    final problem = await ref
        .read(notificationPreferencesProvider.notifier)
        .set(channel, on: on);
    if (problem != null && context.mounted) showMessage(context, problem);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final on = channel.of(prefs);
    return MergeSemantics(
      child: InkWell(
        onTap: () => _set(context, ref, !on),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
          child: Row(
            children: [
              Icon(icon, size: 20, color: p.subtleForeground),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label),
                    if (hint != null)
                      Text(
                        hint!,
                        style: TextStyle(
                          fontSize: 12,
                          color: p.mutedForeground,
                        ),
                      ),
                  ],
                ),
              ),
              Switch(value: on, onChanged: (v) => _set(context, ref, v)),
            ],
          ),
        ),
      ),
    );
  }
}
