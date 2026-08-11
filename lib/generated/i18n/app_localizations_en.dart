// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'MangaTek';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get resumeReading => 'Resume reading';

  @override
  String get startReading => 'Start reading';

  @override
  String get errorCredentials => 'Invalid email or password';

  @override
  String get errorEmpty => 'Oops, there is nothing here…';

  @override
  String get errorNetwork => 'Network issue, please check your internet access';

  @override
  String get errorTooManyRequest =>
      'Too many request have been made, please wait and try again';

  @override
  String get errorUnknown => 'An unknown error has occurred';

  @override
  String get chapter => 'Chapter';

  @override
  String get chapters => 'Chapters';

  @override
  String get email => 'Email';

  @override
  String get home => 'Home';

  @override
  String get language => 'Language';

  @override
  String get password => 'Password';

  @override
  String get settings => 'Settings';

  @override
  String get version => 'Version';
}
