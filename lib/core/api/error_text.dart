import '../l10n.dart';
import 'api_client.dart';

/// Turns an API failure into a sentence for the player.
String describeError(Object error, AppLocalizations l) {
  if (error is NetworkException) return l.errorNetwork;
  if (error is! ApiException) return l.errorGeneric;

  switch (error.code) {
    case 'username_taken' || 'handle_taken':
      return l.errorUsernameTaken;
    case 'konami_id_taken':
      return l.errorKonamiIdTaken;
    case 'account_unavailable':
      return l.errorAccountUnavailable;
    case 'invalid_code':
      return l.errorInvalidCode;
    case 'sign_in_unavailable':
      return l.errorSignInUnavailable;
    case 'invalid_identity_token':
      return l.errorInvalidIdentityToken;
    case 'identity_provider_unavailable':
      return l.errorIdentityProviderUnavailable;
    case 'invalid_konami_id':
      return l.errorInvalidKonamiId;
    case 'invalid_username' || 'invalid_handle':
      return l.errorInvalidUsername;
    case 'invalid_country':
      return l.errorInvalidCountry;
    case 'profile_incomplete':
      return l.errorProfileIncomplete;
    case 'email_taken':
      return l.errorEmailTaken;
    case 'email_already_verified':
      return l.errorEmailAlreadyVerified;
    case 'email_unavailable':
      return l.errorEmailUnavailable;
    case 'invalid_email':
      return l.errorInvalidEmail;
    case 'phone_taken':
      return l.errorPhoneTaken;
    case 'invalid_phone':
      return l.errorInvalidPhone;
    case 'invalid_display_name':
      return l.errorInvalidDisplayName;
    case 'withdrawal_closed':
      return l.errorWithdrawalClosed;
    case 'refund_request_exists':
      return l.errorRefundRequestExists;
    case 'rate_limited' || 'payment_rate_limited' || 'avatar_rate_limited':
      final wait = error.retryAfter;
      if (wait == null) return l.errorRateLimited;
      return wait.inSeconds < 60
          ? l.errorRateLimitedSeconds(wait.inSeconds)
          : l.errorRateLimitedMinutes((wait.inSeconds / 60).ceil());
  }
  if (error.status >= 500) return l.errorServer;
  // The API's own message, in English, for anything not mapped yet.
  return error.message;
}
