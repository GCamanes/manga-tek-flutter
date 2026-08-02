import 'package:flutter/material.dart';
import 'package:mangatek_flutter/generated/i18n/app_localizations.dart';

extension BuildContextExtension on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  AppLocalizations get trad => AppLocalizations.of(this)!;
}
