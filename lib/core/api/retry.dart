import 'api_client.dart';

/// When a provider whose load failed tries again, or null to show the error.
///
/// Riverpod would otherwise retry any exception ten times over about 40
/// seconds, with the screen on a spinner the whole time, even for answers
/// that won't change (a 404, a 403) and for a 429 that asked for a wait. Only
/// a dropped connection, a timeout or a server error is worth a quick second
/// try; everything else shows the error and its Retry button at once.
Duration? retryApiLoad(int retryCount, Object error) {
  if (retryCount >= maxLoadRetries) return null;
  if (error is NetworkException) return _backoff(retryCount);
  if (error is ApiException) {
    if (error.status == 429) {
      final wait = error.retryAfter;
      // A long wait is better shown than spun through.
      return wait == null
          ? _backoff(retryCount)
          : (wait <= maxRetryWait ? wait : null);
    }
    if (error.status == 408 || error.status >= 500) return _backoff(retryCount);
  }
  return null;
}

/// Tries after the first failure, before the error shows.
const maxLoadRetries = 2;

/// The longest `Retry-After` the app waits through on a spinner.
const maxRetryWait = Duration(seconds: 10);

Duration _backoff(int retryCount) => Duration(seconds: 1 << retryCount);
