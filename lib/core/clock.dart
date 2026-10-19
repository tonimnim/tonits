import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The current time, ticking every second, for countdowns. Tests replace it
/// with a fixed time so screens settle.
final clockProvider = StreamProvider<DateTime>((ref) async* {
  yield DateTime.now();
  yield* Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
});

/// "9:41 left", "1 h 20 min left", or null once [deadline] has passed.
String? timeLeft(DateTime deadline, DateTime now) {
  final left = deadline.difference(now);
  if (left <= Duration.zero) return null;
  if (left.inHours >= 1) {
    final minutes = left.inMinutes.remainder(60);
    return '${left.inHours} h${minutes == 0 ? '' : ' $minutes min'} left';
  }
  final seconds = left.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '${left.inMinutes}:$seconds left';
}
