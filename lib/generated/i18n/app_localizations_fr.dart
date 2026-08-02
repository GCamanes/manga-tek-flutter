// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'MangaTek';

  @override
  String get login => 'Se connecter';

  @override
  String get logout => 'Se déconnecter';

  @override
  String get resumeReading => 'Reprendre la lecture';

  @override
  String get startReading => 'Lancer la lecture';

  @override
  String get errorCredentials => 'Email ou mot de passe invalide';

  @override
  String get errorEmpty => 'Oups, il n\'y a rien ici…';

  @override
  String get errorNetwork =>
      'Problème de réseau, merci de vérifier votre accès à internet';

  @override
  String get errorTooManyRequest =>
      'Trop de tentatives, merci de patienter et de recommencer plus tard';

  @override
  String get errorUnknown => 'Une erreur inconnue est survenue';

  @override
  String get chapter => 'Chapitre';

  @override
  String get chapters => 'Chapitres';

  @override
  String get email => 'Email';

  @override
  String get home => 'Accueil';

  @override
  String get language => 'Langue';

  @override
  String get password => 'Mot de passe';

  @override
  String get settings => 'Paramètres';

  @override
  String get version => 'Version';
}
