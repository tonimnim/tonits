import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// How long Home's "Find your next competition" card stays away after the
/// player taps it or closes it. Someone who opens the app now and then sees
/// it about twice a day; a new install sees it at once.
const findCardSnooze = Duration(hours: 8);

/// Where the device keeps when that card was last tapped or closed.
abstract interface class FindCardStore {
  Future<DateTime?> snoozedAt();
  Future<void> write(DateTime at);
}

class SecureFindCardStore implements FindCardStore {
  SecureFindCardStore([FlutterSecureStorage? storage])
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const _key = 'orbits_find_card_snoozed_at';

  @override
  Future<DateTime?> snoozedAt() async =>
      DateTime.tryParse(await _storage.read(key: _key) ?? '');

  @override
  Future<void> write(DateTime at) =>
      _storage.write(key: _key, value: at.toUtc().toIso8601String());
}

final findCardStoreProvider = Provider<FindCardStore>(
  (ref) => SecureFindCardStore(),
);

/// When the card was last tapped or closed; null if never.
final findCardSnoozeProvider =
    AsyncNotifierProvider<FindCardSnoozeNotifier, DateTime?>(
      FindCardSnoozeNotifier.new,
    );

class FindCardSnoozeNotifier extends AsyncNotifier<DateTime?> {
  @override
  Future<DateTime?> build() => ref.watch(findCardStoreProvider).snoozedAt();

  /// Hides the card from [now]. It goes at once; saving follows.
  Future<void> snooze(DateTime now) async {
    state = AsyncData(now);
    try {
      await ref.read(findCardStoreProvider).write(now);
    } on Object {
      // Not saved: it comes back on the next launch, which is harmless.
    }
  }
}

/// Whether the card is resting at [now].
bool findCardSnoozed(DateTime? at, DateTime now) =>
    at != null && now.difference(at) < findCardSnooze;
