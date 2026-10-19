import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../auth/application/auth_providers.dart';
import '../../../auth/ui/validators.dart';

/// The username, checked with the server as the player types (after a
/// short pause), so a taken name shows before they continue.
class UsernameField extends ConsumerStatefulWidget {
  const UsernameField({
    super.key,
    required this.controller,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final VoidCallback onSubmitted;

  @override
  ConsumerState<UsernameField> createState() => _UsernameFieldState();
}

enum _Availability { unknown, checking, available, taken }

class _UsernameFieldState extends ConsumerState<UsernameField> {
  Timer? _debounce;
  var _availability = _Availability.unknown;

  /// The name the latest answer is about, so a late answer is ignored.
  String? _asked;

  @override
  void initState() {
    super.initState();
    unawaited(_check(widget.controller.text));
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    if (AuthValidators.username(value, context.l10n) != null) {
      setState(() => _availability = _Availability.unknown);
      return;
    }
    setState(() => _availability = _Availability.checking);
    _debounce = Timer(const Duration(milliseconds: 300), () => _check(value));
  }

  Future<void> _check(String value) async {
    final name = value.trim();
    if (AuthValidators.username(name, ref.read(l10nProvider)) != null) return;
    _asked = name;
    try {
      final free = await ref
          .read(authRepositoryProvider)
          .usernameAvailable(name);
      if (!mounted || _asked != name) return;
      setState(
        () => _availability = free
            ? _Availability.available
            : _Availability.taken,
      );
    } catch (_) {
      // Not knowing is fine; submitting checks again.
      if (mounted && _asked == name) {
        setState(() => _availability = _Availability.unknown);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final (helper, icon) = switch (_availability) {
      _Availability.available => (
        l.onboardingUsernameAvailable,
        Icon(Icons.check_circle, size: 20, color: p.good.$1),
      ),
      _Availability.checking => (
        l.onboardingUsernameChecking,
        const SizedBox.square(
          dimension: 16,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      _ => (l.onboardingUsernameHelper, null),
    };
    return LabeledField(
      label: l.onboardingUsernameLabel,
      child: TextFormField(
        controller: widget.controller,
        autofocus: true,
        autocorrect: false,
        textInputAction: TextInputAction.next,
        onChanged: _onChanged,
        onFieldSubmitted: (_) => widget.onSubmitted(),
        validator: (value) =>
            AuthValidators.username(value, l) ??
            (_availability == _Availability.taken
                ? l.errorUsernameTaken
                : null),
        autovalidateMode: _availability == _Availability.taken
            ? AutovalidateMode.always
            : AutovalidateMode.disabled,
        decoration: InputDecoration(
          hintText: 'striker.9',
          helperText: helper,
          helperStyle: _availability == _Availability.available
              ? TextStyle(color: p.good.$1, fontWeight: FontWeight.w600)
              : null,
          suffixIcon: icon == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: Center(widthFactor: 1, child: icon),
                ),
        ),
      ),
    );
  }
}
