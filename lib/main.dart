import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mangatek_flutter/core/di/injection.dart';
import 'package:mangatek_flutter/core/helpers/config_holder.dart';
import 'package:mangatek_flutter/core/navigation/app.router.dart';
import 'package:mangatek_flutter/core/theme/app.theme.dart';

import 'generated/i18n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Firebase initialization (uses native GoogleService-Info.plist / google-services.json per flavor)
  await Firebase.initializeApp();

  /// Dependency injection
  await configureDependencies();

  /// Initialize config holder with flavor and other configurations
  await ConfigHolder.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: !ConfigHolder.isProd,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
