import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../application/auth_controller.dart';
import 'widgets/auth_layout.dart';
import 'widgets/form_error.dart';

/// Shows a just-issued recovery code once, and asks the player to save it
/// before going on: the server keeps only its hash.
class RecoveryCodeScreen extends StatefulWidget {
  const RecoveryCodeScreen({
    super.key,
    required this.code,
    required this.onDone,
    this.replacesOld = false,
  });

  final String code;
  final VoidCallback onDone;

  /// The code replaces one that no longer works (after a reset, or a new code
  /// from settings).
  final bool replacesOld;

  @override
  State<RecoveryCodeScreen> createState() => _RecoveryCodeScreenState();
}

class _RecoveryCodeScreenState extends State<RecoveryCodeScreen> {
  bool _saved = false;
  String? _error;

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.code));
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Recovery code copied')));
  }

  void _continue() {
    if (!_saved) {
      setState(() => _error = "Tick the box once you've saved your code.");
      return;
    }
    widget.onDone();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    // Leaving now would lose the code for good, so back is disabled; the
    // player continues once they've saved it.
    return PopScope(
      canPop: false,
      child: AuthLayout(
        showBack: false,
        title: widget.replacesOld
            ? 'Save your new recovery code'
            : 'Save your recovery code',
        subtitle: widget.replacesOld
            ? 'Your old code no longer works. Keep this one somewhere safe: '
                  "if you forget your password, it's how you get back in."
            : "If you forget your password, this code is how you get back "
                  "in. We can't show it again.",
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: TonitsSpace.md,
              vertical: TonitsSpace.lg,
            ),
            decoration: BoxDecoration(
              color: p.card,
              borderRadius: BorderRadius.circular(TonitsRadius.card),
              border: Border.all(color: p.input),
            ),
            child: Semantics(
              label: 'Recovery code ${widget.code.split('').join(' ')}',
              excludeSemantics: true,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: SelectableText(
                  widget.code,
                  textAlign: TextAlign.center,
                  style: monoFont.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    color: p.foreground,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: TonitsSpace.md),
          SecondaryButton(
            label: 'Copy code',
            icon: Icons.copy_rounded,
            onPressed: _copy,
          ),
          const SizedBox(height: TonitsSpace.md),
          Text(
            'Save it in your password manager or notes, take a screenshot, or '
            'write it down. Anyone with this code and your Konami ID can '
            'reset your password, so keep it private.',
            style: TextStyle(fontSize: 13, color: p.subtleForeground),
          ),
          const SizedBox(height: TonitsSpace.lg),
          CheckboxListTile(
            value: _saved,
            onChanged: (value) => setState(() {
              _saved = value ?? false;
              _error = null;
            }),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            title: const Text("I've saved my recovery code"),
          ),
          const SizedBox(height: TonitsSpace.sm),
          FormError(_error),
          PrimaryButton(label: 'Continue', onPressed: _continue),
        ],
      ),
    );
  }
}

/// The recovery code issued by sign-up or a reset, shown before the player
/// reaches the app. The router sends them here while one is pending.
class PendingRecoveryCodeScreen extends ConsumerWidget {
  const PendingRecoveryCodeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authControllerProvider);
    final code = state.pendingRecoveryCode;
    if (code == null) return const SizedBox.shrink();
    return RecoveryCodeScreen(
      code: code,
      replacesOld: state.recoveryCodeReplacesOld,
      onDone: () =>
          ref.read(authControllerProvider.notifier).acknowledgeRecoveryCode(),
    );
  }
}
