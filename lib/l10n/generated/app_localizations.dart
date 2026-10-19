import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @welcomeHeadline.
  ///
  /// In en, this message translates to:
  /// **'Your game, ranked.'**
  String get welcomeHeadline;

  /// No description provided for @welcomePitch.
  ///
  /// In en, this message translates to:
  /// **'Compete in eFootball. Climb your country\'s ladder.'**
  String get welcomePitch;

  /// No description provided for @welcomeSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign up or sign in'**
  String get welcomeSheetTitle;

  /// No description provided for @welcomeContinueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get welcomeContinueWithGoogle;

  /// No description provided for @welcomeContinueWithApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get welcomeContinueWithApple;

  /// Screen-reader label for a sign-in button while it waits.
  ///
  /// In en, this message translates to:
  /// **'{label}, working'**
  String welcomeProviderWorking(String label);

  /// Start of: By continuing you agree to the [Terms] and [Privacy Notice]. Keep the trailing space.
  ///
  /// In en, this message translates to:
  /// **'By continuing you agree to the '**
  String get welcomeAgreeBefore;

  /// Between the Terms and Privacy Notice links on the welcome screen. Keep the spaces.
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get welcomeAgreeBetween;

  /// End of the welcome screen's agreement sentence, after the Privacy Notice link.
  ///
  /// In en, this message translates to:
  /// **'.'**
  String get welcomeAgreeAfter;

  /// No description provided for @welcomeOfflineTitle.
  ///
  /// In en, this message translates to:
  /// **'Can\'t reach Ozone'**
  String get welcomeOfflineTitle;

  /// No description provided for @welcomeOfflineBody.
  ///
  /// In en, this message translates to:
  /// **'Check your connection. You\'re still signed in.'**
  String get welcomeOfflineBody;

  /// Link to the Terms, inside a sentence.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get accountLegalTerms;

  /// Link to or name of the Privacy Notice.
  ///
  /// In en, this message translates to:
  /// **'Privacy Notice'**
  String get accountLegalPrivacy;

  /// No description provided for @accountKonamiIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Konami ID'**
  String get accountKonamiIdLabel;

  /// No description provided for @accountMpesaNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'M-Pesa number'**
  String get accountMpesaNumberLabel;

  /// No description provided for @accountPhoneNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get accountPhoneNumberLabel;

  /// No description provided for @accountDisplayName.
  ///
  /// In en, this message translates to:
  /// **'Display name'**
  String get accountDisplayName;

  /// No description provided for @accountEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get accountEmailTitle;

  /// No description provided for @accountSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get accountSave;

  /// No description provided for @onboardingStepOf.
  ///
  /// In en, this message translates to:
  /// **'Step {step} of {steps}'**
  String onboardingStepOf(int step, int steps);

  /// No description provided for @onboardingUsernameTitle.
  ///
  /// In en, this message translates to:
  /// **'Pick your username'**
  String get onboardingUsernameTitle;

  /// No description provided for @onboardingUsernameSubtitle.
  ///
  /// In en, this message translates to:
  /// **'It\'s how players see you in matches and on the ladder.'**
  String get onboardingUsernameSubtitle;

  /// No description provided for @onboardingKonamiIdTitle.
  ///
  /// In en, this message translates to:
  /// **'Link eFootball'**
  String get onboardingKonamiIdTitle;

  /// No description provided for @onboardingKonamiIdSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your Konami ID connects Ozone to your eFootball account. Enter it exactly as the game shows it.'**
  String get onboardingKonamiIdSubtitle;

  /// No description provided for @onboardingCountryTitle.
  ///
  /// In en, this message translates to:
  /// **'Where do you play from?'**
  String get onboardingCountryTitle;

  /// No description provided for @onboardingCountrySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your country decides your ladder and the competitions you can enter.'**
  String get onboardingCountrySubtitle;

  /// No description provided for @onboardingPhoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Your phone number'**
  String get onboardingPhoneTitle;

  /// No description provided for @onboardingPhoneSubtitleMpesa.
  ///
  /// In en, this message translates to:
  /// **'Your M-Pesa number, for paying entry fees. Other players never see it.'**
  String get onboardingPhoneSubtitleMpesa;

  /// No description provided for @onboardingPhoneSubtitle.
  ///
  /// In en, this message translates to:
  /// **'For paying entry fees. Other players never see it.'**
  String get onboardingPhoneSubtitle;

  /// No description provided for @onboardingFinish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get onboardingFinish;

  /// No description provided for @onboardingContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onboardingContinue;

  /// Start of: By finishing you accept the [Terms] and the [Privacy Notice]. Keep the trailing space.
  ///
  /// In en, this message translates to:
  /// **'By finishing you accept the '**
  String get onboardingAcceptBefore;

  /// Between the Terms and Privacy Notice links on the last onboarding step. Keep the spaces.
  ///
  /// In en, this message translates to:
  /// **' and the '**
  String get onboardingAcceptBetween;

  /// End of the onboarding acceptance sentence, after the Privacy Notice link.
  ///
  /// In en, this message translates to:
  /// **'.'**
  String get onboardingAcceptAfter;

  /// No description provided for @onboardingUsernameLabel.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get onboardingUsernameLabel;

  /// No description provided for @onboardingUsernameAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get onboardingUsernameAvailable;

  /// No description provided for @onboardingUsernameChecking.
  ///
  /// In en, this message translates to:
  /// **'Checking…'**
  String get onboardingUsernameChecking;

  /// No description provided for @onboardingUsernameHelper.
  ///
  /// In en, this message translates to:
  /// **'Letters, numbers, _ and .'**
  String get onboardingUsernameHelper;

  /// No description provided for @profileRestricted.
  ///
  /// In en, this message translates to:
  /// **'Your account is restricted. Contact Ozone support to find out why.'**
  String get profileRestricted;

  /// No description provided for @profileAboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get profileAboutTitle;

  /// No description provided for @profileTermsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get profileTermsOfService;

  /// No description provided for @profileCouldNotOpen.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open the {document}. Try again.'**
  String profileCouldNotOpen(String document);

  /// No description provided for @profileAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get profileAccountTitle;

  /// No description provided for @profileNotLinked.
  ///
  /// In en, this message translates to:
  /// **'Not linked'**
  String get profileNotLinked;

  /// No description provided for @profileChangeCountryTitle.
  ///
  /// In en, this message translates to:
  /// **'Change your country to {country}?'**
  String profileChangeCountryTitle(String country);

  /// No description provided for @profileChangeCountryMessage.
  ///
  /// In en, this message translates to:
  /// **'Your country ranking and the competitions open to you follow your country.'**
  String get profileChangeCountryMessage;

  /// No description provided for @profileChangeCountryConfirm.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get profileChangeCountryConfirm;

  /// No description provided for @profileCountryChanged.
  ///
  /// In en, this message translates to:
  /// **'Country changed to {country}'**
  String profileCountryChanged(String country);

  /// No description provided for @profileContactTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get profileContactTitle;

  /// No description provided for @profilePhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get profilePhone;

  /// No description provided for @profileAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get profileAdd;

  /// No description provided for @profileMemberSince.
  ///
  /// In en, this message translates to:
  /// **'Member since {date}'**
  String profileMemberSince(String date);

  /// No description provided for @profileSignInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign-in'**
  String get profileSignInTitle;

  /// No description provided for @profileLinked.
  ///
  /// In en, this message translates to:
  /// **'Linked'**
  String get profileLinked;

  /// No description provided for @profileKonamiIdAndPassword.
  ///
  /// In en, this message translates to:
  /// **'Konami ID and password'**
  String get profileKonamiIdAndPassword;

  /// No description provided for @profileTestAccount.
  ///
  /// In en, this message translates to:
  /// **'Test account'**
  String get profileTestAccount;

  /// No description provided for @profileSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get profileSignOut;

  /// No description provided for @profileSignOutTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out of Ozone?'**
  String get profileSignOutTitle;

  /// No description provided for @profileSignOutMessage.
  ///
  /// In en, this message translates to:
  /// **'You can sign back in any time with the same Google or Apple account.'**
  String get profileSignOutMessage;

  /// No description provided for @accountEditNameIntro.
  ///
  /// In en, this message translates to:
  /// **'The name opponents see in matches, rankings and on your profile. Your username stays the same.'**
  String get accountEditNameIntro;

  /// No description provided for @accountEnterDisplayName.
  ///
  /// In en, this message translates to:
  /// **'Enter a display name'**
  String get accountEnterDisplayName;

  /// No description provided for @accountDisplayNameLength.
  ///
  /// In en, this message translates to:
  /// **'Use 2 to 80 characters'**
  String get accountDisplayNameLength;

  /// No description provided for @accountYourNameHint.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get accountYourNameHint;

  /// No description provided for @accountDisplayNameUpdated.
  ///
  /// In en, this message translates to:
  /// **'Display name updated'**
  String get accountDisplayNameUpdated;

  /// No description provided for @accountEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get accountEnterEmail;

  /// No description provided for @accountEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get accountEmailInvalid;

  /// No description provided for @accountNewCodeSent.
  ///
  /// In en, this message translates to:
  /// **'New code sent to {email}'**
  String accountNewCodeSent(String email);

  /// No description provided for @accountEmailVerified.
  ///
  /// In en, this message translates to:
  /// **'Email verified'**
  String get accountEmailVerified;

  /// No description provided for @accountEmailIntroAdd.
  ///
  /// In en, this message translates to:
  /// **'With a verified email you can reset a forgotten password. We\'ll send a code to confirm it.'**
  String get accountEmailIntroAdd;

  /// No description provided for @accountEmailIntroChange.
  ///
  /// In en, this message translates to:
  /// **'Your email is {email}. Enter a new address and it replaces this one once confirmed.'**
  String accountEmailIntroChange(String email);

  /// No description provided for @accountNewEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'New email'**
  String get accountNewEmailLabel;

  /// No description provided for @accountSendCode.
  ///
  /// In en, this message translates to:
  /// **'Send code'**
  String get accountSendCode;

  /// No description provided for @accountCodeExpiresSoon.
  ///
  /// In en, this message translates to:
  /// **'It expires soon.'**
  String get accountCodeExpiresSoon;

  /// No description provided for @accountCodeExpiresIn.
  ///
  /// In en, this message translates to:
  /// **'{minutes, plural, =1{It expires in 1 minute.} other{It expires in {minutes} minutes.}}'**
  String accountCodeExpiresIn(int minutes);

  /// No description provided for @accountCheckEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Check your email'**
  String get accountCheckEmailTitle;

  /// No description provided for @accountCodeSentIntro.
  ///
  /// In en, this message translates to:
  /// **'We sent a 6-digit code to {email}. {expiry}'**
  String accountCodeSentIntro(String email, String expiry);

  /// No description provided for @accountCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get accountCodeLabel;

  /// No description provided for @accountVerify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get accountVerify;

  /// No description provided for @accountSendNewCode.
  ///
  /// In en, this message translates to:
  /// **'Send a new code'**
  String get accountSendNewCode;

  /// No description provided for @accountUseAnotherEmail.
  ///
  /// In en, this message translates to:
  /// **'Use another email'**
  String get accountUseAnotherEmail;

  /// No description provided for @accountPhoneSaved.
  ///
  /// In en, this message translates to:
  /// **'Phone number saved'**
  String get accountPhoneSaved;

  /// No description provided for @accountRemovePhoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove your phone number?'**
  String get accountRemovePhoneTitle;

  /// No description provided for @accountRemovePhoneMessage.
  ///
  /// In en, this message translates to:
  /// **'You\'ll enter a number each time you pay an entry fee.'**
  String get accountRemovePhoneMessage;

  /// No description provided for @accountRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get accountRemove;

  /// No description provided for @accountPhoneRemoved.
  ///
  /// In en, this message translates to:
  /// **'Phone number removed'**
  String get accountPhoneRemoved;

  /// No description provided for @accountPhoneIntroMpesa.
  ///
  /// In en, this message translates to:
  /// **'Your M-Pesa number. Entry fees are requested from it, so you don\'t type it each time.'**
  String get accountPhoneIntroMpesa;

  /// No description provided for @accountPhoneIntro.
  ///
  /// In en, this message translates to:
  /// **'Saved for paying entry fees. Other players never see it.'**
  String get accountPhoneIntro;

  /// No description provided for @accountRemovePhone.
  ///
  /// In en, this message translates to:
  /// **'Remove phone number'**
  String get accountRemovePhone;

  /// Title of the Competitions tab.
  ///
  /// In en, this message translates to:
  /// **'Competitions'**
  String get competitionsTitle;

  /// Filter: competitions taking entries.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get competitionFilterOpen;

  /// Filter: announced competitions not yet open.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get competitionFilterUpcoming;

  /// Filter: completed competitions.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get competitionFilterFinished;

  /// No description provided for @competitionsEmptyOpen.
  ///
  /// In en, this message translates to:
  /// **'Nothing open right now'**
  String get competitionsEmptyOpen;

  /// No description provided for @competitionsEmptyUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Nothing announced yet'**
  String get competitionsEmptyUpcoming;

  /// No description provided for @competitionsEmptyFinished.
  ///
  /// In en, this message translates to:
  /// **'No finished competitions'**
  String get competitionsEmptyFinished;

  /// No description provided for @competitionsEmptyOpenMessage.
  ///
  /// In en, this message translates to:
  /// **'New competitions open for registration regularly.'**
  String get competitionsEmptyOpenMessage;

  /// No description provided for @competitionFormatSingleElimination.
  ///
  /// In en, this message translates to:
  /// **'Single elimination'**
  String get competitionFormatSingleElimination;

  /// No description provided for @competitionFormatDoubleElimination.
  ///
  /// In en, this message translates to:
  /// **'Double elimination'**
  String get competitionFormatDoubleElimination;

  /// No description provided for @competitionFormatRoundRobin.
  ///
  /// In en, this message translates to:
  /// **'Round robin'**
  String get competitionFormatRoundRobin;

  /// Shown as the format when the app doesn't know it.
  ///
  /// In en, this message translates to:
  /// **'Competition'**
  String get competitionFormatUnknown;

  /// Status badge: taking entries.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get competitionStatusOpen;

  /// No description provided for @competitionStatusUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get competitionStatusUpcoming;

  /// No description provided for @competitionStatusCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Check-in'**
  String get competitionStatusCheckIn;

  /// No description provided for @competitionStatusRunning.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get competitionStatusRunning;

  /// No description provided for @competitionStatusFinished.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get competitionStatusFinished;

  /// No description provided for @competitionStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get competitionStatusCancelled;

  /// Badge on paid competitions, which only players in Kenya can enter.
  ///
  /// In en, this message translates to:
  /// **'Kenya only'**
  String get competitionKenyaOnly;

  /// Label above the entry fee.
  ///
  /// In en, this message translates to:
  /// **'Entry'**
  String get competitionFactEntry;

  /// Entry fee value for a free competition.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get competitionFree;

  /// No description provided for @competitionFactPrize.
  ///
  /// In en, this message translates to:
  /// **'Prize'**
  String get competitionFactPrize;

  /// No description provided for @competitionFactFormat.
  ///
  /// In en, this message translates to:
  /// **'Format'**
  String get competitionFactFormat;

  /// No description provided for @competitionStarts.
  ///
  /// In en, this message translates to:
  /// **'Starts'**
  String get competitionStarts;

  /// Label above when registration closes.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get competitionRegistration;

  /// No description provided for @competitionPlayers.
  ///
  /// In en, this message translates to:
  /// **'Players'**
  String get competitionPlayers;

  /// No description provided for @competitionAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get competitionAbout;

  /// No description provided for @competitionClosesOn.
  ///
  /// In en, this message translates to:
  /// **'Closes {dateTime}'**
  String competitionClosesOn(String dateTime);

  /// No description provided for @competitionByOrganizer.
  ///
  /// In en, this message translates to:
  /// **'by {organizer}'**
  String competitionByOrganizer(String organizer);

  /// No description provided for @competitionFreeEntry.
  ///
  /// In en, this message translates to:
  /// **'Free entry'**
  String get competitionFreeEntry;

  /// No description provided for @competitionPaidEntry.
  ///
  /// In en, this message translates to:
  /// **'{fee} entry'**
  String competitionPaidEntry(String fee);

  /// No description provided for @competitionFormatStarts.
  ///
  /// In en, this message translates to:
  /// **'{format} · Starts {dateTime}'**
  String competitionFormatStarts(String format, String dateTime);

  /// No description provided for @competitionPrize.
  ///
  /// In en, this message translates to:
  /// **'Prize {amount}'**
  String competitionPrize(String amount);

  /// Badge: places left in a competition.
  ///
  /// In en, this message translates to:
  /// **'{count} left'**
  String competitionPlacesLeft(int count);

  /// No description provided for @competitionCapacity.
  ///
  /// In en, this message translates to:
  /// **'{entries} of {max} players'**
  String competitionCapacity(int entries, int max);

  /// No description provided for @competitionWithdrawTitle.
  ///
  /// In en, this message translates to:
  /// **'Withdraw from this competition?'**
  String get competitionWithdrawTitle;

  /// No description provided for @competitionWithdrawMessage.
  ///
  /// In en, this message translates to:
  /// **'Your place goes back to the pool. You can enter again while registration is open.'**
  String get competitionWithdrawMessage;

  /// No description provided for @competitionWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get competitionWithdraw;

  /// Cancel button of the withdraw dialog.
  ///
  /// In en, this message translates to:
  /// **'Stay in'**
  String get competitionStayIn;

  /// No description provided for @competitionEligibilityFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t check whether you can enter.'**
  String get competitionEligibilityFailed;

  /// No description provided for @competitionCheckPayment.
  ///
  /// In en, this message translates to:
  /// **'Check your payment'**
  String get competitionCheckPayment;

  /// No description provided for @competitionEnterFree.
  ///
  /// In en, this message translates to:
  /// **'Enter for free'**
  String get competitionEnterFree;

  /// No description provided for @competitionPayWithMpesa.
  ///
  /// In en, this message translates to:
  /// **'Pay {fee} with M-Pesa'**
  String competitionPayWithMpesa(String fee);

  /// No description provided for @competitionRefundInProgress.
  ///
  /// In en, this message translates to:
  /// **'Your entry fee is being refunded.'**
  String get competitionRefundInProgress;

  /// No description provided for @competitionCannotEnter.
  ///
  /// In en, this message translates to:
  /// **'You can\'t enter this competition.'**
  String get competitionCannotEnter;

  /// No description provided for @competitionYoureIn.
  ///
  /// In en, this message translates to:
  /// **'You\'re in'**
  String get competitionYoureIn;

  /// No description provided for @paymentTitle.
  ///
  /// In en, this message translates to:
  /// **'Pay with M-Pesa'**
  String get paymentTitle;

  /// No description provided for @paymentNotConfirmed.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t confirm the request with M-Pesa. Try again; you won\'t be charged twice.'**
  String get paymentNotConfirmed;

  /// No description provided for @paymentUnderReview.
  ///
  /// In en, this message translates to:
  /// **'Payment under review'**
  String get paymentUnderReview;

  /// No description provided for @paymentUnderReviewMessage.
  ///
  /// In en, this message translates to:
  /// **'We\'re checking this payment with M-Pesa. You won\'t be charged twice, and you\'ll be notified when it\'s settled.'**
  String get paymentUnderReviewMessage;

  /// No description provided for @paymentCheckAgain.
  ///
  /// In en, this message translates to:
  /// **'Check again'**
  String get paymentCheckAgain;

  /// No description provided for @paymentYoureIn.
  ///
  /// In en, this message translates to:
  /// **'You\'re in'**
  String get paymentYoureIn;

  /// No description provided for @paymentConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Paid {amount}. Your place is confirmed.'**
  String paymentConfirmed(String amount);

  /// No description provided for @paymentNoPlaceLeft.
  ///
  /// In en, this message translates to:
  /// **'Paid, but no place left'**
  String get paymentNoPlaceLeft;

  /// No description provided for @paymentNoPlaceLeftMessage.
  ///
  /// In en, this message translates to:
  /// **'The places filled or registration closed before your payment arrived. A full refund of {amount} is on its way.'**
  String paymentNoPlaceLeftMessage(String amount);

  /// No description provided for @paymentRefunded.
  ///
  /// In en, this message translates to:
  /// **'Refunded'**
  String get paymentRefunded;

  /// No description provided for @paymentRefundedMessage.
  ///
  /// In en, this message translates to:
  /// **'{amount} has been returned to your M-Pesa.'**
  String paymentRefundedMessage(String amount);

  /// No description provided for @paymentEntryRemoved.
  ///
  /// In en, this message translates to:
  /// **'Entry removed'**
  String get paymentEntryRemoved;

  /// No description provided for @paymentEntryRemovedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your entry was removed from this competition.'**
  String get paymentEntryRemovedMessage;

  /// No description provided for @paymentFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment didn\'t go through'**
  String get paymentFailed;

  /// No description provided for @paymentFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'M-Pesa didn\'t confirm the payment.'**
  String get paymentFailedMessage;

  /// No description provided for @paymentDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get paymentDone;

  /// No description provided for @paymentNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get paymentNotNow;

  /// No description provided for @paymentCheckYourPhone.
  ///
  /// In en, this message translates to:
  /// **'Check your phone'**
  String get paymentCheckYourPhone;

  /// Used in paymentEnterPin when the number isn't known.
  ///
  /// In en, this message translates to:
  /// **'your phone'**
  String get paymentYourPhone;

  /// No description provided for @paymentEnterPin.
  ///
  /// In en, this message translates to:
  /// **'Enter your M-Pesa PIN on {phone} to pay {amount}.'**
  String paymentEnterPin(String phone, String amount);

  /// No description provided for @paymentWaiting.
  ///
  /// In en, this message translates to:
  /// **'Waiting for M-Pesa…'**
  String get paymentWaiting;

  /// No description provided for @paymentSlow.
  ///
  /// In en, this message translates to:
  /// **'Still waiting? M-Pesa can take a minute. You won\'t be charged twice.'**
  String get paymentSlow;

  /// No description provided for @paymentEntryFee.
  ///
  /// In en, this message translates to:
  /// **'Entry fee'**
  String get paymentEntryFee;

  /// No description provided for @paymentMpesaNumber.
  ///
  /// In en, this message translates to:
  /// **'M-Pesa number'**
  String get paymentMpesaNumber;

  /// No description provided for @paymentPhoneHelper.
  ///
  /// In en, this message translates to:
  /// **'A Safaricom number. You\'ll confirm with your PIN.'**
  String get paymentPhoneHelper;

  /// No description provided for @paymentSendRequest.
  ///
  /// In en, this message translates to:
  /// **'Send payment request'**
  String get paymentSendRequest;

  /// The app's name; do not translate.
  ///
  /// In en, this message translates to:
  /// **'Ozone'**
  String get appName;

  /// No description provided for @tabHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get tabHome;

  /// No description provided for @tabCompete.
  ///
  /// In en, this message translates to:
  /// **'Compete'**
  String get tabCompete;

  /// No description provided for @tabMatches.
  ///
  /// In en, this message translates to:
  /// **'Matches'**
  String get tabMatches;

  /// No description provided for @tabRankings.
  ///
  /// In en, this message translates to:
  /// **'Rankings'**
  String get tabRankings;

  /// No description provided for @tabProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get tabProfile;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @couldNotLoad.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load this'**
  String get couldNotLoad;

  /// No description provided for @couldNotLoadMore.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load more. Try again'**
  String get couldNotLoadMore;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'{what} copied'**
  String copied(String what);

  /// No description provided for @countryLabel.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get countryLabel;

  /// No description provided for @chooseYourCountry.
  ///
  /// In en, this message translates to:
  /// **'Choose your country'**
  String get chooseYourCountry;

  /// No description provided for @countrySuggested.
  ///
  /// In en, this message translates to:
  /// **'Suggested'**
  String get countrySuggested;

  /// No description provided for @countryAll.
  ///
  /// In en, this message translates to:
  /// **'All countries'**
  String get countryAll;

  /// No description provided for @countrySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search country or code'**
  String get countrySearchHint;

  /// No description provided for @countryNoMatch.
  ///
  /// In en, this message translates to:
  /// **'No country matches that search'**
  String get countryNoMatch;

  /// No description provided for @callingCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Calling code +{dialCode}, {country}. Change'**
  String callingCodeLabel(String dialCode, String country);

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Can\'t reach Ozone. Check your connection and try again.'**
  String get errorNetwork;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Try again.'**
  String get errorGeneric;

  /// No description provided for @errorServer.
  ///
  /// In en, this message translates to:
  /// **'Ozone is having trouble right now. Try again shortly.'**
  String get errorServer;

  /// No description provided for @errorUsernameTaken.
  ///
  /// In en, this message translates to:
  /// **'That username is taken. Try another.'**
  String get errorUsernameTaken;

  /// No description provided for @errorKonamiIdTaken.
  ///
  /// In en, this message translates to:
  /// **'That Konami ID is linked to another Ozone account. Contact Ozone support if it\'s yours.'**
  String get errorKonamiIdTaken;

  /// No description provided for @errorAccountUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This account is suspended. Contact Ozone support.'**
  String get errorAccountUnavailable;

  /// No description provided for @errorInvalidCode.
  ///
  /// In en, this message translates to:
  /// **'That code is wrong or has expired.'**
  String get errorInvalidCode;

  /// No description provided for @errorSignInUnavailable.
  ///
  /// In en, this message translates to:
  /// **'That sign-in option isn\'t available yet. Try again later.'**
  String get errorSignInUnavailable;

  /// No description provided for @errorInvalidIdentityToken.
  ///
  /// In en, this message translates to:
  /// **'Sign-in didn\'t go through. Try again.'**
  String get errorInvalidIdentityToken;

  /// No description provided for @errorIdentityProviderUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Can\'t reach the sign-in service right now. Try again shortly.'**
  String get errorIdentityProviderUnavailable;

  /// No description provided for @errorInvalidKonamiId.
  ///
  /// In en, this message translates to:
  /// **'Enter the Konami ID exactly as eFootball shows it.'**
  String get errorInvalidKonamiId;

  /// No description provided for @errorInvalidUsername.
  ///
  /// In en, this message translates to:
  /// **'Use 3 to 24 letters, numbers, underscores or dots.'**
  String get errorInvalidUsername;

  /// No description provided for @errorInvalidCountry.
  ///
  /// In en, this message translates to:
  /// **'Choose your country.'**
  String get errorInvalidCountry;

  /// No description provided for @errorProfileIncomplete.
  ///
  /// In en, this message translates to:
  /// **'Finish setting up your account first.'**
  String get errorProfileIncomplete;

  /// No description provided for @errorEmailTaken.
  ///
  /// In en, this message translates to:
  /// **'That email belongs to another account.'**
  String get errorEmailTaken;

  /// No description provided for @errorEmailAlreadyVerified.
  ///
  /// In en, this message translates to:
  /// **'That email is already verified on your account.'**
  String get errorEmailAlreadyVerified;

  /// No description provided for @errorEmailUnavailable.
  ///
  /// In en, this message translates to:
  /// **'We can\'t send email right now. Try again shortly.'**
  String get errorEmailUnavailable;

  /// No description provided for @errorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'That doesn\'t look like an email address.'**
  String get errorInvalidEmail;

  /// No description provided for @errorPhoneTaken.
  ///
  /// In en, this message translates to:
  /// **'That number is linked to another Ozone account. Contact Ozone support if it\'s yours.'**
  String get errorPhoneTaken;

  /// No description provided for @errorInvalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter the full number with its country code.'**
  String get errorInvalidPhone;

  /// No description provided for @errorInvalidDisplayName.
  ///
  /// In en, this message translates to:
  /// **'Use 2 to 80 characters.'**
  String get errorInvalidDisplayName;

  /// No description provided for @errorRateLimited.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Wait a moment and try again.'**
  String get errorRateLimited;

  /// No description provided for @errorRateLimitedSeconds.
  ///
  /// In en, this message translates to:
  /// **'{seconds, plural, =1{Too many attempts. Try again in 1 second.} other{Too many attempts. Try again in {seconds} seconds.}}'**
  String errorRateLimitedSeconds(int seconds);

  /// No description provided for @errorRateLimitedMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes, plural, =1{Too many attempts. Try again in 1 minute.} other{Too many attempts. Try again in {minutes} minutes.}}'**
  String errorRateLimitedMinutes(int minutes);

  /// No description provided for @formatToday.
  ///
  /// In en, this message translates to:
  /// **'Today, {time}'**
  String formatToday(String time);

  /// No description provided for @formatTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow, {time}'**
  String formatTomorrow(String time);

  /// No description provided for @formatYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday, {time}'**
  String formatYesterday(String time);

  /// No description provided for @formatDateTime.
  ///
  /// In en, this message translates to:
  /// **'{date}, {time}'**
  String formatDateTime(String date, String time);

  /// No description provided for @closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// No description provided for @closesInMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes, plural, =1{Closes in 1 min} other{Closes in {minutes} min}}'**
  String closesInMinutes(int minutes);

  /// No description provided for @closesInHours.
  ///
  /// In en, this message translates to:
  /// **'{hours, plural, =1{Closes in 1 hour} other{Closes in {hours} hours}}'**
  String closesInHours(int hours);

  /// No description provided for @closesInDays.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =1{Closes in 1 day} other{Closes in {days} days}}'**
  String closesInDays(int days);

  /// No description provided for @timeLeftShort.
  ///
  /// In en, this message translates to:
  /// **'{minutes}:{seconds} left'**
  String timeLeftShort(int minutes, String seconds);

  /// No description provided for @timeLeftHours.
  ///
  /// In en, this message translates to:
  /// **'{hours} h left'**
  String timeLeftHours(int hours);

  /// No description provided for @timeLeftHoursMinutes.
  ///
  /// In en, this message translates to:
  /// **'{hours} h {minutes} min left'**
  String timeLeftHoursMinutes(int hours, int minutes);

  /// No description provided for @validateChooseUsername.
  ///
  /// In en, this message translates to:
  /// **'Choose a username'**
  String get validateChooseUsername;

  /// No description provided for @validateUsernameLength.
  ///
  /// In en, this message translates to:
  /// **'Use 3 to 24 characters'**
  String get validateUsernameLength;

  /// No description provided for @validateUsernameCharacters.
  ///
  /// In en, this message translates to:
  /// **'Use letters, numbers, underscores or dots, starting with a letter or number'**
  String get validateUsernameCharacters;

  /// No description provided for @validateEnterKonamiId.
  ///
  /// In en, this message translates to:
  /// **'Enter your Konami ID'**
  String get validateEnterKonamiId;

  /// No description provided for @validateKonamiIdFormat.
  ///
  /// In en, this message translates to:
  /// **'Enter the Konami ID exactly as eFootball shows it'**
  String get validateKonamiIdFormat;

  /// No description provided for @validateCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code'**
  String get validateCode;

  /// No description provided for @validateEnterPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get validateEnterPhone;

  /// No description provided for @validateEnterMpesaNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your M-Pesa number'**
  String get validateEnterMpesaNumber;

  /// No description provided for @validateKenyanMobile.
  ///
  /// In en, this message translates to:
  /// **'Enter a Kenyan mobile number, like 0712 345 678'**
  String get validateKenyanMobile;

  /// No description provided for @validatePhoneInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number'**
  String get validatePhoneInvalid;

  /// No description provided for @homeGoodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get homeGoodMorning;

  /// No description provided for @homeGoodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get homeGoodAfternoon;

  /// No description provided for @homeGoodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get homeGoodEvening;

  /// Action on a Home section header that opens the full list.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get homeSeeAll;

  /// No description provided for @homeClosingSoon.
  ///
  /// In en, this message translates to:
  /// **'Closing soon'**
  String get homeClosingSoon;

  /// No description provided for @homeNothingOpenTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing open right now'**
  String get homeNothingOpenTitle;

  /// No description provided for @homeNothingOpenMessage.
  ///
  /// In en, this message translates to:
  /// **'New competitions open for registration regularly.'**
  String get homeNothingOpenMessage;

  /// No description provided for @homeRating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get homeRating;

  /// Screen reader label for the player's rating.
  ///
  /// In en, this message translates to:
  /// **'Rating {rating}'**
  String homeRatingSemantics(int rating);

  /// No description provided for @homeUnranked.
  ///
  /// In en, this message translates to:
  /// **'Unranked'**
  String get homeUnranked;

  /// No description provided for @homeUnratedMessage.
  ///
  /// In en, this message translates to:
  /// **'Play your first rated match to get a rating and a place on the ladder.'**
  String get homeUnratedMessage;

  /// No description provided for @homeFindCompetition.
  ///
  /// In en, this message translates to:
  /// **'Find a competition'**
  String get homeFindCompetition;

  /// Screen reader label for rank movement.
  ///
  /// In en, this message translates to:
  /// **'{places, plural, =1{Up 1 place} other{Up {places} places}}'**
  String homeMovedUp(int places);

  /// No description provided for @homeMovedDown.
  ///
  /// In en, this message translates to:
  /// **'{places, plural, =1{Down 1 place} other{Down {places} places}}'**
  String homeMovedDown(int places);

  /// Rank movement next to an up or down arrow.
  ///
  /// In en, this message translates to:
  /// **'{places, plural, =1{1 place} other{{places} places}}'**
  String homePlaces(int places);

  /// No description provided for @homeCountryLadder.
  ///
  /// In en, this message translates to:
  /// **'{country} ladder'**
  String homeCountryLadder(String country);

  /// No description provided for @homeTopInCountry.
  ///
  /// In en, this message translates to:
  /// **'Top in {country}'**
  String homeTopInCountry(String country);

  /// No description provided for @homeRecentMatches.
  ///
  /// In en, this message translates to:
  /// **'Recent matches'**
  String get homeRecentMatches;

  /// No description provided for @homeWinRate.
  ///
  /// In en, this message translates to:
  /// **'Win rate'**
  String get homeWinRate;

  /// No description provided for @homeMatches.
  ///
  /// In en, this message translates to:
  /// **'Matches'**
  String get homeMatches;

  /// No description provided for @homeUpNext.
  ///
  /// In en, this message translates to:
  /// **'Up next'**
  String get homeUpNext;

  /// No description provided for @homeOpponentToBeDecided.
  ///
  /// In en, this message translates to:
  /// **'Opponent to be decided'**
  String get homeOpponentToBeDecided;

  /// Check-in deadline next to the match status.
  ///
  /// In en, this message translates to:
  /// **'by {time}'**
  String homeCheckInBy(String time);

  /// No description provided for @playerVersus.
  ///
  /// In en, this message translates to:
  /// **'vs {opponent}'**
  String playerVersus(String opponent);

  /// Stands in for an opponent whose profile is no longer public, as in 'vs a former player'.
  ///
  /// In en, this message translates to:
  /// **'a former player'**
  String get playerFormerPlayer;

  /// No description provided for @playerWins.
  ///
  /// In en, this message translates to:
  /// **'Wins'**
  String get playerWins;

  /// No description provided for @playerDraws.
  ///
  /// In en, this message translates to:
  /// **'Draws'**
  String get playerDraws;

  /// No description provided for @playerLosses.
  ///
  /// In en, this message translates to:
  /// **'Losses'**
  String get playerLosses;

  /// No description provided for @playerRecordSemantics.
  ///
  /// In en, this message translates to:
  /// **'{wins} wins, {draws} draws, {losses} losses'**
  String playerRecordSemantics(int wins, int draws, int losses);

  /// No description provided for @playerResultWin.
  ///
  /// In en, this message translates to:
  /// **'Win'**
  String get playerResultWin;

  /// No description provided for @playerResultDraw.
  ///
  /// In en, this message translates to:
  /// **'Draw'**
  String get playerResultDraw;

  /// No description provided for @playerResultLoss.
  ///
  /// In en, this message translates to:
  /// **'Loss'**
  String get playerResultLoss;

  /// One-letter abbreviation of a win.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get playerResultWinLetter;

  /// One-letter abbreviation of a draw.
  ///
  /// In en, this message translates to:
  /// **'D'**
  String get playerResultDrawLetter;

  /// One-letter abbreviation of a loss.
  ///
  /// In en, this message translates to:
  /// **'L'**
  String get playerResultLossLetter;

  /// No description provided for @rankingsGlobal.
  ///
  /// In en, this message translates to:
  /// **'Global'**
  String get rankingsGlobal;

  /// No description provided for @rankingsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No rankings yet'**
  String get rankingsEmptyTitle;

  /// No description provided for @rankingsEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Players are ranked once they finish rated matches.'**
  String get rankingsEmptyMessage;

  /// The signed-in player's own name on a ladder.
  ///
  /// In en, this message translates to:
  /// **'{name} (you)'**
  String rankingsYou(String name);

  /// No description provided for @rankingsMovedUp.
  ///
  /// In en, this message translates to:
  /// **'Up {places}'**
  String rankingsMovedUp(int places);

  /// No description provided for @rankingsMovedDown.
  ///
  /// In en, this message translates to:
  /// **'Down {places}'**
  String rankingsMovedDown(int places);

  /// After a rank number, as in '#24 in Kenya'.
  ///
  /// In en, this message translates to:
  /// **'in {place}'**
  String homeRankIn(String place);

  /// After a rank number, as in '#310 global'.
  ///
  /// In en, this message translates to:
  /// **'global'**
  String get homeRankGlobal;

  /// No description provided for @homeGoalsPerMatchShort.
  ///
  /// In en, this message translates to:
  /// **'Goals per match'**
  String get homeGoalsPerMatchShort;

  /// No description provided for @homeStreak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get homeStreak;

  /// Wins, draws and losses under the record bar.
  ///
  /// In en, this message translates to:
  /// **'{wins} W  ·  {draws} D  ·  {losses} L'**
  String homeRecordLine(int wins, int draws, int losses);

  /// The signed-in player's own side in a match.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get matchYou;

  /// No description provided for @matchOpponent.
  ///
  /// In en, this message translates to:
  /// **'Opponent'**
  String get matchOpponent;

  /// Stands in for the opponent's name mid-sentence when it isn't known yet.
  ///
  /// In en, this message translates to:
  /// **'your opponent'**
  String get matchYourOpponent;

  /// Stands in for the opponent's name at the start of a sentence.
  ///
  /// In en, this message translates to:
  /// **'Your opponent'**
  String get matchYourOpponentStart;

  /// Stands in for a reported score mid-sentence when it isn't known.
  ///
  /// In en, this message translates to:
  /// **'the score'**
  String get matchTheScore;

  /// A score with a penalty shootout, from the player's side.
  ///
  /// In en, this message translates to:
  /// **'{mine}–{theirs} ({penMine}–{penTheirs} pens)'**
  String matchScoreWithPens(int mine, int theirs, int penMine, int penTheirs);

  /// No description provided for @matchScheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get matchScheduled;

  /// No description provided for @matchCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Check in'**
  String get matchCheckIn;

  /// No description provided for @matchCheckedIn.
  ///
  /// In en, this message translates to:
  /// **'Checked in'**
  String get matchCheckedIn;

  /// No description provided for @matchUnderReview.
  ///
  /// In en, this message translates to:
  /// **'Under review'**
  String get matchUnderReview;

  /// No description provided for @matchNoResult.
  ///
  /// In en, this message translates to:
  /// **'No result'**
  String get matchNoResult;

  /// No description provided for @matchFinished.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get matchFinished;

  /// No description provided for @matchFullTime.
  ///
  /// In en, this message translates to:
  /// **'Full time'**
  String get matchFullTime;

  /// No description provided for @matchReportScore.
  ///
  /// In en, this message translates to:
  /// **'Report the score'**
  String get matchReportScore;

  /// No description provided for @matchStepOpponentFromEarlierRound.
  ///
  /// In en, this message translates to:
  /// **'Your opponent comes from an earlier round.'**
  String get matchStepOpponentFromEarlierRound;

  /// No description provided for @matchStepCheckInOpens.
  ///
  /// In en, this message translates to:
  /// **'Check-in opens {when}.'**
  String matchStepCheckInOpens(String when);

  /// No description provided for @matchStepKickOff.
  ///
  /// In en, this message translates to:
  /// **'Kick-off {when}.'**
  String matchStepKickOff(String when);

  /// No description provided for @matchStepWeWillLetYouKnow.
  ///
  /// In en, this message translates to:
  /// **'We\'ll let you know when it\'s time to play.'**
  String get matchStepWeWillLetYouKnow;

  /// No description provided for @matchStepCheckInTitle.
  ///
  /// In en, this message translates to:
  /// **'Time to check in'**
  String get matchStepCheckInTitle;

  /// No description provided for @matchStepCheckInMessage.
  ///
  /// In en, this message translates to:
  /// **'Check in to say you\'re ready. If only one player checks in, that player wins.'**
  String get matchStepCheckInMessage;

  /// No description provided for @matchStepCheckedInTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re checked in'**
  String get matchStepCheckedInTitle;

  /// No description provided for @matchStepCheckedInMessage.
  ///
  /// In en, this message translates to:
  /// **'Waiting for {opponent} to check in.'**
  String matchStepCheckedInMessage(String opponent);

  /// No description provided for @matchStepPlayTitle.
  ///
  /// In en, this message translates to:
  /// **'Play your match'**
  String get matchStepPlayTitle;

  /// No description provided for @matchStepPlayMessage.
  ///
  /// In en, this message translates to:
  /// **'Play a Friend Match with {opponent} in eFootball. When it ends, either of you reports the score.'**
  String matchStepPlayMessage(String opponent);

  /// No description provided for @matchStepPlayDeadlineNote.
  ///
  /// In en, this message translates to:
  /// **'If nobody reports in time, you are both removed.'**
  String get matchStepPlayDeadlineNote;

  /// No description provided for @matchStepAwaitingConfirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Waiting for {opponent} to confirm'**
  String matchStepAwaitingConfirmationTitle(String opponent);

  /// No description provided for @matchStepAwaitingConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'You reported {score}. If {opponent} doesn\'t answer in time, your result stands.'**
  String matchStepAwaitingConfirmationMessage(String score, String opponent);

  /// No description provided for @matchStepConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm the result'**
  String get matchStepConfirmTitle;

  /// No description provided for @matchStepConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'{opponent} reported the score above. Is it right? If you don\'t answer in time, it stands.'**
  String matchStepConfirmMessage(String opponent);

  /// No description provided for @matchStepScreenshotTitle.
  ///
  /// In en, this message translates to:
  /// **'Send your screenshot'**
  String get matchStepScreenshotTitle;

  /// No description provided for @matchStepScreenshotMessage.
  ///
  /// In en, this message translates to:
  /// **'The result was rejected. Send one screenshot of the Full Time screen; Ozone compares both players\' screenshots.'**
  String get matchStepScreenshotMessage;

  /// No description provided for @matchStepScreenshotDeadlineNote.
  ///
  /// In en, this message translates to:
  /// **'If you don\'t send one in time, you\'re removed from the competition.'**
  String get matchStepScreenshotDeadlineNote;

  /// No description provided for @matchStepScreenshotSentTitle.
  ///
  /// In en, this message translates to:
  /// **'Screenshot sent'**
  String get matchStepScreenshotSentTitle;

  /// No description provided for @matchStepBothScreenshotsIn.
  ///
  /// In en, this message translates to:
  /// **'Both screenshots are in. Ozone will review them.'**
  String get matchStepBothScreenshotsIn;

  /// No description provided for @matchStepWaitingForScreenshot.
  ///
  /// In en, this message translates to:
  /// **'Waiting for {opponent}\'s screenshot. Ozone then checks both.'**
  String matchStepWaitingForScreenshot(String opponent);

  /// No description provided for @matchStepSettlingTitle.
  ///
  /// In en, this message translates to:
  /// **'Settling the result'**
  String get matchStepSettlingTitle;

  /// No description provided for @matchStepSettlingMessage.
  ///
  /// In en, this message translates to:
  /// **'A deadline just passed. This takes a few seconds.'**
  String get matchStepSettlingMessage;

  /// No description provided for @matchStepUnderReviewMessage.
  ///
  /// In en, this message translates to:
  /// **'Ozone is checking both screenshots against the reported score. You\'ll be notified of the decision.'**
  String get matchStepUnderReviewMessage;

  /// No description provided for @matchStepOpponentConfirmedYours.
  ///
  /// In en, this message translates to:
  /// **'{opponent} confirmed your result.'**
  String matchStepOpponentConfirmedYours(String opponent);

  /// No description provided for @matchStepYouConfirmed.
  ///
  /// In en, this message translates to:
  /// **'You confirmed the result.'**
  String get matchStepYouConfirmed;

  /// No description provided for @matchStepBothAgreed.
  ///
  /// In en, this message translates to:
  /// **'Both players agreed on the result.'**
  String get matchStepBothAgreed;

  /// No description provided for @matchStepOpponentUnanswered.
  ///
  /// In en, this message translates to:
  /// **'{opponent} didn\'t answer in time, so your result stood.'**
  String matchStepOpponentUnanswered(String opponent);

  /// No description provided for @matchStepUnanswered.
  ///
  /// In en, this message translates to:
  /// **'The result wasn\'t answered in time, so it stood.'**
  String get matchStepUnanswered;

  /// No description provided for @matchStepDecidedByReview.
  ///
  /// In en, this message translates to:
  /// **'Ozone decided the result after a review.'**
  String get matchStepDecidedByReview;

  /// No description provided for @matchStepResultConfirmed.
  ///
  /// In en, this message translates to:
  /// **'The result is confirmed.'**
  String get matchStepResultConfirmed;

  /// No description provided for @matchStepOutTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re out of this competition'**
  String get matchStepOutTitle;

  /// No description provided for @matchStepOutMessage.
  ///
  /// In en, this message translates to:
  /// **'This match will be settled without you.'**
  String get matchStepOutMessage;

  /// No description provided for @matchStepUnknownTitle.
  ///
  /// In en, this message translates to:
  /// **'Match'**
  String get matchStepUnknownTitle;

  /// No description provided for @matchStepUnknownMessage.
  ///
  /// In en, this message translates to:
  /// **'Update Ozone to see where this match stands.'**
  String get matchStepUnknownMessage;

  /// No description provided for @matchCancelledNoResultReported.
  ///
  /// In en, this message translates to:
  /// **'Nobody reported a score in time, so both players were removed.'**
  String get matchCancelledNoResultReported;

  /// No description provided for @matchCancelledResponseTimeout.
  ///
  /// In en, this message translates to:
  /// **'Neither player sent a screenshot, so both were removed.'**
  String get matchCancelledResponseTimeout;

  /// No description provided for @matchCancelledDoubleNoShow.
  ///
  /// In en, this message translates to:
  /// **'Neither player checked in.'**
  String get matchCancelledDoubleNoShow;

  /// No description provided for @matchCancelledCompetitionCancelled.
  ///
  /// In en, this message translates to:
  /// **'The competition was cancelled.'**
  String get matchCancelledCompetitionCancelled;

  /// No description provided for @matchCancelledPlatformReview.
  ///
  /// In en, this message translates to:
  /// **'Ozone cancelled the match after a review.'**
  String get matchCancelledPlatformReview;

  /// No description provided for @matchCancelledNotNeeded.
  ///
  /// In en, this message translates to:
  /// **'The bracket no longer needed this match.'**
  String get matchCancelledNotNeeded;

  /// No description provided for @matchCancelledOther.
  ///
  /// In en, this message translates to:
  /// **'This match was cancelled.'**
  String get matchCancelledOther;

  /// No description provided for @matchOutcomeYouWon.
  ///
  /// In en, this message translates to:
  /// **'You won'**
  String get matchOutcomeYouWon;

  /// No description provided for @matchOutcomeYouLost.
  ///
  /// In en, this message translates to:
  /// **'You lost'**
  String get matchOutcomeYouLost;

  /// No description provided for @matchOutcomeDraw.
  ///
  /// In en, this message translates to:
  /// **'Draw'**
  String get matchOutcomeDraw;

  /// No description provided for @matchForfeitOpponentNoCheckIn.
  ///
  /// In en, this message translates to:
  /// **'{opponent} didn\'t check in.'**
  String matchForfeitOpponentNoCheckIn(String opponent);

  /// No description provided for @matchForfeitYouNoCheckIn.
  ///
  /// In en, this message translates to:
  /// **'You didn\'t check in in time.'**
  String get matchForfeitYouNoCheckIn;

  /// No description provided for @matchForfeitOpponentLeft.
  ///
  /// In en, this message translates to:
  /// **'{opponent} had already left the competition.'**
  String matchForfeitOpponentLeft(String opponent);

  /// No description provided for @matchForfeitYouLeft.
  ///
  /// In en, this message translates to:
  /// **'Your entry had already left the competition.'**
  String get matchForfeitYouLeft;

  /// No description provided for @matchForfeitOpponentNoScreenshot.
  ///
  /// In en, this message translates to:
  /// **'{opponent} didn\'t send a screenshot after the result was rejected.'**
  String matchForfeitOpponentNoScreenshot(String opponent);

  /// No description provided for @matchForfeitYouNoScreenshot.
  ///
  /// In en, this message translates to:
  /// **'You didn\'t send a screenshot in time, so you were removed.'**
  String get matchForfeitYouNoScreenshot;

  /// No description provided for @matchForfeitPlatformReview.
  ///
  /// In en, this message translates to:
  /// **'Ozone decided the match after a review.'**
  String get matchForfeitPlatformReview;

  /// No description provided for @matchForfeitWonWithoutPlaying.
  ///
  /// In en, this message translates to:
  /// **'You won without playing.'**
  String get matchForfeitWonWithoutPlaying;

  /// No description provided for @matchForfeitDecidedWithoutYou.
  ///
  /// In en, this message translates to:
  /// **'The match was decided without you.'**
  String get matchForfeitDecidedWithoutYou;

  /// No description provided for @matchErrorOpponentAlreadyReported.
  ///
  /// In en, this message translates to:
  /// **'Your opponent already reported the result. Confirm or reject it instead.'**
  String get matchErrorOpponentAlreadyReported;

  /// No description provided for @matchErrorAlreadySubmitted.
  ///
  /// In en, this message translates to:
  /// **'Your side already reported the result.'**
  String get matchErrorAlreadySubmitted;

  /// No description provided for @matchErrorWindowClosed.
  ///
  /// In en, this message translates to:
  /// **'The time for that has passed.'**
  String get matchErrorWindowClosed;

  /// No description provided for @matchErrorInvalidScore.
  ///
  /// In en, this message translates to:
  /// **'That score doesn\'t fit this match\'s format.'**
  String get matchErrorInvalidScore;

  /// No description provided for @matchErrorMatchChanged.
  ///
  /// In en, this message translates to:
  /// **'The match changed. Check the latest and try again.'**
  String get matchErrorMatchChanged;

  /// No description provided for @matchErrorCompetitionClosed.
  ///
  /// In en, this message translates to:
  /// **'This competition has ended.'**
  String get matchErrorCompetitionClosed;

  /// No description provided for @matchErrorEvidenceRateLimited.
  ///
  /// In en, this message translates to:
  /// **'Too many uploads. Wait a moment and try again.'**
  String get matchErrorEvidenceRateLimited;

  /// No description provided for @matchRemovedNotice.
  ///
  /// In en, this message translates to:
  /// **'This match removed you from the competition.'**
  String get matchRemovedNotice;

  /// No description provided for @matchInfoLabel.
  ///
  /// In en, this message translates to:
  /// **'Match info'**
  String get matchInfoLabel;

  /// No description provided for @matchPenaltyNeedsWinner.
  ///
  /// In en, this message translates to:
  /// **'A penalty shootout needs a winner.'**
  String get matchPenaltyNeedsWinner;

  /// No description provided for @matchScoreSent.
  ///
  /// In en, this message translates to:
  /// **'{minutes, plural, =1{Score sent. {opponent} has 1 minute to confirm it.} other{Score sent. {opponent} has {minutes} minutes to confirm it.}}'**
  String matchScoreSent(String opponent, int minutes);

  /// No description provided for @matchReportIntro.
  ///
  /// In en, this message translates to:
  /// **'{minutes, plural, =1{Enter the final score from the Full Time screen. {opponent} confirms it, and if they don\'t answer within 1 minute, it stands.} other{Enter the final score from the Full Time screen. {opponent} confirms it, and if they don\'t answer within {minutes} minutes, it stands.}}'**
  String matchReportIntro(String opponent, int minutes);

  /// No description provided for @matchPenaltyShootout.
  ///
  /// In en, this message translates to:
  /// **'Penalty shootout'**
  String get matchPenaltyShootout;

  /// No description provided for @matchLevelKnockoutNote.
  ///
  /// In en, this message translates to:
  /// **'A level knockout match is decided on penalties.'**
  String get matchLevelKnockoutNote;

  /// No description provided for @matchSendScore.
  ///
  /// In en, this message translates to:
  /// **'Send score'**
  String get matchSendScore;

  /// No description provided for @matchDeclaration.
  ///
  /// In en, this message translates to:
  /// **'This is the real score. Reporting a false score can get me removed from the competition.'**
  String get matchDeclaration;

  /// No description provided for @matchListActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get matchListActive;

  /// No description provided for @matchListHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get matchListHistory;

  /// No description provided for @matchNoActiveTitle.
  ///
  /// In en, this message translates to:
  /// **'No active matches'**
  String get matchNoActiveTitle;

  /// No description provided for @matchNoHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'No matches played yet'**
  String get matchNoHistoryTitle;

  /// No description provided for @matchNoActiveMessage.
  ///
  /// In en, this message translates to:
  /// **'Matches appear here once a competition you entered starts.'**
  String get matchNoActiveMessage;

  /// No description provided for @matchNoHistoryMessage.
  ///
  /// In en, this message translates to:
  /// **'Your finished matches will be listed here.'**
  String get matchNoHistoryMessage;

  /// No description provided for @matchBrowseCompetitions.
  ///
  /// In en, this message translates to:
  /// **'Browse competitions'**
  String get matchBrowseCompetitions;

  /// No description provided for @matchTimesUp.
  ///
  /// In en, this message translates to:
  /// **'Time\'s up'**
  String get matchTimesUp;

  /// No description provided for @matchUntil.
  ///
  /// In en, this message translates to:
  /// **'until {when}'**
  String matchUntil(String when);

  /// No description provided for @matchFind.
  ///
  /// In en, this message translates to:
  /// **'Find {name}'**
  String matchFind(String name);

  /// No description provided for @matchNoGameAccount.
  ///
  /// In en, this message translates to:
  /// **'They haven\'t linked an eFootball account yet.'**
  String get matchNoGameAccount;

  /// No description provided for @matchNoUserId.
  ///
  /// In en, this message translates to:
  /// **'They haven\'t added their User ID, so search for their in-game name.'**
  String get matchNoUserId;

  /// No description provided for @matchAddByUserId.
  ///
  /// In en, this message translates to:
  /// **'Add them as a friend in eFootball with their User ID.'**
  String get matchAddByUserId;

  /// No description provided for @matchUserId.
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get matchUserId;

  /// No description provided for @matchInGameName.
  ///
  /// In en, this message translates to:
  /// **'In-game name'**
  String get matchInGameName;

  /// No description provided for @matchCopyLabel.
  ///
  /// In en, this message translates to:
  /// **'Copy {label}'**
  String matchCopyLabel(String label);

  /// No description provided for @matchBadgeReportScore.
  ///
  /// In en, this message translates to:
  /// **'Report score'**
  String get matchBadgeReportScore;

  /// No description provided for @matchBadgeWaitingOnOpponent.
  ///
  /// In en, this message translates to:
  /// **'Waiting on opponent'**
  String get matchBadgeWaitingOnOpponent;

  /// No description provided for @matchBadgeConfirmResult.
  ///
  /// In en, this message translates to:
  /// **'Confirm result'**
  String get matchBadgeConfirmResult;

  /// No description provided for @matchBadgeSendScreenshots.
  ///
  /// In en, this message translates to:
  /// **'Send screenshots'**
  String get matchBadgeSendScreenshots;

  /// No description provided for @matchBadgeSettling.
  ///
  /// In en, this message translates to:
  /// **'Settling'**
  String get matchBadgeSettling;

  /// No description provided for @matchBadgeForfeit.
  ///
  /// In en, this message translates to:
  /// **'Forfeit'**
  String get matchBadgeForfeit;

  /// No description provided for @matchBadgeCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get matchBadgeCancelled;

  /// No description provided for @matchBadgeOut.
  ///
  /// In en, this message translates to:
  /// **'Out'**
  String get matchBadgeOut;

  /// No description provided for @matchBadgeWon.
  ///
  /// In en, this message translates to:
  /// **'Won'**
  String get matchBadgeWon;

  /// No description provided for @matchBadgeLost.
  ///
  /// In en, this message translates to:
  /// **'Lost'**
  String get matchBadgeLost;

  /// No description provided for @matchBadgeDrawn.
  ///
  /// In en, this message translates to:
  /// **'Drawn'**
  String get matchBadgeDrawn;

  /// No description provided for @matchCheckInBy.
  ///
  /// In en, this message translates to:
  /// **'Check in by {when}'**
  String matchCheckInBy(String when);

  /// No description provided for @matchOpponentToBeDecided.
  ///
  /// In en, this message translates to:
  /// **'Opponent to be decided'**
  String get matchOpponentToBeDecided;

  /// No description provided for @matchVsOpponent.
  ///
  /// In en, this message translates to:
  /// **'vs {name}'**
  String matchVsOpponent(String name);

  /// No description provided for @matchWaitingEarlierRound.
  ///
  /// In en, this message translates to:
  /// **'Waiting for an earlier round'**
  String get matchWaitingEarlierRound;

  /// No description provided for @matchFormat.
  ///
  /// In en, this message translates to:
  /// **'Format'**
  String get matchFormat;

  /// No description provided for @matchFormatOneGame.
  ///
  /// In en, this message translates to:
  /// **'1 game'**
  String get matchFormatOneGame;

  /// No description provided for @matchFormatBestOf.
  ///
  /// In en, this message translates to:
  /// **'Best of {count}'**
  String matchFormatBestOf(int count);

  /// No description provided for @matchKickOff.
  ///
  /// In en, this message translates to:
  /// **'Kick-off'**
  String get matchKickOff;

  /// No description provided for @matchNotSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get matchNotSet;

  /// No description provided for @matchCode.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get matchCode;

  /// What was copied, as in "Match code copied".
  ///
  /// In en, this message translates to:
  /// **'Match code'**
  String get matchCodeName;

  /// No description provided for @matchDrawsCount.
  ///
  /// In en, this message translates to:
  /// **'Draws count'**
  String get matchDrawsCount;

  /// No description provided for @matchPenaltiesIfLevel.
  ///
  /// In en, this message translates to:
  /// **'Penalties if level'**
  String get matchPenaltiesIfLevel;

  /// No description provided for @matchRejectTitle.
  ///
  /// In en, this message translates to:
  /// **'Reject this result?'**
  String get matchRejectTitle;

  /// No description provided for @matchRejectMessage.
  ///
  /// In en, this message translates to:
  /// **'{minutes, plural, =1{You and {opponent} will each have 1 minute to send a screenshot of the Full Time screen. If you don\'t send one, you\'re removed from the competition.} other{You and {opponent} will each have {minutes} minutes to send a screenshot of the Full Time screen. If you don\'t send one, you\'re removed from the competition.}}'**
  String matchRejectMessage(String opponent, int minutes);

  /// No description provided for @matchReject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get matchReject;

  /// No description provided for @matchToneYourMove.
  ///
  /// In en, this message translates to:
  /// **'Your move'**
  String get matchToneYourMove;

  /// No description provided for @matchToneWaiting.
  ///
  /// In en, this message translates to:
  /// **'Waiting'**
  String get matchToneWaiting;

  /// No description provided for @matchToneFinal.
  ///
  /// In en, this message translates to:
  /// **'Final'**
  String get matchToneFinal;

  /// No description provided for @matchUploadingScreenshot.
  ///
  /// In en, this message translates to:
  /// **'Uploading your screenshot…'**
  String get matchUploadingScreenshot;

  /// No description provided for @matchCheckingScreenshot.
  ///
  /// In en, this message translates to:
  /// **'Checking your screenshot…'**
  String get matchCheckingScreenshot;

  /// No description provided for @matchConfirmYes.
  ///
  /// In en, this message translates to:
  /// **'Yes, that\'s right'**
  String get matchConfirmYes;

  /// No description provided for @matchConfirmNo.
  ///
  /// In en, this message translates to:
  /// **'No, it\'s wrong'**
  String get matchConfirmNo;

  /// No description provided for @matchChooseScreenshot.
  ///
  /// In en, this message translates to:
  /// **'Choose screenshot'**
  String get matchChooseScreenshot;

  /// No description provided for @matchReported.
  ///
  /// In en, this message translates to:
  /// **'Reported'**
  String get matchReported;

  /// No description provided for @matchToBeDecided.
  ///
  /// In en, this message translates to:
  /// **'To be decided'**
  String get matchToBeDecided;

  /// No description provided for @matchVs.
  ///
  /// In en, this message translates to:
  /// **'VS'**
  String get matchVs;

  /// No description provided for @matchOnPens.
  ///
  /// In en, this message translates to:
  /// **'{mine}–{theirs} on pens'**
  String matchOnPens(int mine, int theirs);

  /// No description provided for @matchOneLessFor.
  ///
  /// In en, this message translates to:
  /// **'One less for {name}'**
  String matchOneLessFor(String name);

  /// No description provided for @matchOneMoreFor.
  ///
  /// In en, this message translates to:
  /// **'One more for {name}'**
  String matchOneMoreFor(String name);

  /// No description provided for @matchScreenshotWrongType.
  ///
  /// In en, this message translates to:
  /// **'Choose a screenshot saved as JPEG or PNG.'**
  String get matchScreenshotWrongType;

  /// No description provided for @matchScreenshotTooLarge.
  ///
  /// In en, this message translates to:
  /// **'That image is too large. Choose the screenshot itself, up to 10 MB.'**
  String get matchScreenshotTooLarge;

  /// No description provided for @matchScreenshotUploadFailed.
  ///
  /// In en, this message translates to:
  /// **'The upload didn\'t go through. Try again.'**
  String get matchScreenshotUploadFailed;

  /// No description provided for @matchScreenshotUnusable.
  ///
  /// In en, this message translates to:
  /// **'That image couldn\'t be used. Choose the original screenshot of the Full Time screen.'**
  String get matchScreenshotUnusable;

  /// No description provided for @matchScreenshotSlow.
  ///
  /// In en, this message translates to:
  /// **'Checking the screenshot is taking longer than usual. Try again.'**
  String get matchScreenshotSlow;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
