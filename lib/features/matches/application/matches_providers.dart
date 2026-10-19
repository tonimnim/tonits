import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/api/paged.dart';
import '../../../core/providers.dart';
import '../data/match_room.dart';
import '../data/match_room_repository.dart';
import '../data/match_summary.dart';
import '../data/matches_repository.dart';
import 'match_room_controller.dart';
import 'my_matches_notifier.dart';

final matchesRepositoryProvider = Provider<MatchesRepository>(
  (ref) => MatchesRepository(ref.watch(apiClientProvider)),
);

/// The player's soonest active match, if any, for Home.
final nextMatchProvider = FutureProvider.autoDispose<MatchSummary?>((
  ref,
) async {
  final page = await ref
      .watch(matchesRepositoryProvider)
      .mine(kind: MatchListKind.active, limit: 1);
  return page.items.firstOrNull;
});

final myMatchesProvider = AsyncNotifierProvider.autoDispose
    .family<MyMatchesNotifier, Paged<MatchSummary>, MatchListKind>(
      MyMatchesNotifier.new,
    );

final matchRoomRepositoryProvider = Provider<MatchRoomRepository>(
  (ref) => MatchRoomRepository(ref.watch(apiClientProvider)),
);

/// How often a live room is read again: quickly while the other player
/// has a deadline running, slowly otherwise. Tests lengthen both.
final matchRoomPollIntervalsProvider =
    Provider<({Duration fast, Duration slow})>(
      (ref) => (
        fast: const Duration(seconds: 10),
        slow: const Duration(seconds: 30),
      ),
    );

final matchRoomProvider = AsyncNotifierProvider.autoDispose
    .family<MatchRoomController, MatchRoom, String>(MatchRoomController.new);

/// Lets the player choose a screenshot from their photos and returns its
/// original bytes, or null when they cancel. Tests supply their own.
final screenshotPickerProvider = Provider<Future<Uint8List?> Function()>(
  (ref) => () async {
    // No resizing or quality options: those would re-encode the image, and
    // the screenshot reader needs the original.
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      requestFullMetadata: false,
    );
    return file?.readAsBytes();
  },
);
