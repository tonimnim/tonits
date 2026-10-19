import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n.dart';
import '../../../core/providers.dart';
import '../data/evidence_repository.dart';
import 'screenshot_uploader.dart';

final evidenceRepositoryProvider = Provider<EvidenceRepository>(
  (ref) => EvidenceRepository(ref.watch(apiClientProvider)),
);

/// The wait before each verification check: 2 to 10 seconds, growing.
final evidencePollDelayProvider = Provider<Duration Function(int attempt)>(
  (ref) =>
      (attempt) => Duration(seconds: (2 * (attempt + 1)).clamp(2, 10)),
);

final screenshotUploaderProvider = Provider<ScreenshotUploader>(
  (ref) => ScreenshotUploader(
    ref.watch(evidenceRepositoryProvider),
    ref.watch(evidencePollDelayProvider),
    ref.watch(l10nProvider),
  ),
);
