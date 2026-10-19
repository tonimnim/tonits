import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/generated/app_localizations.dart';

export '../l10n/generated/app_localizations.dart';

extension L10nContext on BuildContext {
  /// The player-facing text in the app's language.
  AppLocalizations get l10n => AppLocalizations.of(this);
}

/// The same text for code without a BuildContext, such as controllers
/// that report a failure. Follows the device's languages, falling back to
/// English.
final l10nProvider = Provider<AppLocalizations>(
  (ref) => lookupAppLocalizations(
    basicLocaleListResolution(
      PlatformDispatcher.instance.locales,
      AppLocalizations.supportedLocales,
    ),
  ),
);
