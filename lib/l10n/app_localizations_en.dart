// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get app_name => 'Child Care';

  @override
  String get welcome_back => 'Welcome Back';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get login => 'Login';

  @override
  String get signup => 'Signup';

  @override
  String get forgot_password => 'Forgot Password';

  @override
  String get logout => 'Logout';

  @override
  String get home => 'Home';

  @override
  String get email_error => 'Please enter a valid email address';

  @override
  String get password_error => 'Please enter a password';

  @override
  String get login_error => 'Invalid email or password';

  @override
  String get signup_error => 'Invalid email or password';

  @override
  String get forgot_password_error => 'Invalid email or password';

  @override
  String get logout_error => 'Invalid email or password';

  @override
  String get login_success => 'Login successful';

  @override
  String get signup_success => 'Signup successful';

  @override
  String get forgot_password_success => 'Forgot password successful';

  @override
  String get logout_success => 'Logout successful';

  @override
  String get do_not_have_an_account => 'Do not have an account?';

  @override
  String get password_length_error => 'Password must be at least 6 characters';

  @override
  String get full_name => 'Full Name';

  @override
  String get name_error => 'Please enter your name';

  @override
  String get name_length_error => 'Name must be at least 2 characters';

  @override
  String get recording_saved => 'Recording saved successfully';

  @override
  String get recording_error => 'Recording failed';

  @override
  String get recording_canceled => 'Recording canceled';

  @override
  String get users => 'Users';

  @override
  String get user => 'User';

  @override
  String get no_recording_available => 'No recording available';

  @override
  String get microphone_permission_denied => 'Microphone permission denied';

  @override
  String get are_you_sure_you_want_to_logout =>
      'Are you sure you want to logout?';

  @override
  String get cancel => 'Cancel';

  @override
  String get close => 'Close';
}
