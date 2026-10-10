import 'api_client.dart';

/// Turns an API failure into a sentence for the player.
String describeError(Object error) {
  if (error is NetworkException) {
    return "Can't reach Tonits. Check your connection and try again.";
  }
  if (error is! ApiException) return 'Something went wrong. Try again.';

  switch (error.code) {
    case 'invalid_credentials':
      return "That Konami ID and password don't match.";
    case 'username_taken':
      return 'That username is taken. Try another.';
    case 'konami_id_taken':
      return 'That Konami ID already has an account. Sign in instead.';
    case 'account_unavailable':
      return 'This account is suspended. Contact Tonits support.';
    case 'invalid_code':
      return 'That code is wrong or has expired.';
    case 'rate_limited':
      final wait = error.retryAfter;
      if (wait == null) {
        return 'Too many attempts. Wait a moment and try again.';
      }
      final minutes = (wait.inSeconds / 60).ceil();
      return wait.inSeconds < 60
          ? 'Too many attempts. Try again in ${wait.inSeconds} seconds.'
          : 'Too many attempts. Try again in $minutes minute${minutes == 1 ? '' : 's'}.';
  }
  if (error.status >= 500) {
    return 'Tonits is having trouble right now. Try again shortly.';
  }
  return error.message;
}
