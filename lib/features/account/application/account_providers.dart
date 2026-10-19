import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

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

/// The player's own photo, as a short-lived link, or null without one.
final myAvatarProvider = FutureProvider.autoDispose<Uri?>((ref) async {
  if (ref.watch(currentPlayerProvider) == null) return null;
  return ref.watch(accountRepositoryProvider).myAvatarUrl();
});

/// Lets the player choose a profile photo and returns it scaled down, or
/// null when they cancel. Tests supply their own.
final photoPickerProvider = Provider<Future<Uint8List?> Function()>(
  (ref) => () async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 88,
      requestFullMetadata: false,
    );
    return file?.readAsBytes();
  },
);
