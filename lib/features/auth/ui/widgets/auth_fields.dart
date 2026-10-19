import 'package:flutter/material.dart';

import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';

class KonamiIdField extends StatelessWidget {
  const KonamiIdField({
    super.key,
    required this.controller,
    required this.validator,
    this.helper,
    this.enabled = true,
    this.autofill = true,
  });

  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final String? helper;
  final bool enabled;
  final bool autofill;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return LabeledField(
      label: context.l10n.accountKonamiIdLabel,
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        autocorrect: false,
        autofillHints: autofill ? const [AutofillHints.username] : null,
        textInputAction: TextInputAction.next,
        validator: validator,
        // A locked ID is still the answer, so keep it readable rather than
        // greyed out like a placeholder.
        style: enabled ? null : TextStyle(color: palette.subtleForeground),
        decoration: InputDecoration(
          hintText: 'ABCD-1234-EFGH',
          helperText: helper,
          fillColor: enabled ? null : palette.muted,
        ),
      ),
    );
  }
}
