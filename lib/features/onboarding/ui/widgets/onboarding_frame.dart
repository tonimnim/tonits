import 'package:flutter/material.dart';

import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';

/// One onboarding step's frame: a tinted top with the progress, the step's
/// title and why it's asked, then the field on a rounded sheet with the
/// step's button at the bottom.
class OnboardingFrame extends StatelessWidget {
  const OnboardingFrame({
    super.key,
    required this.step,
    required this.steps,
    required this.title,
    required this.subtitle,
    required this.child,
    required this.action,
    this.onBack,
    this.trailing,
  });

  final int step;
  final int steps;
  final String title;
  final String subtitle;
  final Widget child;

  /// The step's button, and anything under it.
  final Widget action;
  final VoidCallback? onBack;

  /// Top right, such as a sign-out link on the first step.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Scaffold(
      backgroundColor: p.card,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(gradient: HeroScaffold.wash(p)),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  TonitsSpace.lg,
                  TonitsSpace.sm,
                  TonitsSpace.lg,
                  TonitsSpace.xl + HeroScaffold.overlap,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 44,
                      child: Row(
                        children: [
                          if (onBack != null)
                            RoundIconButton(
                              icon: Icons.arrow_back,
                              tooltip: 'Back',
                              background: p.card.withValues(alpha: 0.85),
                              onPressed: onBack,
                            ),
                          const Spacer(),
                          trailing ??
                              Pill(
                                'Step ${step + 1} of $steps',
                                filled: p.card,
                              ),
                        ],
                      ),
                    ),
                    const SizedBox(height: TonitsSpace.lg),
                    _Progress(step: step, steps: steps),
                    const SizedBox(height: 28),
                    Semantics(
                      header: true,
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.8,
                          height: 1.15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.45,
                        color: p.subtleForeground,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Transform.translate(
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
                      TonitsSpace.md,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(child: SingleChildScrollView(child: child)),
                        const SizedBox(height: TonitsSpace.md),
                        action,
                      ],
                    ),
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

/// One segment per step, filled up to the current one.
class _Progress extends StatelessWidget {
  const _Progress({required this.step, required this.steps});

  final int step;
  final int steps;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Semantics(
      label: 'Step ${step + 1} of $steps',
      excludeSemantics: true,
      child: Row(
        children: [
          for (var i = 0; i < steps; i++) ...[
            if (i > 0) const SizedBox(width: 6),
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 5,
                decoration: BoxDecoration(
                  color: i <= step ? p.primary : p.card.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
