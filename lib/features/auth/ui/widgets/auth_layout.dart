import 'package:flutter/material.dart';

import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';

/// Shared layout for the signed-out screens: a title over a scrolling form,
/// with an optional line pinned to the bottom of the screen (such as "New to
/// Tonits?"). Screens pushed on top get a plain back arrow; the first screen
/// shows the brand.
class AuthLayout extends StatelessWidget {
  const AuthLayout({
    super.key,
    required this.title,
    this.subtitle,
    required this.children,
    this.footer,
    this.showBack,
  });

  final String title;
  final String? subtitle;
  final List<Widget> children;
  final Widget? footer;

  /// Whether to show a back arrow; by default, when there's a screen to go
  /// back to.
  final bool? showBack;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final canPop = showBack ?? Navigator.canPop(context);
    final top = MediaQuery.paddingOf(context).top;
    const overlap = HeroScaffold.overlap;

    return Scaffold(
      // The sheet's colour, so it runs on below short forms.
      backgroundColor: p.card,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(gradient: HeroScaffold.wash(p)),
                    padding: EdgeInsets.fromLTRB(
                      TonitsSpace.lg,
                      top + TonitsSpace.md,
                      TonitsSpace.lg,
                      TonitsSpace.xl + overlap,
                    ),
                    child: _Centred(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (canPop)
                            RoundIconButton(
                              icon: Icons.arrow_back,
                              tooltip: 'Back',
                              background: p.card.withValues(alpha: 0.85),
                              onPressed: () => Navigator.of(context).maybePop(),
                            )
                          else
                            const BrandLockup(),
                          SizedBox(height: canPop ? 28 : 48),
                          Semantics(
                            header: true,
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.9,
                                height: 1.12,
                              ),
                            ),
                          ),
                          if (subtitle != null) ...[
                            const SizedBox(height: 10),
                            Text(
                              subtitle!,
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.45,
                                color: p.subtleForeground,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -overlap),
                    child: Material(
                      color: p.card,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(TonitsRadius.sheet),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          TonitsSpace.lg,
                          28,
                          TonitsSpace.lg,
                          0,
                        ),
                        child: _Centred(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: children,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Pinned below the scrolling form.
          if (footer != null)
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  TonitsSpace.lg,
                  TonitsSpace.sm,
                  TonitsSpace.lg,
                  TonitsSpace.md,
                ),
                child: footer,
              ),
            ),
        ],
      ),
    );
  }
}

/// Keeps forms a readable width on tablets.
class _Centred extends StatelessWidget {
  const _Centred({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 420),
      child: child,
    ),
  );
}

/// A centred "Question? Action" line, as at the bottom of sign in.
class AuthFooterLink extends StatelessWidget {
  const AuthFooterLink({
    super.key,
    required this.prompt,
    required this.action,
    required this.onPressed,
  });

  final String prompt;
  final String action;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(prompt, style: TextStyle(color: context.palette.subtleForeground)),
        TextButton(onPressed: onPressed, child: Text(action)),
      ],
    );
  }
}
