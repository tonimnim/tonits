// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcomeHeadline => 'Your game, ranked.';

  @override
  String get welcomePitch =>
      'Enter eFootball competitions, play your matches and climb your country\'s ladder.';

  @override
  String get welcomeSheetTitle => 'Sign up or sign in';

  @override
  String get welcomeSheetBody =>
      'New to Ozone? Continue with Google to create your account. Already playing? The same button signs you in.';

  @override
  String get welcomeSheetBodyWithApple =>
      'New to Ozone? Continue with Google or Apple to create your account. Already playing? The same button signs you in.';

  @override
  String get welcomeContinueWithGoogle => 'Continue with Google';

  @override
  String get welcomeContinueWithApple => 'Continue with Apple';

  @override
  String welcomeProviderWorking(String label) {
    return '$label, working';
  }

  @override
  String get welcomeAgreeBefore => 'By continuing you agree to the ';

  @override
  String get welcomeAgreeBetween => ' and ';

  @override
  String get welcomeAgreeAfter => '.';

  @override
  String get welcomeOfflineTitle => 'Can\'t reach Ozone';

  @override
  String get welcomeOfflineBody =>
      'Check your connection. You\'re still signed in.';

  @override
  String get accountLegalTerms => 'Terms';

  @override
  String get accountLegalPrivacy => 'Privacy Notice';

  @override
  String get accountKonamiIdLabel => 'Konami ID';

  @override
  String get accountMpesaNumberLabel => 'M-Pesa number';

  @override
  String get accountPhoneNumberLabel => 'Phone number';

  @override
  String get accountDisplayName => 'Display name';

  @override
  String get accountEmailTitle => 'Email';

  @override
  String get accountSave => 'Save';

  @override
  String onboardingStepOf(int step, int steps) {
    return 'Step $step of $steps';
  }

  @override
  String get onboardingUsernameTitle => 'Pick your username';

  @override
  String get onboardingUsernameSubtitle =>
      'It\'s how players see you in matches and on the ladder.';

  @override
  String get onboardingKonamiIdTitle => 'Link eFootball';

  @override
  String get onboardingKonamiIdSubtitle =>
      'Your Konami ID connects Ozone to your eFootball account. Enter it exactly as the game shows it.';

  @override
  String get onboardingCountryTitle => 'Where do you play from?';

  @override
  String get onboardingCountrySubtitle =>
      'Your country decides your ladder and the competitions you can enter.';

  @override
  String get onboardingPhoneTitle => 'Your phone number';

  @override
  String get onboardingPhoneSubtitleMpesa =>
      'Your M-Pesa number, for paying entry fees. Other players never see it.';

  @override
  String get onboardingPhoneSubtitle =>
      'For paying entry fees. Other players never see it.';

  @override
  String get onboardingFinish => 'Finish';

  @override
  String get onboardingContinue => 'Continue';

  @override
  String get onboardingAcceptBefore => 'By finishing you accept the ';

  @override
  String get onboardingAcceptBetween => ' and the ';

  @override
  String get onboardingAcceptAfter => '.';

  @override
  String get onboardingUsernameLabel => 'Username';

  @override
  String get onboardingUsernameAvailable => 'Available';

  @override
  String get onboardingUsernameChecking => 'Checking…';

  @override
  String get onboardingUsernameHelper => 'Letters, numbers, _ and .';

  @override
  String get profileRestricted =>
      'Your account is restricted. Contact Ozone support to find out why.';

  @override
  String get profileAboutTitle => 'About';

  @override
  String get profileTermsOfService => 'Terms of Service';

  @override
  String profileCouldNotOpen(String document) {
    return 'Couldn\'t open the $document. Try again.';
  }

  @override
  String get profileAccountTitle => 'Account';

  @override
  String get profileNotLinked => 'Not linked';

  @override
  String profileChangeCountryTitle(String country) {
    return 'Change your country to $country?';
  }

  @override
  String get profileChangeCountryMessage =>
      'Your country ranking and the competitions open to you follow your country.';

  @override
  String get profileChangeCountryConfirm => 'Change';

  @override
  String profileCountryChanged(String country) {
    return 'Country changed to $country';
  }

  @override
  String get profileContactTitle => 'Contact';

  @override
  String get profilePhone => 'Phone';

  @override
  String get profileAdd => 'Add';

  @override
  String profileMemberSince(String date) {
    return 'Member since $date';
  }

  @override
  String get profileSignInTitle => 'Sign-in';

  @override
  String get profileLinked => 'Linked';

  @override
  String get profileKonamiIdAndPassword => 'Konami ID and password';

  @override
  String get profileTestAccount => 'Test account';

  @override
  String get profileSignOut => 'Sign out';

  @override
  String get profileSignOutTitle => 'Sign out of Ozone?';

  @override
  String get profileSignOutMessage =>
      'You can sign back in any time with the same Google or Apple account.';

  @override
  String get accountEditNameIntro =>
      'The name opponents see in matches, rankings and on your profile. Your username stays the same.';

  @override
  String get accountEnterDisplayName => 'Enter a display name';

  @override
  String get accountDisplayNameLength => 'Use 2 to 80 characters';

  @override
  String get accountYourNameHint => 'Your name';

  @override
  String get accountDisplayNameUpdated => 'Display name updated';

  @override
  String get accountEnterEmail => 'Enter your email';

  @override
  String get accountEmailInvalid => 'Enter a valid email address';

  @override
  String accountNewCodeSent(String email) {
    return 'New code sent to $email';
  }

  @override
  String get accountEmailVerified => 'Email verified';

  @override
  String get accountEmailIntroAdd =>
      'With a verified email you can reset a forgotten password. We\'ll send a code to confirm it.';

  @override
  String accountEmailIntroChange(String email) {
    return 'Your email is $email. Enter a new address and it replaces this one once confirmed.';
  }

  @override
  String get accountNewEmailLabel => 'New email';

  @override
  String get accountSendCode => 'Send code';

  @override
  String get accountCodeExpiresSoon => 'It expires soon.';

  @override
  String accountCodeExpiresIn(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'It expires in $minutes minutes.',
      one: 'It expires in 1 minute.',
    );
    return '$_temp0';
  }

  @override
  String get accountCheckEmailTitle => 'Check your email';

  @override
  String accountCodeSentIntro(String email, String expiry) {
    return 'We sent a 6-digit code to $email. $expiry';
  }

  @override
  String get accountCodeLabel => 'Code';

  @override
  String get accountVerify => 'Verify';

  @override
  String get accountSendNewCode => 'Send a new code';

  @override
  String get accountUseAnotherEmail => 'Use another email';

  @override
  String get accountPhoneSaved => 'Phone number saved';

  @override
  String get accountRemovePhoneTitle => 'Remove your phone number?';

  @override
  String get accountRemovePhoneMessage =>
      'You\'ll enter a number each time you pay an entry fee.';

  @override
  String get accountRemove => 'Remove';

  @override
  String get accountPhoneRemoved => 'Phone number removed';

  @override
  String get accountPhoneIntroMpesa =>
      'Your M-Pesa number. Entry fees are requested from it, so you don\'t type it each time.';

  @override
  String get accountPhoneIntro =>
      'Saved for paying entry fees. Other players never see it.';

  @override
  String get accountRemovePhone => 'Remove phone number';

  @override
  String get competitionsTitle => 'Competitions';

  @override
  String get competitionFilterOpen => 'Open';

  @override
  String get competitionFilterUpcoming => 'Upcoming';

  @override
  String get competitionFilterFinished => 'Finished';

  @override
  String get competitionsEmptyOpen => 'Nothing open right now';

  @override
  String get competitionsEmptyUpcoming => 'Nothing announced yet';

  @override
  String get competitionsEmptyFinished => 'No finished competitions';

  @override
  String get competitionsEmptyOpenMessage =>
      'New competitions open for registration regularly.';

  @override
  String get competitionFormatSingleElimination => 'Single elimination';

  @override
  String get competitionFormatDoubleElimination => 'Double elimination';

  @override
  String get competitionFormatRoundRobin => 'Round robin';

  @override
  String get competitionFormatUnknown => 'Competition';

  @override
  String get competitionStatusOpen => 'Open';

  @override
  String get competitionStatusUpcoming => 'Upcoming';

  @override
  String get competitionStatusCheckIn => 'Check-in';

  @override
  String get competitionStatusRunning => 'In progress';

  @override
  String get competitionStatusFinished => 'Finished';

  @override
  String get competitionStatusCancelled => 'Cancelled';

  @override
  String get competitionKenyaOnly => 'Kenya only';

  @override
  String get competitionFactEntry => 'Entry';

  @override
  String get competitionFree => 'Free';

  @override
  String get competitionFactPrize => 'Prize';

  @override
  String get competitionFactFormat => 'Format';

  @override
  String get competitionStarts => 'Starts';

  @override
  String get competitionRegistration => 'Registration';

  @override
  String get competitionPlayers => 'Players';

  @override
  String get competitionAbout => 'About';

  @override
  String competitionClosesOn(String dateTime) {
    return 'Closes $dateTime';
  }

  @override
  String competitionByOrganizer(String organizer) {
    return 'by $organizer';
  }

  @override
  String get competitionFreeEntry => 'Free entry';

  @override
  String competitionPaidEntry(String fee) {
    return '$fee entry';
  }

  @override
  String competitionFormatStarts(String format, String dateTime) {
    return '$format · Starts $dateTime';
  }

  @override
  String competitionPrize(String amount) {
    return 'Prize $amount';
  }

  @override
  String competitionPlacesLeft(int count) {
    return '$count left';
  }

  @override
  String competitionCapacity(int entries, int max) {
    return '$entries of $max players';
  }

  @override
  String get competitionWithdrawTitle => 'Withdraw from this competition?';

  @override
  String get competitionWithdrawMessage =>
      'Your place goes back to the pool. You can enter again while registration is open.';

  @override
  String get competitionWithdraw => 'Withdraw';

  @override
  String get competitionStayIn => 'Stay in';

  @override
  String get competitionEligibilityFailed =>
      'Couldn\'t check whether you can enter.';

  @override
  String get competitionCheckPayment => 'Check your payment';

  @override
  String get competitionEnterFree => 'Enter for free';

  @override
  String competitionPayWithMpesa(String fee) {
    return 'Pay $fee with M-Pesa';
  }

  @override
  String get competitionRefundInProgress => 'Your entry fee is being refunded.';

  @override
  String get competitionCannotEnter => 'You can\'t enter this competition.';

  @override
  String get competitionYoureIn => 'You\'re in';

  @override
  String get paymentTitle => 'Pay with M-Pesa';

  @override
  String get paymentNotConfirmed =>
      'We couldn\'t confirm the request with M-Pesa. Try again; you won\'t be charged twice.';

  @override
  String get paymentUnderReview => 'Payment under review';

  @override
  String get paymentUnderReviewMessage =>
      'We\'re checking this payment with M-Pesa. You won\'t be charged twice, and you\'ll be notified when it\'s settled.';

  @override
  String get paymentCheckAgain => 'Check again';

  @override
  String get paymentYoureIn => 'You\'re in';

  @override
  String paymentConfirmed(String amount) {
    return 'Paid $amount. Your place is confirmed.';
  }

  @override
  String get paymentNoPlaceLeft => 'Paid, but no place left';

  @override
  String paymentNoPlaceLeftMessage(String amount) {
    return 'The places filled or registration closed before your payment arrived. A full refund of $amount is on its way.';
  }

  @override
  String get paymentRefunded => 'Refunded';

  @override
  String paymentRefundedMessage(String amount) {
    return '$amount has been returned to your M-Pesa.';
  }

  @override
  String get paymentEntryRemoved => 'Entry removed';

  @override
  String get paymentEntryRemovedMessage =>
      'Your entry was removed from this competition.';

  @override
  String get paymentFailed => 'Payment didn\'t go through';

  @override
  String get paymentFailedMessage => 'M-Pesa didn\'t confirm the payment.';

  @override
  String get paymentDone => 'Done';

  @override
  String get paymentNotNow => 'Not now';

  @override
  String get paymentCheckYourPhone => 'Check your phone';

  @override
  String get paymentYourPhone => 'your phone';

  @override
  String paymentEnterPin(String phone, String amount) {
    return 'Enter your M-Pesa PIN on $phone to pay $amount.';
  }

  @override
  String get paymentWaiting => 'Waiting for M-Pesa…';

  @override
  String get paymentSlow =>
      'Still waiting? M-Pesa can take a minute. You won\'t be charged twice.';

  @override
  String get paymentEntryFee => 'Entry fee';

  @override
  String get paymentMpesaNumber => 'M-Pesa number';

  @override
  String get paymentPhoneHelper =>
      'A Safaricom number. You\'ll confirm with your PIN.';

  @override
  String get paymentSendRequest => 'Send payment request';

  @override
  String get appName => 'Ozone';

  @override
  String get tabHome => 'Home';

  @override
  String get tabCompete => 'Compete';

  @override
  String get tabMatches => 'Matches';

  @override
  String get tabRankings => 'Rankings';

  @override
  String get tabProfile => 'Profile';

  @override
  String get cancel => 'Cancel';

  @override
  String get back => 'Back';

  @override
  String get tryAgain => 'Try again';

  @override
  String get couldNotLoad => 'Couldn\'t load this';

  @override
  String get couldNotLoadMore => 'Couldn\'t load more. Try again';

  @override
  String copied(String what) {
    return '$what copied';
  }

  @override
  String get countryLabel => 'Country';

  @override
  String get chooseYourCountry => 'Choose your country';

  @override
  String get countrySuggested => 'Suggested';

  @override
  String get countryAll => 'All countries';

  @override
  String get countrySearchHint => 'Search country or code';

  @override
  String get countryNoMatch => 'No country matches that search';

  @override
  String callingCodeLabel(String dialCode, String country) {
    return 'Calling code +$dialCode, $country. Change';
  }

  @override
  String get errorNetwork =>
      'Can\'t reach Ozone. Check your connection and try again.';

  @override
  String get errorGeneric => 'Something went wrong. Try again.';

  @override
  String get errorServer =>
      'Ozone is having trouble right now. Try again shortly.';

  @override
  String get errorUsernameTaken => 'That username is taken. Try another.';

  @override
  String get errorKonamiIdTaken =>
      'That Konami ID is linked to another Ozone account. Contact Ozone support if it\'s yours.';

  @override
  String get errorAccountUnavailable =>
      'This account is suspended. Contact Ozone support.';

  @override
  String get errorInvalidCode => 'That code is wrong or has expired.';

  @override
  String get errorSignInUnavailable =>
      'That sign-in option isn\'t available yet. Try again later.';

  @override
  String get errorInvalidIdentityToken =>
      'Sign-in didn\'t go through. Try again.';

  @override
  String get errorIdentityProviderUnavailable =>
      'Can\'t reach the sign-in service right now. Try again shortly.';

  @override
  String get errorInvalidKonamiId =>
      'Enter the Konami ID exactly as eFootball shows it.';

  @override
  String get errorInvalidUsername =>
      'Use 3 to 24 letters, numbers, underscores or dots.';

  @override
  String get errorInvalidCountry => 'Choose your country.';

  @override
  String get errorProfileIncomplete => 'Finish setting up your account first.';

  @override
  String get errorEmailTaken => 'That email belongs to another account.';

  @override
  String get errorEmailAlreadyVerified =>
      'That email is already verified on your account.';

  @override
  String get errorEmailUnavailable =>
      'We can\'t send email right now. Try again shortly.';

  @override
  String get errorInvalidEmail => 'That doesn\'t look like an email address.';

  @override
  String get errorPhoneTaken =>
      'That number is linked to another Ozone account. Contact Ozone support if it\'s yours.';

  @override
  String get errorInvalidPhone =>
      'Enter the full number with its country code.';

  @override
  String get errorInvalidDisplayName => 'Use 2 to 80 characters.';

  @override
  String get errorRateLimited =>
      'Too many attempts. Wait a moment and try again.';

  @override
  String errorRateLimitedSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'Too many attempts. Try again in $seconds seconds.',
      one: 'Too many attempts. Try again in 1 second.',
    );
    return '$_temp0';
  }

  @override
  String errorRateLimitedMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Too many attempts. Try again in $minutes minutes.',
      one: 'Too many attempts. Try again in 1 minute.',
    );
    return '$_temp0';
  }

  @override
  String formatToday(String time) {
    return 'Today, $time';
  }

  @override
  String formatTomorrow(String time) {
    return 'Tomorrow, $time';
  }

  @override
  String formatYesterday(String time) {
    return 'Yesterday, $time';
  }

  @override
  String formatDateTime(String date, String time) {
    return '$date, $time';
  }

  @override
  String get closed => 'Closed';

  @override
  String closesInMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Closes in $minutes min',
      one: 'Closes in 1 min',
    );
    return '$_temp0';
  }

  @override
  String closesInHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Closes in $hours hours',
      one: 'Closes in 1 hour',
    );
    return '$_temp0';
  }

  @override
  String closesInDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Closes in $days days',
      one: 'Closes in 1 day',
    );
    return '$_temp0';
  }

  @override
  String timeLeftShort(int minutes, String seconds) {
    return '$minutes:$seconds left';
  }

  @override
  String timeLeftHours(int hours) {
    return '$hours h left';
  }

  @override
  String timeLeftHoursMinutes(int hours, int minutes) {
    return '$hours h $minutes min left';
  }

  @override
  String get validateChooseUsername => 'Choose a username';

  @override
  String get validateUsernameLength => 'Use 3 to 24 characters';

  @override
  String get validateUsernameCharacters =>
      'Use letters, numbers, underscores or dots, starting with a letter or number';

  @override
  String get validateEnterKonamiId => 'Enter your Konami ID';

  @override
  String get validateKonamiIdFormat =>
      'Enter the Konami ID exactly as eFootball shows it';

  @override
  String get validateCode => 'Enter the 6-digit code';

  @override
  String get validateEnterPhone => 'Enter your phone number';

  @override
  String get validateEnterMpesaNumber => 'Enter your M-Pesa number';

  @override
  String get validateKenyanMobile =>
      'Enter a Kenyan mobile number, like 0712 345 678';

  @override
  String get validatePhoneInvalid => 'Enter a valid phone number';

  @override
  String get homeGoodMorning => 'Good morning';

  @override
  String get homeGoodAfternoon => 'Good afternoon';

  @override
  String get homeGoodEvening => 'Good evening';

  @override
  String get homeSeeAll => 'See all';

  @override
  String get homeClosingSoon => 'Closing soon';

  @override
  String get homeNothingOpenTitle => 'Nothing open right now';

  @override
  String get homeNothingOpenMessage =>
      'New competitions open for registration regularly.';

  @override
  String get homeRating => 'Rating';

  @override
  String homeRatingSemantics(int rating) {
    return 'Rating $rating';
  }

  @override
  String get homeLast30Days => 'Last 30 days';

  @override
  String homeInCountry(String countryCode) {
    return 'in $countryCode';
  }

  @override
  String get homeUnranked => 'Unranked';

  @override
  String get homeUnratedMessage =>
      'Play your first rated match to get a rating and a place on the ladder.';

  @override
  String get homeFindCompetition => 'Find a competition';

  @override
  String homeMovedUp(int places) {
    String _temp0 = intl.Intl.pluralLogic(
      places,
      locale: localeName,
      other: 'Up $places places',
      one: 'Up 1 place',
    );
    return '$_temp0';
  }

  @override
  String homeMovedDown(int places) {
    String _temp0 = intl.Intl.pluralLogic(
      places,
      locale: localeName,
      other: 'Down $places places',
      one: 'Down 1 place',
    );
    return '$_temp0';
  }

  @override
  String homePlaces(int places) {
    String _temp0 = intl.Intl.pluralLogic(
      places,
      locale: localeName,
      other: '$places places',
      one: '1 place',
    );
    return '$_temp0';
  }

  @override
  String homeCountryLadder(String country) {
    return '$country ladder';
  }

  @override
  String homeTopInCountry(String country) {
    return 'Top in $country';
  }

  @override
  String get homeRecentMatches => 'Recent matches';

  @override
  String get homeOverview => 'Overview';

  @override
  String get homeWinRate => 'Win rate';

  @override
  String homeWinsOfPlayed(int wins, int played) {
    return '$wins of $played won';
  }

  @override
  String get homeMatches => 'Matches';

  @override
  String get homeAllTime => 'All time';

  @override
  String get homeGoalsPerMatch => 'Goals per match';

  @override
  String homeLastMatches(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Last $count matches',
      one: 'Last 1 match',
    );
    return '$_temp0';
  }

  @override
  String get homeCurrentStreak => 'Current streak';

  @override
  String get homeWinsInARow => 'Wins in a row';

  @override
  String get homeLossesInARow => 'Losses in a row';

  @override
  String get homeDrawsInARow => 'Draws in a row';

  @override
  String get homeUpNext => 'Up next';

  @override
  String get homeOpponentToBeDecided => 'Opponent to be decided';

  @override
  String homeCheckInBy(String time) {
    return 'by $time';
  }

  @override
  String playerVersus(String opponent) {
    return 'vs $opponent';
  }

  @override
  String get playerFormerPlayer => 'a former player';

  @override
  String get playerWins => 'Wins';

  @override
  String get playerDraws => 'Draws';

  @override
  String get playerLosses => 'Losses';

  @override
  String playerRecordSemantics(int wins, int draws, int losses) {
    return '$wins wins, $draws draws, $losses losses';
  }

  @override
  String get playerResultWin => 'Win';

  @override
  String get playerResultDraw => 'Draw';

  @override
  String get playerResultLoss => 'Loss';

  @override
  String get playerResultWinLetter => 'W';

  @override
  String get playerResultDrawLetter => 'D';

  @override
  String get playerResultLossLetter => 'L';

  @override
  String get rankingsGlobal => 'Global';

  @override
  String get rankingsEmptyTitle => 'No rankings yet';

  @override
  String get rankingsEmptyMessage =>
      'Players are ranked once they finish rated matches.';

  @override
  String rankingsYou(String name) {
    return '$name (you)';
  }

  @override
  String rankingsMovedUp(int places) {
    return 'Up $places';
  }

  @override
  String rankingsMovedDown(int places) {
    return 'Down $places';
  }

  @override
  String get matchYou => 'You';

  @override
  String get matchOpponent => 'Opponent';

  @override
  String get matchYourOpponent => 'your opponent';

  @override
  String get matchYourOpponentStart => 'Your opponent';

  @override
  String get matchTheScore => 'the score';

  @override
  String matchScoreWithPens(int mine, int theirs, int penMine, int penTheirs) {
    return '$mine–$theirs ($penMine–$penTheirs pens)';
  }

  @override
  String get matchScheduled => 'Scheduled';

  @override
  String get matchCheckIn => 'Check in';

  @override
  String get matchCheckedIn => 'Checked in';

  @override
  String get matchUnderReview => 'Under review';

  @override
  String get matchNoResult => 'No result';

  @override
  String get matchFinished => 'Finished';

  @override
  String get matchFullTime => 'Full time';

  @override
  String get matchReportScore => 'Report the score';

  @override
  String get matchStepOpponentFromEarlierRound =>
      'Your opponent comes from an earlier round.';

  @override
  String matchStepCheckInOpens(String when) {
    return 'Check-in opens $when.';
  }

  @override
  String matchStepKickOff(String when) {
    return 'Kick-off $when.';
  }

  @override
  String get matchStepWeWillLetYouKnow =>
      'We\'ll let you know when it\'s time to play.';

  @override
  String get matchStepCheckInTitle => 'Time to check in';

  @override
  String get matchStepCheckInMessage =>
      'Check in to say you\'re ready. If only one player checks in, that player wins.';

  @override
  String get matchStepCheckedInTitle => 'You\'re checked in';

  @override
  String matchStepCheckedInMessage(String opponent) {
    return 'Waiting for $opponent to check in.';
  }

  @override
  String get matchStepPlayTitle => 'Play your match';

  @override
  String matchStepPlayMessage(String opponent) {
    return 'Play a Friend Match with $opponent in eFootball. When it ends, either of you reports the score.';
  }

  @override
  String get matchStepPlayDeadlineNote =>
      'If nobody reports in time, you are both removed.';

  @override
  String matchStepAwaitingConfirmationTitle(String opponent) {
    return 'Waiting for $opponent to confirm';
  }

  @override
  String matchStepAwaitingConfirmationMessage(String score, String opponent) {
    return 'You reported $score. If $opponent doesn\'t answer in time, your result stands.';
  }

  @override
  String get matchStepConfirmTitle => 'Confirm the result';

  @override
  String matchStepConfirmMessage(String opponent) {
    return '$opponent reported the score above. Is it right? If you don\'t answer in time, it stands.';
  }

  @override
  String get matchStepScreenshotTitle => 'Send your screenshot';

  @override
  String get matchStepScreenshotMessage =>
      'The result was rejected. Send one screenshot of the Full Time screen; Ozone compares both players\' screenshots.';

  @override
  String get matchStepScreenshotDeadlineNote =>
      'If you don\'t send one in time, you\'re removed from the competition.';

  @override
  String get matchStepScreenshotSentTitle => 'Screenshot sent';

  @override
  String get matchStepBothScreenshotsIn =>
      'Both screenshots are in. Ozone will review them.';

  @override
  String matchStepWaitingForScreenshot(String opponent) {
    return 'Waiting for $opponent\'s screenshot. Ozone then checks both.';
  }

  @override
  String get matchStepSettlingTitle => 'Settling the result';

  @override
  String get matchStepSettlingMessage =>
      'A deadline just passed. This takes a few seconds.';

  @override
  String get matchStepUnderReviewMessage =>
      'Ozone is checking both screenshots against the reported score. You\'ll be notified of the decision.';

  @override
  String matchStepOpponentConfirmedYours(String opponent) {
    return '$opponent confirmed your result.';
  }

  @override
  String get matchStepYouConfirmed => 'You confirmed the result.';

  @override
  String get matchStepBothAgreed => 'Both players agreed on the result.';

  @override
  String matchStepOpponentUnanswered(String opponent) {
    return '$opponent didn\'t answer in time, so your result stood.';
  }

  @override
  String get matchStepUnanswered =>
      'The result wasn\'t answered in time, so it stood.';

  @override
  String get matchStepDecidedByReview =>
      'Ozone decided the result after a review.';

  @override
  String get matchStepResultConfirmed => 'The result is confirmed.';

  @override
  String get matchStepOutTitle => 'You\'re out of this competition';

  @override
  String get matchStepOutMessage => 'This match will be settled without you.';

  @override
  String get matchStepUnknownTitle => 'Match';

  @override
  String get matchStepUnknownMessage =>
      'Update Ozone to see where this match stands.';

  @override
  String get matchCancelledNoResultReported =>
      'Nobody reported a score in time, so both players were removed.';

  @override
  String get matchCancelledResponseTimeout =>
      'Neither player sent a screenshot, so both were removed.';

  @override
  String get matchCancelledDoubleNoShow => 'Neither player checked in.';

  @override
  String get matchCancelledCompetitionCancelled =>
      'The competition was cancelled.';

  @override
  String get matchCancelledPlatformReview =>
      'Ozone cancelled the match after a review.';

  @override
  String get matchCancelledNotNeeded =>
      'The bracket no longer needed this match.';

  @override
  String get matchCancelledOther => 'This match was cancelled.';

  @override
  String get matchOutcomeYouWon => 'You won';

  @override
  String get matchOutcomeYouLost => 'You lost';

  @override
  String get matchOutcomeDraw => 'Draw';

  @override
  String matchForfeitOpponentNoCheckIn(String opponent) {
    return '$opponent didn\'t check in.';
  }

  @override
  String get matchForfeitYouNoCheckIn => 'You didn\'t check in in time.';

  @override
  String matchForfeitOpponentLeft(String opponent) {
    return '$opponent had already left the competition.';
  }

  @override
  String get matchForfeitYouLeft =>
      'Your entry had already left the competition.';

  @override
  String matchForfeitOpponentNoScreenshot(String opponent) {
    return '$opponent didn\'t send a screenshot after the result was rejected.';
  }

  @override
  String get matchForfeitYouNoScreenshot =>
      'You didn\'t send a screenshot in time, so you were removed.';

  @override
  String get matchForfeitPlatformReview =>
      'Ozone decided the match after a review.';

  @override
  String get matchForfeitWonWithoutPlaying => 'You won without playing.';

  @override
  String get matchForfeitDecidedWithoutYou =>
      'The match was decided without you.';

  @override
  String get matchErrorOpponentAlreadyReported =>
      'Your opponent already reported the result. Confirm or reject it instead.';

  @override
  String get matchErrorAlreadySubmitted =>
      'Your side already reported the result.';

  @override
  String get matchErrorWindowClosed => 'The time for that has passed.';

  @override
  String get matchErrorInvalidScore =>
      'That score doesn\'t fit this match\'s format.';

  @override
  String get matchErrorMatchChanged =>
      'The match changed. Check the latest and try again.';

  @override
  String get matchErrorCompetitionClosed => 'This competition has ended.';

  @override
  String get matchErrorEvidenceRateLimited =>
      'Too many uploads. Wait a moment and try again.';

  @override
  String get matchRemovedNotice =>
      'This match removed you from the competition.';

  @override
  String get matchInfoLabel => 'Match info';

  @override
  String get matchPenaltyNeedsWinner => 'A penalty shootout needs a winner.';

  @override
  String matchScoreSent(String opponent, int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Score sent. $opponent has $minutes minutes to confirm it.',
      one: 'Score sent. $opponent has 1 minute to confirm it.',
    );
    return '$_temp0';
  }

  @override
  String matchReportIntro(String opponent, int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other:
          'Enter the final score from the Full Time screen. $opponent confirms it, and if they don\'t answer within $minutes minutes, it stands.',
      one:
          'Enter the final score from the Full Time screen. $opponent confirms it, and if they don\'t answer within 1 minute, it stands.',
    );
    return '$_temp0';
  }

  @override
  String get matchPenaltyShootout => 'Penalty shootout';

  @override
  String get matchLevelKnockoutNote =>
      'A level knockout match is decided on penalties.';

  @override
  String get matchSendScore => 'Send score';

  @override
  String get matchDeclaration =>
      'This is the real score. Reporting a false score can get me removed from the competition.';

  @override
  String get matchListActive => 'Active';

  @override
  String get matchListHistory => 'History';

  @override
  String get matchNoActiveTitle => 'No active matches';

  @override
  String get matchNoHistoryTitle => 'No matches played yet';

  @override
  String get matchNoActiveMessage =>
      'Matches appear here once a competition you entered starts.';

  @override
  String get matchNoHistoryMessage =>
      'Your finished matches will be listed here.';

  @override
  String get matchBrowseCompetitions => 'Browse competitions';

  @override
  String get matchTimesUp => 'Time\'s up';

  @override
  String matchUntil(String when) {
    return 'until $when';
  }

  @override
  String matchFind(String name) {
    return 'Find $name';
  }

  @override
  String get matchNoGameAccount =>
      'They haven\'t linked an eFootball account yet.';

  @override
  String get matchNoUserId =>
      'They haven\'t added their User ID, so search for their in-game name.';

  @override
  String get matchAddByUserId =>
      'Add them as a friend in eFootball with their User ID.';

  @override
  String get matchUserId => 'User ID';

  @override
  String get matchInGameName => 'In-game name';

  @override
  String matchCopyLabel(String label) {
    return 'Copy $label';
  }

  @override
  String get matchBadgeReportScore => 'Report score';

  @override
  String get matchBadgeWaitingOnOpponent => 'Waiting on opponent';

  @override
  String get matchBadgeConfirmResult => 'Confirm result';

  @override
  String get matchBadgeSendScreenshots => 'Send screenshots';

  @override
  String get matchBadgeSettling => 'Settling';

  @override
  String get matchBadgeForfeit => 'Forfeit';

  @override
  String get matchBadgeCancelled => 'Cancelled';

  @override
  String get matchBadgeOut => 'Out';

  @override
  String get matchBadgeWon => 'Won';

  @override
  String get matchBadgeLost => 'Lost';

  @override
  String get matchBadgeDrawn => 'Drawn';

  @override
  String matchCheckInBy(String when) {
    return 'Check in by $when';
  }

  @override
  String get matchOpponentToBeDecided => 'Opponent to be decided';

  @override
  String matchVsOpponent(String name) {
    return 'vs $name';
  }

  @override
  String get matchWaitingEarlierRound => 'Waiting for an earlier round';

  @override
  String get matchFormat => 'Format';

  @override
  String get matchFormatOneGame => '1 game';

  @override
  String matchFormatBestOf(int count) {
    return 'Best of $count';
  }

  @override
  String get matchKickOff => 'Kick-off';

  @override
  String get matchNotSet => 'Not set';

  @override
  String get matchCode => 'Code';

  @override
  String get matchCodeName => 'Match code';

  @override
  String get matchDrawsCount => 'Draws count';

  @override
  String get matchPenaltiesIfLevel => 'Penalties if level';

  @override
  String get matchRejectTitle => 'Reject this result?';

  @override
  String matchRejectMessage(String opponent, int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other:
          'You and $opponent will each have $minutes minutes to send a screenshot of the Full Time screen. If you don\'t send one, you\'re removed from the competition.',
      one:
          'You and $opponent will each have 1 minute to send a screenshot of the Full Time screen. If you don\'t send one, you\'re removed from the competition.',
    );
    return '$_temp0';
  }

  @override
  String get matchReject => 'Reject';

  @override
  String get matchToneYourMove => 'Your move';

  @override
  String get matchToneWaiting => 'Waiting';

  @override
  String get matchToneFinal => 'Final';

  @override
  String get matchUploadingScreenshot => 'Uploading your screenshot…';

  @override
  String get matchCheckingScreenshot => 'Checking your screenshot…';

  @override
  String get matchConfirmYes => 'Yes, that\'s right';

  @override
  String get matchConfirmNo => 'No, it\'s wrong';

  @override
  String get matchChooseScreenshot => 'Choose screenshot';

  @override
  String get matchReported => 'Reported';

  @override
  String get matchToBeDecided => 'To be decided';

  @override
  String get matchVs => 'VS';

  @override
  String matchOnPens(int mine, int theirs) {
    return '$mine–$theirs on pens';
  }

  @override
  String matchOneLessFor(String name) {
    return 'One less for $name';
  }

  @override
  String matchOneMoreFor(String name) {
    return 'One more for $name';
  }

  @override
  String get matchScreenshotWrongType =>
      'Choose a screenshot saved as JPEG or PNG.';

  @override
  String get matchScreenshotTooLarge =>
      'That image is too large. Choose the screenshot itself, up to 10 MB.';

  @override
  String get matchScreenshotUploadFailed =>
      'The upload didn\'t go through. Try again.';

  @override
  String get matchScreenshotUnusable =>
      'That image couldn\'t be used. Choose the original screenshot of the Full Time screen.';

  @override
  String get matchScreenshotSlow =>
      'Checking the screenshot is taking longer than usual. Try again.';
}
