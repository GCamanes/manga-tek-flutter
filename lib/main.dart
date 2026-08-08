import 'package:flutter/material.dart';
import 'package:mangatek_flutter/core/di/injection.dart';
import 'package:mangatek_flutter/core/helpers/config_holder.dart';
import 'package:mangatek_flutter/core/navigation/app.router.dart';

import 'generated/i18n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      routerConfig: appRouter,
    );
  }
}
