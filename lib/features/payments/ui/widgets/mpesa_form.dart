import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/kenyan_phone.dart';
import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';

/// The amount and the M-Pesa number the prompt goes to.
class MpesaForm extends StatefulWidget {
  const MpesaForm({
    super.key,
    required this.amount,
    required this.initialPhone,
    required this.onPay,
    this.error,
  });

  /// Formatted, such as "Ksh 100".
  final String amount;
  final String? initialPhone;
  final ValueChanged<String> onPay;
  final String? error;

  @override
  State<MpesaForm> createState() => _MpesaFormState();
}

class _MpesaFormState extends State<MpesaForm> {
  final _form = GlobalKey<FormState>();
  late final _phone = TextEditingController(text: _local(widget.initialPhone));

  /// A saved +254 number, shown the way Kenyans write it.
  static String _local(String? phone) {
    final normalized = phone == null ? null : KenyanPhone.normalize(phone);
    return normalized == null ? '' : '0${normalized.substring(4)}';
  }

  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_form.currentState!.validate()) return;
    widget.onPay(KenyanPhone.normalize(_phone.text)!);
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    return Form(
      key: _form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(TonitsSpace.lg),
            decoration: BoxDecoration(
              color: p.card,
              borderRadius: BorderRadius.circular(TonitsRadius.card),
              border: Border.all(color: p.border),
            ),
            child: Column(
              children: [
                Text(
                  l.paymentEntryFee,
                  style: TextStyle(fontSize: 13, color: p.subtleForeground),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.amount,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: TonitsSpace.lg),
          LabeledField(
            label: l.paymentMpesaNumber,
            child: TextFormField(
              controller: _phone,
              keyboardType: TextInputType.phone,
              autofillHints: const [AutofillHints.telephoneNumber],
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d +]')),
              ],
              validator: (v) => KenyanPhone.validate(v, l),
              onFieldSubmitted: (_) => _submit(),
              decoration: InputDecoration(
                hintText: '0712 345 678',
                helperText: l.paymentPhoneHelper,
              ),
            ),
          ),
          const SizedBox(height: TonitsSpace.lg),
          if (widget.error != null) ...[
            Notice(widget.error!),
            const SizedBox(height: TonitsSpace.md),
          ],
          PrimaryButton(label: l.paymentSendRequest, onPressed: _submit),
        ],
      ),
    );
  }
}
