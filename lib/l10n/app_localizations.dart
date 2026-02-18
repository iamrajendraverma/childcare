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
/// import 'l10n/app_localizations.dart';
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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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

  /// The standard greeting
  ///
  /// In en, this message translates to:
  /// **'Hello World!'**
  String get helloWorld;

  /// The name of the app
  ///
  /// In en, this message translates to:
  /// **'Child Care'**
  String get app_name;

  /// The welcome back message
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcome_back;

  /// The email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// The password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// The login button text
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// The signup button text
  ///
  /// In en, this message translates to:
  /// **'Signup'**
  String get signup;

  /// The forgot password button text
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgot_password;

  /// The logout message
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// The home screen title
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// The email error message
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get email_error;

  /// The password error message
  ///
  /// In en, this message translates to:
  /// **'Please enter a password'**
  String get password_error;

  /// The login error message
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get login_error;

  /// The signup error message
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get signup_error;

  /// The forgot password error message
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get forgot_password_error;

  /// The logout error message
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get logout_error;

  /// The login success message
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get login_success;

  /// The signup success message
  ///
  /// In en, this message translates to:
  /// **'Signup successful'**
  String get signup_success;

  /// The forgot password success message
  ///
  /// In en, this message translates to:
  /// **'Forgot password successful'**
  String get forgot_password_success;

  /// The logout success message
  ///
  /// In en, this message translates to:
  /// **'Logout successful'**
  String get logout_success;

  /// The do not have an account message
  ///
  /// In en, this message translates to:
  /// **'Do not have an account?'**
  String get do_not_have_an_account;

  /// The password length error message
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get password_length_error;

  /// The full name field label
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get full_name;

  /// The name error message
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get name_error;

  /// The name length error message
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 2 characters'**
  String get name_length_error;

  /// The recording saved message
  ///
  /// In en, this message translates to:
  /// **'Recording saved successfully'**
  String get recording_saved;

  /// The recording error message
  ///
  /// In en, this message translates to:
  /// **'Recording failed'**
  String get recording_error;

  /// The recording canceled message
  ///
  /// In en, this message translates to:
  /// **'Recording canceled'**
  String get recording_canceled;

  /// The users message
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get users;

  /// The user message
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// The no recording available message
  ///
  /// In en, this message translates to:
  /// **'No recording available'**
  String get no_recording_available;

  /// The microphone permission denied message
  ///
  /// In en, this message translates to:
  /// **'Microphone permission denied'**
  String get microphone_permission_denied;

  /// The are you sure you want to logout message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get are_you_sure_you_want_to_logout;

  /// The cancel message
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// The close message
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;
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
