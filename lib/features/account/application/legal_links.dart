import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../auth/data/models.dart';
import 'account_providers.dart';
import '../../auth/application/auth_providers.dart';

/// Opens the current version of a legal document in the browser. Returns
/// false when it couldn't be found or opened.
Future<bool> openLegalDocument(WidgetRef ref, LegalDocumentType type) async {
  try {
    final docs = await ref.read(legalDocumentsProvider.future);
    final doc = docs.where((d) => d.type == type).firstOrNull;
    if (doc == null) return false;
    final url = ref.read(authRepositoryProvider).resolve(doc.contentUrl);
    return await launchUrl(url);
  } catch (_) {
    ref.invalidate(legalDocumentsProvider);
    return false;
  }
}
