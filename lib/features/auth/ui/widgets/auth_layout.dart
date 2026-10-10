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
  });

  final String title;
  final String? subtitle;
  final List<Widget> children;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final canPop = Navigator.canPop(context);
    return Scaffold(
      appBar: canPop ? AppBar() : null,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  TonitsSpace.lg,
                  0,
                  TonitsSpace.lg,
                  TonitsSpace.lg,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: canPop ? TonitsSpace.sm : 40),
                        if (!canPop) ...[
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: BrandLockup(),
                          ),
                          const SizedBox(height: 48),
                        ],
                        Semantics(
                          header: true,
                          child: Text(title, style: text.headlineMedium),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: TonitsSpace.sm),
                          Text(
                            subtitle!,
                            style: text.bodyLarge?.copyWith(
                              color: context.palette.subtleForeground,
                            ),
                          ),
                        ],
                        const SizedBox(height: TonitsSpace.xl),
                        ...children,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Pinned below the scrolling form.
            if (footer != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  TonitsSpace.lg,
                  TonitsSpace.sm,
                  TonitsSpace.lg,
                  TonitsSpace.md,
                ),
                child: footer,
              ),
          ],
        ),
      ),
    );
  }
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
