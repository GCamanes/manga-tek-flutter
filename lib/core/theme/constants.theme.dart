import 'dart:ui';

import 'package:flutter/material.dart';

class ConstantsTheme extends ThemeExtension<ConstantsTheme> {
  final double paddingExtraSmall;
  final double paddingSmall;
  final double paddingMedium;
  final double paddingLarge;
  final double paddingBig;

  final double cornerRound;

  final double buttonHeight;
  final double iconHeight;
  final double mangaStatusHeight;
  final double smallButtonHeight;

  final double mangaCardHeight;
  final double mangaCardWidth;

  const ConstantsTheme({
    this.paddingExtraSmall = 4.0,
    this.paddingSmall = 8.0,
    this.paddingMedium = 16.0,
    this.paddingLarge = 32.0,
    this.paddingBig = 64.0,

    this.cornerRound = 8.0,

    this.buttonHeight = 56.0,
    this.iconHeight = 32.0,
    this.mangaStatusHeight = 25.0,
    this.smallButtonHeight = 40.0,

    this.mangaCardHeight = 140.0,
    this.mangaCardWidth = 88.0,
  });

  @override
  ConstantsTheme copyWith({
    double? paddingExtraSmall,
    double? paddingSmall,
    double? paddingMedium,
    double? paddingLarge,
    double? paddingBig,
    double? cornerRound,
    double? buttonHeight,
    double? iconHeight,
    double? mangaStatusHeight,
    double? smallButtonHeight,
    double? mangaCardHeight,
    double? mangaCardWidth,
  }) {
    return ConstantsTheme(
      paddingExtraSmall: paddingExtraSmall ?? this.paddingExtraSmall,
      paddingSmall: paddingSmall ?? this.paddingSmall,
      paddingMedium: paddingMedium ?? this.paddingMedium,
      paddingLarge: paddingLarge ?? this.paddingLarge,
      paddingBig: paddingBig ?? this.paddingBig,
      cornerRound: cornerRound ?? this.cornerRound,
      buttonHeight: buttonHeight ?? this.buttonHeight,
      iconHeight: iconHeight ?? this.iconHeight,
      mangaStatusHeight: mangaStatusHeight ?? this.mangaStatusHeight,
      smallButtonHeight: smallButtonHeight ?? this.smallButtonHeight,
      mangaCardHeight: mangaCardHeight ?? this.mangaCardHeight,
      mangaCardWidth: mangaCardWidth ?? this.mangaCardWidth,
    );
  }

  @override
  ConstantsTheme lerp(covariant ConstantsTheme? other, double t) {
    if (other == null) return this;

    return ConstantsTheme(
      paddingExtraSmall: lerpDouble(paddingExtraSmall, other.paddingExtraSmall, t)!,
      paddingSmall: lerpDouble(paddingSmall, other.paddingSmall, t)!,
      paddingMedium: lerpDouble(paddingMedium, other.paddingMedium, t)!,
      paddingLarge: lerpDouble(paddingLarge, other.paddingLarge, t)!,
      paddingBig: lerpDouble(paddingBig, other.paddingBig, t)!,
      cornerRound: lerpDouble(cornerRound, other.cornerRound, t)!,
      buttonHeight: lerpDouble(buttonHeight, other.buttonHeight, t)!,
      iconHeight: lerpDouble(iconHeight, other.iconHeight, t)!,
      mangaStatusHeight: lerpDouble(mangaStatusHeight, other.mangaStatusHeight, t)!,
      smallButtonHeight: lerpDouble(smallButtonHeight, other.smallButtonHeight, t)!,
      mangaCardHeight: lerpDouble(mangaCardHeight, other.mangaCardHeight, t)!,
      mangaCardWidth: lerpDouble(mangaCardWidth, other.mangaCardWidth, t)!,
    );
  }
}
