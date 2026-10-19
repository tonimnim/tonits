import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/error_text.dart';
import '../../../core/routes.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../account/application/legal_links.dart';
import '../application/auth_controller.dart';
import '../data/models.dart';
import 'widgets/provider_buttons.dart';
import 'widgets/welcome_orbit.dart';

/// The first screen: what Tonits is, and one tap to continue with Google
/// (and Apple on iPhone). New players go on to onboarding.
class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  IdentityMethod? _busy;
  String? _error;

  Future<void> _continue(IdentityMethod method) async {
    if (_busy != null) return;
    setState(() {
      _busy = method;
      _error = null;
    });
    try {
      await ref.read(authControllerProvider.notifier).signInWith(method);
    } catch (e) {
      if (mounted) setState(() => _error = describeError(e));
    } finally {
      if (mounted) setState(() => _busy = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final apple = ref.watch(appleSignInOfferedProvider);
    return Scaffold(
      backgroundColor: p.card,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(gradient: HeroScaffold.wash(p)),
              child: SafeArea(bottom: false, child: const _Pitch()),
            ),
          ),
          // The sheet, rounded over the bottom of the hero.
          Transform.translate(
            offset: const Offset(0, -HeroScaffold.overlap),
            child: Material(
              color: p.card,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(TonitsRadius.sheet),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    TonitsSpace.lg,
                    28,
                    TonitsSpace.lg,
                    0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Sign up or sign in',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        apple
                            ? 'New to Ozone? Continue with Google or Apple to '
                                  'create your account. Already playing? The '
                                  'same button signs you in.'
                            : 'New to Ozone? Continue with Google to create '
                                  'your account. Already playing? The same '
                                  'button signs you in.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.45,
                          color: p.subtleForeground,
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (_error != null) ...[
                        Notice(_error!),
                        const SizedBox(height: TonitsSpace.md),
                      ],
                      GoogleButton(
                        busy: _busy == IdentityMethod.google,
                        onPressed: () => _continue(IdentityMethod.google),
                      ),
                      if (apple) ...[
                        const SizedBox(height: 12),
                        AppleButton(
                          busy: _busy == IdentityMethod.apple,
                          onPressed: () => _continue(IdentityMethod.apple),
                        ),
                      ],
                      const SizedBox(height: TonitsSpace.md),
                      const _FinePrint(),
                      if (kDebugMode)
                        TextButton(
                          onPressed: () => context.push(Routes.devSignIn),
                          child: const Text('Developer sign-in'),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The brand, the orbit and the promise, sized to the space left above the
/// sheet.
class _Pitch extends StatelessWidget {
  const _Pitch();

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return LayoutBuilder(
      builder: (context, constraints) {
        final orbit = (constraints.maxHeight - 250).clamp(120.0, 280.0);
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            TonitsSpace.lg,
            TonitsSpace.md,
            TonitsSpace.lg,
            HeroScaffold.overlap + TonitsSpace.md,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  constraints.maxHeight -
                  HeroScaffold.overlap -
                  TonitsSpace.md * 2,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: BrandLockup(),
                ),
                const SizedBox(height: TonitsSpace.lg),
                WelcomeOrbit(size: orbit),
                const SizedBox(height: TonitsSpace.lg),
                Column(
                  children: [
                    Semantics(
                      header: true,
                      child: const Text(
                        'Your game, ranked.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.9,
                          height: 1.12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Enter eFootball competitions, play your matches and '
                      "climb your country's ladder.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.45,
                        color: p.subtleForeground,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// The Terms and Privacy Notice, one tap away. They're accepted when the
/// player finishes onboarding.
class _FinePrint extends ConsumerWidget {
  const _FinePrint();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    TextSpan link(String label, LegalDocumentType type) => TextSpan(
      text: label,
      style: TextStyle(color: p.primary, fontWeight: FontWeight.w600),
      recognizer: TapGestureRecognizer()
        ..onTap = () => openLegalDocument(ref, type),
    );
    return Text.rich(
      TextSpan(
        style: TextStyle(fontSize: 13, height: 1.5, color: p.mutedForeground),
        children: [
          const TextSpan(text: 'By continuing you agree to the '),
          link('Terms', LegalDocumentType.terms),
          const TextSpan(text: ' and '),
          link('Privacy Notice', LegalDocumentType.privacy),
          const TextSpan(text: '.'),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
