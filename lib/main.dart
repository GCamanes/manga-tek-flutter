import 'package:flutter/material.dart';
import 'package:mangatek_flutter/core/data/datasources/flavor/flavor.pigeon.g.dart';
import 'package:mangatek_flutter/core/data/datasources/flavor/flavor_native.datasource_impl.dart';
import 'package:mangatek_flutter/core/helpers/config_holder.dart';
import 'package:mangatek_flutter/core/navigation/app.router.dart';

import 'generated/i18n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigHolder.initialize(FlavorNativeDatasourceImpl(FlavorApi()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: !ConfigHolder.instance.isProd,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      routerConfig: appRouter,
    );
  }
}
