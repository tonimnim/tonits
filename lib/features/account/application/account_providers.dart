import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../../auth/application/auth_providers.dart';
import '../../auth/data/models.dart';
import '../data/account_repository.dart';
import 'account_service.dart';

final accountRepositoryProvider = Provider<AccountRepository>(
  (ref) => AccountRepository(ref.watch(apiClientProvider)),
);

final accountServiceProvider = Provider<AccountService>(AccountService.new);

/// The current Terms and Privacy Notice, fetched when first opened.
final legalDocumentsProvider = FutureProvider.autoDispose<List<LegalDocument>>(
  (ref) => ref.watch(authRepositoryProvider).currentLegalDocuments(),
);
