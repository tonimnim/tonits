import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/error_text.dart';
import '../../../core/clock.dart';
import '../../../core/format.dart';
import '../../../core/l10n.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../application/account_providers.dart';
import '../data/security.dart';

/// The devices signed in to the account, this one first. Any other can be
/// signed out from here.
class DevicesScreen extends ConsumerStatefulWidget {
  const DevicesScreen({super.key});

  @override
  ConsumerState<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends ConsumerState<DevicesScreen> {
  /// The session being signed out.
  String? _signingOut;

  Future<void> _signOut(DeviceSession session) async {
    final l = context.l10n;
    final name = deviceLabel(session, l);
    final confirmed = await confirmAction(
      context,
      title: l.devicesSignOutTitle(name),
      message: l.devicesSignOutMessage,
      confirmLabel: l.devicesSignOut,
    );
    if (!confirmed || !mounted) return;
    setState(() => _signingOut = session.id);
    String message;
    try {
      await ref.read(accountServiceProvider).signOutDevice(session.id);
      message = l.devicesSignedOut(name);
    } catch (e) {
      message = describeError(e, l);
    }
    if (!mounted) return;
    setState(() => _signingOut = null);
    showMessage(context, message);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final now = ref.watch(clockProvider).value;
    return Scaffold(
      appBar: AppBar(title: Text(l.devicesTitle)),
      body: switch (ref.watch(mySessionsProvider)) {
        AsyncData(value: final sessions) => RefreshIndicator(
          onRefresh: () => ref.refresh(mySessionsProvider.future),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              TonitsSpace.md,
              TonitsSpace.sm,
              TonitsSpace.md,
              TonitsSpace.xl,
            ),
            children: [
              for (final (i, session) in sessions.indexed) ...[
                if (i > 0) const Divider(height: 1),
                _DeviceRow(
                  session: session,
                  now: now,
                  busy: _signingOut == session.id,
                  onSignOut: session.current || _signingOut != null
                      ? null
                      : () => _signOut(session),
                ),
              ],
            ],
          ),
        ),
        AsyncError(:final error) => ErrorState(
          message: describeError(error, l),
          onRetry: () => ref.invalidate(mySessionsProvider),
        ),
        _ => const LoadingState(),
      },
    );
  }
}

/// What to call a device: the name it signed in with, else a guess from
/// its browser or app, else "Unknown device".
String deviceLabel(DeviceSession session, AppLocalizations l) {
  final name = session.deviceName.trim();
  // Early builds named the platform in lower case.
  if (name.isNotEmpty) {
    return name.replaceAll(RegExp(r'\bandroid\b'), 'Android');
  }
  final agent = session.userAgent.toLowerCase();
  if (agent.contains('iphone')) return 'iPhone';
  if (agent.contains('ipad')) return 'iPad';
  if (agent.contains('android')) return 'Android';
  if (agent.contains('macintosh')) return 'Mac';
  if (agent.contains('windows')) return 'Windows';
  return l.devicesUnknown;
}

/// "Active now", "Active 5 min ago", "Active 3 h ago", "Active
/// yesterday", then the date. This device is always active now.
String _lastActive(DeviceSession session, DateTime now, AppLocalizations l) {
  final passed = now.difference(session.lastUsedAt);
  if (session.current || passed.inMinutes < 1) return l.devicesActiveNow;
  if (passed.inMinutes < 60) return l.devicesActiveMinutes(passed.inMinutes);
  if (passed.inHours < 24) return l.devicesActiveHours(passed.inHours);
  if (passed.inHours < 48) return l.devicesActiveYesterday;
  return l.devicesActiveOn(Format.date(session.lastUsedAt, now: now));
}

class _DeviceRow extends StatelessWidget {
  const _DeviceRow({
    required this.session,
    required this.now,
    required this.busy,
    required this.onSignOut,
  });

  final DeviceSession session;
  final DateTime? now;
  final bool busy;
  final VoidCallback? onSignOut;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final label = deviceLabel(session, l);
    final hint = '$label ${session.userAgent}'.toLowerCase();
    final icon = hint.contains('android')
        ? Icons.phone_android
        : hint.contains('ios') || hint.contains('iphone')
        ? Icons.phone_iphone
        : Icons.devices_other_outlined;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          IconDot(icon: icon),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  _lastActive(session, now ?? DateTime.now(), l),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: p.mutedForeground),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (session.current)
            StatusBadge(l.devicesThisDevice, tone: StatusTone.good)
          else if (busy)
            const SizedBox.square(
              dimension: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else
            TextButton(onPressed: onSignOut, child: Text(l.devicesSignOut)),
        ],
      ),
    );
  }
}
