import 'package:flutter/material.dart';

import '../../../../core/theme.dart';

/// The layout every account edit screen shares: a title, a sentence on
/// what the change does, then the form.
class AccountFormPage extends StatelessWidget {
  const AccountFormPage({
    super.key,
    required this.title,
    required this.intro,
    required this.children,
  });

  final String title;
  final String intro;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            TonitsSpace.lg,
            TonitsSpace.sm,
            TonitsSpace.lg,
            TonitsSpace.xl,
          ),
          children: [
            Text(
              intro,
              style: TextStyle(color: context.palette.subtleForeground),
            ),
            const SizedBox(height: TonitsSpace.lg),
            ...children,
          ],
        ),
      ),
    );
  }
}

/// Leaves an edit screen and confirms the change on the screen below.
void popWithMessage(BuildContext context, String message) {
  final messenger = ScaffoldMessenger.of(context);
  Navigator.of(context).pop();
  messenger.showSnackBar(SnackBar(content: Text(message)));
}
