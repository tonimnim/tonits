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
    case 'invalid_recovery_code':
      return "That Konami ID and recovery code don't match.";
    case 'sign_in_unavailable':
      return "That sign-in option isn't available yet. Try again later.";
    case 'invalid_identity_token':
      return "Sign-in didn't go through. Try again.";
    case 'identity_provider_unavailable':
      return "Can't reach the sign-in service right now. Try again shortly.";
    case 'invalid_konami_id':
      return 'Enter the Konami ID exactly as eFootball shows it.';
    case 'invalid_username':
      return 'Use 3 to 24 letters, numbers, underscores or dots.';
    case 'invalid_country':
      return 'Choose your country.';
    case 'profile_incomplete':
      return 'Finish setting up your account first.';
    case 'email_taken':
      return 'That email belongs to another account.';
    case 'email_already_verified':
      return 'That email is already verified on your account.';
    case 'email_unavailable':
      return "We can't send email right now. Try again shortly.";
    case 'invalid_email':
      return "That doesn't look like an email address.";
    case 'phone_taken':
      return 'That number belongs to another account. Tonits support can '
          'help its owner.';
    case 'invalid_phone':
      return 'Enter the full number with its country code.';
    case 'invalid_display_name':
      return 'Use 2 to 80 characters.';
    case 'weak_password':
      return 'Choose a stronger password.';
    case 'rate_limited' || 'payment_rate_limited':
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
