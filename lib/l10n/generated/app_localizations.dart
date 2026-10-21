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

  /// No description provided for @accountUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get accountUsername;

  /// No description provided for @accountEditUsernameIntro.
  ///
  /// In en, this message translates to:
  /// **'Your @handle in rankings and links. Your display name stays the same.'**
  String get accountEditUsernameIntro;

  /// No description provided for @accountUsernameUpdated.
  ///
  /// In en, this message translates to:
  /// **'Username updated'**
  String get accountUsernameUpdated;

  /// No description provided for @profileChangePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change photo'**
  String get profileChangePhoto;

  /// No description provided for @profilePhotoUpdated.
  ///
  /// In en, this message translates to:
  /// **'Photo updated'**
  String get profilePhotoUpdated;

  /// No description provided for @profilePhotoWrongType.
  ///
  /// In en, this message translates to:
  /// **'Use a JPEG, PNG or WebP photo.'**
  String get profilePhotoWrongType;

  /// No description provided for @profilePhotoTooLarge.
  ///
  /// In en, this message translates to:
  /// **'That photo is over 10 MB. Try a smaller one.'**
  String get profilePhotoTooLarge;

  /// No description provided for @profilePhotoUploadFailed.
  ///
  /// In en, this message translates to:
  /// **'The photo didn\'t upload. Try again.'**
  String get profilePhotoUploadFailed;

  /// No description provided for @profilePhotoUnusable.
  ///
  /// In en, this message translates to:
  /// **'That photo can\'t be used. Try another.'**
  String get profilePhotoUnusable;

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

  /// The match room's button to its chat, and screen reader label.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chatTitle;

  /// No description provided for @chatUnread.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 unread message} other{{count} unread messages}}'**
  String chatUnread(int count);

  /// No description provided for @chatEmpty.
  ///
  /// In en, this message translates to:
  /// **'Say hi to {name} and sort out when to play.'**
  String chatEmpty(String name);

  /// No description provided for @chatPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Ozone only reads this chat if there\'s a dispute or a report.'**
  String get chatPrivacy;

  /// No description provided for @chatClosed.
  ///
  /// In en, this message translates to:
  /// **'The match is over, so this chat is closed.'**
  String get chatClosed;

  /// No description provided for @chatMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Message {name}'**
  String chatMessageHint(String name);

  /// No description provided for @chatSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get chatSend;

  /// No description provided for @chatToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get chatToday;

  /// No description provided for @chatYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get chatYesterday;

  /// No description provided for @chatRoomCode.
  ///
  /// In en, this message translates to:
  /// **'Room code'**
  String get chatRoomCode;

  /// No description provided for @chatDropCode.
  ///
  /// In en, this message translates to:
  /// **'Drop code'**
  String get chatDropCode;

  /// No description provided for @chatNewCode.
  ///
  /// In en, this message translates to:
  /// **'New code'**
  String get chatNewCode;

  /// No description provided for @chatCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get chatCopy;

  /// No description provided for @chatDropCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Drop the room code'**
  String get chatDropCodeTitle;

  /// No description provided for @chatDropCodeHelp.
  ///
  /// In en, this message translates to:
  /// **'Make the Friend Match room in eFootball, then type its code. It gets pinned for both of you.'**
  String get chatDropCodeHelp;

  /// No description provided for @chatRoomCodeInvalid.
  ///
  /// In en, this message translates to:
  /// **'Letters, numbers, spaces or dashes only.'**
  String get chatRoomCodeInvalid;

  /// No description provided for @chatPinCode.
  ///
  /// In en, this message translates to:
  /// **'Pin code'**
  String get chatPinCode;

  /// No description provided for @chatKickOff.
  ///
  /// In en, this message translates to:
  /// **'Kick-off'**
  String get chatKickOff;

  /// No description provided for @chatKickOffNotSet.
  ///
  /// In en, this message translates to:
  /// **'Not set yet'**
  String get chatKickOffNotSet;

  /// No description provided for @chatSuggestTime.
  ///
  /// In en, this message translates to:
  /// **'Suggest time'**
  String get chatSuggestTime;

  /// No description provided for @chatChange.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get chatChange;

  /// No description provided for @chatSuggestTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'When do you want to play?'**
  String get chatSuggestTimeTitle;

  /// No description provided for @chatInMinutes.
  ///
  /// In en, this message translates to:
  /// **'In {minutes} min'**
  String chatInMinutes(int minutes);

  /// No description provided for @chatInAnHour.
  ///
  /// In en, this message translates to:
  /// **'In 1 hour'**
  String get chatInAnHour;

  /// No description provided for @chatPickTime.
  ///
  /// In en, this message translates to:
  /// **'Pick a time'**
  String get chatPickTime;

  /// No description provided for @chatTheyWant.
  ///
  /// In en, this message translates to:
  /// **'{name} wants'**
  String chatTheyWant(String name);

  /// No description provided for @chatYouSuggested.
  ///
  /// In en, this message translates to:
  /// **'You suggested'**
  String get chatYouSuggested;

  /// No description provided for @chatWaitingFor.
  ///
  /// In en, this message translates to:
  /// **'Waiting for {name}'**
  String chatWaitingFor(String name);

  /// No description provided for @chatDeadlinesApply.
  ///
  /// In en, this message translates to:
  /// **'Deadlines still apply'**
  String get chatDeadlinesApply;

  /// No description provided for @chatPlayAt.
  ///
  /// In en, this message translates to:
  /// **'Play at'**
  String get chatPlayAt;

  /// No description provided for @chatAccept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get chatAccept;

  /// No description provided for @chatNotThen.
  ///
  /// In en, this message translates to:
  /// **'Not then'**
  String get chatNotThen;

  /// No description provided for @chatAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get chatAccepted;

  /// No description provided for @chatKickOffSet.
  ///
  /// In en, this message translates to:
  /// **'Kick-off set'**
  String get chatKickOffSet;

  /// No description provided for @chatYouSaidNo.
  ///
  /// In en, this message translates to:
  /// **'You said not then'**
  String get chatYouSaidNo;

  /// No description provided for @chatTheySaidNo.
  ///
  /// In en, this message translates to:
  /// **'{name} said not then'**
  String chatTheySaidNo(String name);

  /// No description provided for @chatSeen.
  ///
  /// In en, this message translates to:
  /// **'Seen'**
  String get chatSeen;

  /// No description provided for @chatSent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get chatSent;

  /// No description provided for @chatSending.
  ///
  /// In en, this message translates to:
  /// **'Sending'**
  String get chatSending;

  /// No description provided for @chatNotSent.
  ///
  /// In en, this message translates to:
  /// **'Not sent. Tap to retry.'**
  String get chatNotSent;

  /// No description provided for @chatContactHidden.
  ///
  /// In en, this message translates to:
  /// **'Numbers and links are hidden.'**
  String get chatContactHidden;

  /// No description provided for @chatQuickReadyNow.
  ///
  /// In en, this message translates to:
  /// **'Ready now'**
  String get chatQuickReadyNow;

  /// No description provided for @chatQuickFiveMinutes.
  ///
  /// In en, this message translates to:
  /// **'Give me 5 min'**
  String get chatQuickFiveMinutes;

  /// No description provided for @chatQuickTenMinutes.
  ///
  /// In en, this message translates to:
  /// **'Give me 10 min'**
  String get chatQuickTenMinutes;

  /// No description provided for @chatQuickFriendRequestSent.
  ///
  /// In en, this message translates to:
  /// **'Friend request sent'**
  String get chatQuickFriendRequestSent;

  /// No description provided for @chatQuickRoomCreated.
  ///
  /// In en, this message translates to:
  /// **'Room\'s up'**
  String get chatQuickRoomCreated;

  /// Good game: what players say after a match.
  ///
  /// In en, this message translates to:
  /// **'GG'**
  String get chatQuickGoodGame;

  /// No description provided for @chatReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Report this message'**
  String get chatReportTitle;

  /// No description provided for @chatReasonAbuse.
  ///
  /// In en, this message translates to:
  /// **'Abuse'**
  String get chatReasonAbuse;

  /// No description provided for @chatReasonHarassment.
  ///
  /// In en, this message translates to:
  /// **'Harassment'**
  String get chatReasonHarassment;

  /// No description provided for @chatReasonCheating.
  ///
  /// In en, this message translates to:
  /// **'Cheating'**
  String get chatReasonCheating;

  /// No description provided for @chatReasonSpam.
  ///
  /// In en, this message translates to:
  /// **'Spam'**
  String get chatReasonSpam;

  /// No description provided for @chatReasonOther.
  ///
  /// In en, this message translates to:
  /// **'Something else'**
  String get chatReasonOther;

  /// No description provided for @chatReported.
  ///
  /// In en, this message translates to:
  /// **'Reported. We\'ll check it.'**
  String get chatReported;

  /// No description provided for @chatErrorClosed.
  ///
  /// In en, this message translates to:
  /// **'The match is over, so this chat is closed.'**
  String get chatErrorClosed;

  /// No description provided for @chatErrorFull.
  ///
  /// In en, this message translates to:
  /// **'This chat is full.'**
  String get chatErrorFull;

  /// No description provided for @chatErrorProposedTime.
  ///
  /// In en, this message translates to:
  /// **'Pick a time before the match deadline.'**
  String get chatErrorProposedTime;

  /// No description provided for @chatErrorProposalGone.
  ///
  /// In en, this message translates to:
  /// **'That time was already answered or replaced.'**
  String get chatErrorProposalGone;

  /// No description provided for @chatErrorProposalExpired.
  ///
  /// In en, this message translates to:
  /// **'That time has passed.'**
  String get chatErrorProposalExpired;

  /// No description provided for @chatErrorAlreadyReported.
  ///
  /// In en, this message translates to:
  /// **'You\'ve already reported this message.'**
  String get chatErrorAlreadyReported;

  /// No description provided for @chatRoomCodeNotShared.
  ///
  /// In en, this message translates to:
  /// **'Not shared yet'**
  String get chatRoomCodeNotShared;

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

  /// No description provided for @competitionWithdrawPaidTitle.
  ///
  /// In en, this message translates to:
  /// **'Withdraw and get a refund?'**
  String get competitionWithdrawPaidTitle;

  /// No description provided for @competitionWithdrawPaidMessage.
  ///
  /// In en, this message translates to:
  /// **'We\'ll review it and refund {fee} to your M-Pesa. Your place is held until then.'**
  String competitionWithdrawPaidMessage(String fee);

  /// No description provided for @competitionWithdrawPaidConfirm.
  ///
  /// In en, this message translates to:
  /// **'Ask for refund'**
  String get competitionWithdrawPaidConfirm;

  /// No description provided for @competitionWithdrawRequested.
  ///
  /// In en, this message translates to:
  /// **'Refund requested.'**
  String get competitionWithdrawRequested;

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

  /// No description provided for @errorWithdrawalClosed.
  ///
  /// In en, this message translates to:
  /// **'Registration has closed, so you can\'t withdraw now.'**
  String get errorWithdrawalClosed;

  /// No description provided for @errorRefundRequestExists.
  ///
  /// In en, this message translates to:
  /// **'You\'ve already asked for a refund.'**
  String get errorRefundRequestExists;

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

  /// Section title over a knockout competition's rounds.
  ///
  /// In en, this message translates to:
  /// **'Bracket'**
  String get drawBracket;

  /// Section title over a round-robin table.
  ///
  /// In en, this message translates to:
  /// **'Standings'**
  String get drawStandings;

  /// Section title over a round robin's matchdays.
  ///
  /// In en, this message translates to:
  /// **'Matches'**
  String get drawMatches;

  /// Section title over a finished competition's placings.
  ///
  /// In en, this message translates to:
  /// **'Final standings'**
  String get drawFinalStandings;

  /// A round-robin group.
  ///
  /// In en, this message translates to:
  /// **'Group {letter}'**
  String drawGroup(String letter);

  /// A round of a round robin.
  ///
  /// In en, this message translates to:
  /// **'Matchday {number}'**
  String drawMatchday(int number);

  /// A round of a double elimination's winners bracket.
  ///
  /// In en, this message translates to:
  /// **'Winners round {number}'**
  String drawWinnersRound(int number);

  /// A round of a double elimination's losers bracket.
  ///
  /// In en, this message translates to:
  /// **'Losers round {number}'**
  String drawLosersRound(int number);

  /// No description provided for @drawGrandFinal.
  ///
  /// In en, this message translates to:
  /// **'Grand final'**
  String get drawGrandFinal;

  /// The deciding grand final, played when the losers' finalist wins the first.
  ///
  /// In en, this message translates to:
  /// **'Grand final reset'**
  String get drawGrandFinalReset;

  /// A bracket slot whose player isn't known yet.
  ///
  /// In en, this message translates to:
  /// **'To be decided'**
  String get drawToBeDecided;

  /// A bracket slot no one will fill: the match that fed it ended without a winner.
  ///
  /// In en, this message translates to:
  /// **'No opponent'**
  String get drawNoOpponent;

  /// A level knockout match's shootout, home first.
  ///
  /// In en, this message translates to:
  /// **'{home}–{away} on penalties'**
  String drawPenalties(int home, int away);

  /// No description provided for @drawWalkover.
  ///
  /// In en, this message translates to:
  /// **'Walkover'**
  String get drawWalkover;

  /// No description provided for @drawNoShow.
  ///
  /// In en, this message translates to:
  /// **'Neither player showed'**
  String get drawNoShow;

  /// No description provided for @drawForfeit.
  ///
  /// In en, this message translates to:
  /// **'Forfeit'**
  String get drawForfeit;

  /// No description provided for @drawDecidedOnReview.
  ///
  /// In en, this message translates to:
  /// **'Decided on review'**
  String get drawDecidedOnReview;

  /// No description provided for @drawDisputed.
  ///
  /// In en, this message translates to:
  /// **'Disputed'**
  String get drawDisputed;

  /// No description provided for @drawCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get drawCancelled;

  /// A player disqualified or withdrawn after the draw; their results stand, unranked.
  ///
  /// In en, this message translates to:
  /// **'Removed'**
  String get drawRemoved;

  /// No description provided for @drawPlayedShort.
  ///
  /// In en, this message translates to:
  /// **'P'**
  String get drawPlayedShort;

  /// No description provided for @drawPlayed.
  ///
  /// In en, this message translates to:
  /// **'Played'**
  String get drawPlayed;

  /// No description provided for @drawWonShort.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get drawWonShort;

  /// No description provided for @drawWon.
  ///
  /// In en, this message translates to:
  /// **'Won'**
  String get drawWon;

  /// No description provided for @drawDrawnShort.
  ///
  /// In en, this message translates to:
  /// **'D'**
  String get drawDrawnShort;

  /// No description provided for @drawDrawn.
  ///
  /// In en, this message translates to:
  /// **'Drawn'**
  String get drawDrawn;

  /// No description provided for @drawLostShort.
  ///
  /// In en, this message translates to:
  /// **'L'**
  String get drawLostShort;

  /// No description provided for @drawLost.
  ///
  /// In en, this message translates to:
  /// **'Lost'**
  String get drawLost;

  /// No description provided for @drawDifferenceShort.
  ///
  /// In en, this message translates to:
  /// **'+/-'**
  String get drawDifferenceShort;

  /// No description provided for @drawGoalDifference.
  ///
  /// In en, this message translates to:
  /// **'Goal difference'**
  String get drawGoalDifference;

  /// No description provided for @drawGameDifference.
  ///
  /// In en, this message translates to:
  /// **'Game difference'**
  String get drawGameDifference;

  /// No description provided for @drawPointsShort.
  ///
  /// In en, this message translates to:
  /// **'Pts'**
  String get drawPointsShort;

  /// No description provided for @drawPoints.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get drawPoints;

  /// Screen reader label for a final placing's number.
  ///
  /// In en, this message translates to:
  /// **'Place {place}'**
  String drawPlacing(int place);

  /// Title of the list of competitions the player entered, and its row on Profile.
  ///
  /// In en, this message translates to:
  /// **'My entries'**
  String get entriesTitle;

  /// Profile group holding My entries.
  ///
  /// In en, this message translates to:
  /// **'Competitions'**
  String get entriesGroup;

  /// No description provided for @entriesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No entries yet'**
  String get entriesEmpty;

  /// No description provided for @entriesEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Competitions you enter show up here.'**
  String get entriesEmptyMessage;

  /// No description provided for @entriesFind.
  ///
  /// In en, this message translates to:
  /// **'Find a competition'**
  String get entriesFind;

  /// No description provided for @entryRegistered.
  ///
  /// In en, this message translates to:
  /// **'Entered'**
  String get entryRegistered;

  /// No description provided for @entryCheckedIn.
  ///
  /// In en, this message translates to:
  /// **'Checked in'**
  String get entryCheckedIn;

  /// An entry accepted into the competition's draw.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get entryAccepted;

  /// No description provided for @entryRefundPending.
  ///
  /// In en, this message translates to:
  /// **'Refund pending'**
  String get entryRefundPending;

  /// No description provided for @entryWithdrawn.
  ///
  /// In en, this message translates to:
  /// **'Withdrawn'**
  String get entryWithdrawn;

  /// An entry disqualified by staff.
  ///
  /// In en, this message translates to:
  /// **'Removed'**
  String get entryRemoved;

  /// The competition was cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get entryCancelled;

  /// The competition is over.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get entryFinished;

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

  /// No description provided for @notifTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifTitle;

  /// No description provided for @notifAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get notifAll;

  /// No description provided for @notifUnread.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get notifUnread;

  /// No description provided for @notifMarkAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get notifMarkAllRead;

  /// No description provided for @notifEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get notifEmptyTitle;

  /// No description provided for @notifEmptyUnreadTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re all caught up'**
  String get notifEmptyUnreadTitle;

  /// No description provided for @notifEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Match, result and competition updates appear here.'**
  String get notifEmptyMessage;

  /// Screen-reader label for the bell on Home.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Notifications} =1{Notifications, 1 unread} other{Notifications, {count} unread}}'**
  String notifBellLabel(int count);

  /// No description provided for @notifUnreadLabel.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get notifUnreadLabel;

  /// No description provided for @notifJustNow.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get notifJustNow;

  /// How long ago, shortly: '5 min'.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String notifMinutesAgo(int minutes);

  /// How long ago, shortly: '3 h'.
  ///
  /// In en, this message translates to:
  /// **'{hours} h'**
  String notifHoursAgo(int hours);

  /// No description provided for @notifYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get notifYesterday;

  /// No description provided for @roomScheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get roomScheduled;

  /// No description provided for @roomOpponentTbd.
  ///
  /// In en, this message translates to:
  /// **'Opponent comes from an earlier round'**
  String get roomOpponentTbd;

  /// No description provided for @roomCheckInOpens.
  ///
  /// In en, this message translates to:
  /// **'Check-in opens {when}'**
  String roomCheckInOpens(String when);

  /// No description provided for @roomKickOff.
  ///
  /// In en, this message translates to:
  /// **'Kick-off {when}'**
  String roomKickOff(String when);

  /// No description provided for @roomCheckInNow.
  ///
  /// In en, this message translates to:
  /// **'Check in to play'**
  String get roomCheckInNow;

  /// No description provided for @roomWaitingCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Waiting for {opponent} to check in'**
  String roomWaitingCheckIn(String opponent);

  /// No description provided for @roomPlayThenReport.
  ///
  /// In en, this message translates to:
  /// **'Play, then report the score'**
  String get roomPlayThenReport;

  /// No description provided for @roomPlayThenReportSeries.
  ///
  /// In en, this message translates to:
  /// **'Play, then report games won'**
  String get roomPlayThenReportSeries;

  /// No description provided for @roomWaitingConfirm.
  ///
  /// In en, this message translates to:
  /// **'Waiting for {opponent} to confirm'**
  String roomWaitingConfirm(String opponent);

  /// No description provided for @roomOpponentReported.
  ///
  /// In en, this message translates to:
  /// **'{opponent} reported this score'**
  String roomOpponentReported(String opponent);

  /// No description provided for @roomSendScreenshot.
  ///
  /// In en, this message translates to:
  /// **'Send your Full Time screenshot'**
  String get roomSendScreenshot;

  /// No description provided for @roomSendScreenshots.
  ///
  /// In en, this message translates to:
  /// **'Send a screenshot of each game'**
  String get roomSendScreenshots;

  /// No description provided for @roomScreenshotNote.
  ///
  /// In en, this message translates to:
  /// **'Send in time, or you\'re removed.'**
  String get roomScreenshotNote;

  /// No description provided for @roomWaitingScreenshots.
  ///
  /// In en, this message translates to:
  /// **'Waiting for {opponent}\'s screenshots'**
  String roomWaitingScreenshots(String opponent);

  /// No description provided for @roomBothScreenshotsIn.
  ///
  /// In en, this message translates to:
  /// **'Both screenshots are in'**
  String get roomBothScreenshotsIn;

  /// No description provided for @roomSettling.
  ///
  /// In en, this message translates to:
  /// **'Settling the result…'**
  String get roomSettling;

  /// No description provided for @roomUnderReview.
  ///
  /// In en, this message translates to:
  /// **'Ozone is reviewing the screenshots'**
  String get roomUnderReview;

  /// No description provided for @roomConfirmedBy.
  ///
  /// In en, this message translates to:
  /// **'Confirmed by {opponent}'**
  String roomConfirmedBy(String opponent);

  /// No description provided for @roomYouConfirmed.
  ///
  /// In en, this message translates to:
  /// **'You confirmed it'**
  String get roomYouConfirmed;

  /// No description provided for @roomUnansweredYours.
  ///
  /// In en, this message translates to:
  /// **'{opponent} didn\'t answer, so your score stood'**
  String roomUnansweredYours(String opponent);

  /// No description provided for @roomUnanswered.
  ///
  /// In en, this message translates to:
  /// **'Not answered in time, so it stood'**
  String get roomUnanswered;

  /// No description provided for @roomDecidedByReview.
  ///
  /// In en, this message translates to:
  /// **'Decided by Ozone'**
  String get roomDecidedByReview;

  /// No description provided for @roomOut.
  ///
  /// In en, this message translates to:
  /// **'You\'re out of this competition'**
  String get roomOut;

  /// No description provided for @roomUpdate.
  ///
  /// In en, this message translates to:
  /// **'Update Ozone to see this match'**
  String get roomUpdate;

  /// No description provided for @roomAccept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get roomAccept;

  /// No description provided for @roomDecline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get roomDecline;

  /// No description provided for @roomSendScreenshotButton.
  ///
  /// In en, this message translates to:
  /// **'Send screenshot'**
  String get roomSendScreenshotButton;

  /// No description provided for @roomSendScreenshotsButton.
  ///
  /// In en, this message translates to:
  /// **'Send screenshots'**
  String get roomSendScreenshotsButton;

  /// No description provided for @roomScreenshotsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your screenshots'**
  String get roomScreenshotsTitle;

  /// No description provided for @roomDeclaration.
  ///
  /// In en, this message translates to:
  /// **'I confirm this is the real score.'**
  String get roomDeclaration;

  /// Profile row and screen listing the devices signed in to the account.
  ///
  /// In en, this message translates to:
  /// **'Signed-in devices'**
  String get devicesTitle;

  /// No description provided for @devicesThisDevice.
  ///
  /// In en, this message translates to:
  /// **'This device'**
  String get devicesThisDevice;

  /// No description provided for @devicesUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown device'**
  String get devicesUnknown;

  /// No description provided for @devicesActiveNow.
  ///
  /// In en, this message translates to:
  /// **'Active now'**
  String get devicesActiveNow;

  /// No description provided for @devicesActiveMinutes.
  ///
  /// In en, this message translates to:
  /// **'Active {minutes} min ago'**
  String devicesActiveMinutes(int minutes);

  /// No description provided for @devicesActiveHours.
  ///
  /// In en, this message translates to:
  /// **'Active {hours} h ago'**
  String devicesActiveHours(int hours);

  /// No description provided for @devicesActiveYesterday.
  ///
  /// In en, this message translates to:
  /// **'Active yesterday'**
  String get devicesActiveYesterday;

  /// No description provided for @devicesActiveOn.
  ///
  /// In en, this message translates to:
  /// **'Active {date}'**
  String devicesActiveOn(String date);

  /// No description provided for @devicesSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get devicesSignOut;

  /// No description provided for @devicesSignOutTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out {device}?'**
  String devicesSignOutTitle(String device);

  /// No description provided for @devicesSignOutMessage.
  ///
  /// In en, this message translates to:
  /// **'It will need to sign in again.'**
  String get devicesSignOutMessage;

  /// No description provided for @devicesSignedOut.
  ///
  /// In en, this message translates to:
  /// **'Signed out {device}'**
  String devicesSignedOut(String device);

  /// No description provided for @deleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteTitle;

  /// No description provided for @deleteIntro.
  ///
  /// In en, this message translates to:
  /// **'Your profile, contact details and devices are removed. Match and payment records stay, without your name.'**
  String get deleteIntro;

  /// No description provided for @deleteWaitNote.
  ///
  /// In en, this message translates to:
  /// **'There\'s a 24-hour wait first, and you can cancel during it.'**
  String get deleteWaitNote;

  /// No description provided for @deleteRequest.
  ///
  /// In en, this message translates to:
  /// **'Request deletion'**
  String get deleteRequest;

  /// No description provided for @deleteRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete your account?'**
  String get deleteRequestTitle;

  /// No description provided for @deleteRequestMessage.
  ///
  /// In en, this message translates to:
  /// **'You can finish deleting it after 24 hours, or cancel before then.'**
  String get deleteRequestMessage;

  /// No description provided for @deleteRequested.
  ///
  /// In en, this message translates to:
  /// **'Deletion requested'**
  String get deleteRequested;

  /// Label over the date and time the 24-hour wait ends.
  ///
  /// In en, this message translates to:
  /// **'You can delete it from'**
  String get deleteAvailableFrom;

  /// DELETE is the literal word the player types; keep it in English capitals.
  ///
  /// In en, this message translates to:
  /// **'Type DELETE to delete your account for good.'**
  String get deleteReady;

  /// No description provided for @deleteConfirmLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get deleteConfirmLabel;

  /// No description provided for @deleteForGood.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteForGood;

  /// No description provided for @deleteCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel request'**
  String get deleteCancel;

  /// No description provided for @deleteCancelled.
  ///
  /// In en, this message translates to:
  /// **'Deletion cancelled'**
  String get deleteCancelled;

  /// A match format: how many games a match is.
  ///
  /// In en, this message translates to:
  /// **'Best of {count}'**
  String seriesBestOf(int count);

  /// No description provided for @seriesBestOfFirstTo.
  ///
  /// In en, this message translates to:
  /// **'Best of {count} · first to {wins}'**
  String seriesBestOfFirstTo(int count, int wins);

  /// No description provided for @seriesFirstToWins.
  ///
  /// In en, this message translates to:
  /// **'{wins, plural, =1{First to 1 win} other{First to {wins} wins}}'**
  String seriesFirstToWins(int wins);

  /// No description provided for @seriesGame.
  ///
  /// In en, this message translates to:
  /// **'Game {number}'**
  String seriesGame(int number);

  /// No description provided for @seriesLevel.
  ///
  /// In en, this message translates to:
  /// **'Level {mine}–{theirs}'**
  String seriesLevel(int mine, int theirs);

  /// No description provided for @seriesYouWin.
  ///
  /// In en, this message translates to:
  /// **'You win the series {mine}–{theirs}'**
  String seriesYouWin(int mine, int theirs);

  /// No description provided for @seriesTheyWin.
  ///
  /// In en, this message translates to:
  /// **'{opponent} wins the series {theirs}–{mine}'**
  String seriesTheyWin(String opponent, int theirs, int mine);

  /// No description provided for @seriesNeedsWinner.
  ///
  /// In en, this message translates to:
  /// **'{wins, plural, =1{One of you needs 1 win.} other{One of you needs {wins} wins.}}'**
  String seriesNeedsWinner(int wins);

  /// No description provided for @seriesScreenshotReminder.
  ///
  /// In en, this message translates to:
  /// **'Screenshot every game\'s Full Time screen. You\'ll need them if the result is disputed.'**
  String get seriesScreenshotReminder;

  /// No description provided for @seriesChoose.
  ///
  /// In en, this message translates to:
  /// **'Choose'**
  String get seriesChoose;

  /// No description provided for @seriesChange.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get seriesChange;

  /// No description provided for @seriesSendScreenshots.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Send screenshots} =1{Send 1 screenshot} other{Send {count} screenshots}}'**
  String seriesSendScreenshots(int count);

  /// No description provided for @seriesUploadingGame.
  ///
  /// In en, this message translates to:
  /// **'Uploading game {done} of {total}…'**
  String seriesUploadingGame(int done, int total);

  /// No description provided for @seriesCheckingGame.
  ///
  /// In en, this message translates to:
  /// **'Checking game {done} of {total}…'**
  String seriesCheckingGame(int done, int total);

  /// A screenshot problem, for one game of a series.
  ///
  /// In en, this message translates to:
  /// **'Game {game}: {message}'**
  String matchScreenshotProblemForGame(int game, String message);

  /// No description provided for @seriesFormatTitle.
  ///
  /// In en, this message translates to:
  /// **'Games per match'**
  String get seriesFormatTitle;

  /// No description provided for @seriesEveryMatch.
  ///
  /// In en, this message translates to:
  /// **'Every match'**
  String get seriesEveryMatch;

  /// No description provided for @seriesOtherRounds.
  ///
  /// In en, this message translates to:
  /// **'Other rounds'**
  String get seriesOtherRounds;

  /// No description provided for @seriesRoundFinal.
  ///
  /// In en, this message translates to:
  /// **'Final'**
  String get seriesRoundFinal;

  /// No description provided for @seriesRoundSemifinal.
  ///
  /// In en, this message translates to:
  /// **'Semi-finals'**
  String get seriesRoundSemifinal;

  /// No description provided for @seriesRoundQuarterfinal.
  ///
  /// In en, this message translates to:
  /// **'Quarter-finals'**
  String get seriesRoundQuarterfinal;

  /// No description provided for @seriesRoundOf.
  ///
  /// In en, this message translates to:
  /// **'Round of {count}'**
  String seriesRoundOf(int count);

  /// No description provided for @seriesRoundThirdPlace.
  ///
  /// In en, this message translates to:
  /// **'Third-place match'**
  String get seriesRoundThirdPlace;

  /// No description provided for @seriesRoundWinnersFinal.
  ///
  /// In en, this message translates to:
  /// **'Winners\' final'**
  String get seriesRoundWinnersFinal;

  /// No description provided for @seriesRoundLosersFinal.
  ///
  /// In en, this message translates to:
  /// **'Losers\' final'**
  String get seriesRoundLosersFinal;

  /// No description provided for @seriesGamesWon.
  ///
  /// In en, this message translates to:
  /// **'Games won'**
  String get seriesGamesWon;
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
