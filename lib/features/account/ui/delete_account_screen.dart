import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/error_text.dart';
import '../../../core/clock.dart';
import '../../../core/format.dart';
import '../../../core/l10n.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../auth/ui/widgets/form_error.dart';
import '../application/account_providers.dart';
import '../data/security.dart';

/// Deleting the account, in the API's two steps: a request, then after a
/// 24-hour wait, deleting for good by typing DELETE. A pending request can
/// be cancelled at any point.
class DeleteAccountScreen extends ConsumerStatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  ConsumerState<DeleteAccountScreen> createState() =>
      _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends ConsumerState<DeleteAccountScreen>
    with BusyState {
  final _confirmation = TextEditingController();

  @override
  void dispose() {
    _confirmation.dispose();
    super.dispose();
  }

  Future<void> _request() async {
    final l = context.l10n;
    final confirmed = await confirmAction(
      context,
      title: l.deleteRequestTitle,
      message: l.deleteRequestMessage,
      confirmLabel: l.deleteRequest,
    );
    if (!confirmed) return;
    await run(() async {
      await ref.read(accountServiceProvider).requestDeletion();
      if (mounted) showMessage(context, l.deleteRequested);
    });
  }

  Future<void> _cancel() async {
    final l = context.l10n;
    await run(() async {
      await ref.read(accountServiceProvider).cancelDeletion();
      if (mounted) showMessage(context, l.deleteCancelled);
    });
  }

  // Signing out takes the player to Welcome; nothing to show after.
  Future<void> _delete(String requestId) =>
      run(() => ref.read(accountServiceProvider).deleteAccount(requestId));

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final now = ref.watch(clockProvider).value ?? DateTime.now();
    return Scaffold(
      appBar: AppBar(title: Text(l.deleteTitle)),
      body: switch (ref.watch(deletionRequestProvider)) {
        AsyncData(value: final request) => ListView(
          padding: const EdgeInsets.fromLTRB(
            TonitsSpace.lg,
            TonitsSpace.sm,
            TonitsSpace.lg,
            TonitsSpace.xl,
          ),
          children: _body(request, now),
        ),
        AsyncError(:final error) => ErrorState(
          message: describeError(error, l),
          onRetry: () => ref.invalidate(deletionRequestProvider),
        ),
        _ => const LoadingState(),
      },
    );
  }

  List<Widget> _body(DeletionRequest? request, DateTime now) {
    final p = context.palette;
    final l = context.l10n;
    final text = TextStyle(height: 1.5, color: p.subtleForeground);
    final intro = Text(l.deleteIntro, style: text);

    if (request?.status != DeletionStatus.pending) {
      return [
        intro,
        const SizedBox(height: TonitsSpace.sm),
        Text(l.deleteWaitNote, style: text),
        const SizedBox(height: TonitsSpace.lg),
        FormError(error),
        SecondaryButton(
          label: l.deleteRequest,
          destructive: true,
          onPressed: busy ? null : _request,
        ),
      ];
    }
    final pending = request!;
    final cancel = SecondaryButton(
      label: l.deleteCancel,
      onPressed: busy ? null : _cancel,
    );

    if (now.isBefore(pending.executeAfter)) {
      return [
        intro,
        const SizedBox(height: TonitsSpace.lg),
        Panel(
          radius: TonitsRadius.tile,
          child: Row(
            children: [
              const IconDot(icon: Icons.schedule),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.deleteAvailableFrom,
                      style: TextStyle(fontSize: 12, color: p.mutedForeground),
                    ),
                    Text(
                      Format.dateTime(pending.executeAfter, l, now: now),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: TonitsSpace.lg),
        FormError(error),
        cancel,
      ];
    }

    final typed = _confirmation.text.trim() == 'DELETE';
    return [
      Text(l.deleteReady, style: text),
      const SizedBox(height: TonitsSpace.md),
      LabeledField(
        label: l.deleteConfirmLabel,
        child: TextField(
          controller: _confirmation,
          autocorrect: false,
          enableSuggestions: false,
          textCapitalization: TextCapitalization.characters,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(hintText: 'DELETE'),
        ),
      ),
      const SizedBox(height: TonitsSpace.lg),
      FormError(error),
      PrimaryButton(
        label: l.deleteForGood,
        destructive: true,
        busy: busy,
        onPressed: typed ? () => _delete(pending.id) : null,
      ),
      const SizedBox(height: TonitsSpace.sm),
      cancel,
    ];
  }
}
