import 'package:flutter/material.dart';
import 'package:mobile/constants/colors.dart';
import 'package:mobile/constants/font_family.dart';

import 'dimens.dart';

/// Creating custom color palettes is part of creating a custom app. The idea is to create
/// your class of custom colors, in this case `CompanyColors` and then create a `ThemeData`
/// object with those colors you just defined.
///
/// Resource:
/// A good resource would be this website: http://mcg.mbitson.com/
/// You simply need to put in the colour you wish to use, and it will generate all shades
/// for you. Your primary colour will be the `500` value.
///
/// Colour Creation:
/// In order to create the custom colours you need to create a `Map<int, Color>` object
/// which will have all the shade values. `const Color(0xFF...)` will be how you create
/// the colours. The six character hex code is what follows. If you wanted the colour
/// #114488 or #D39090 as primary colours in your theme, then you would have
/// `const Color(0x114488)` and `const Color(0xD39090)`, respectively.
///
/// Usage:
/// In order to use this newly created theme or even the colours in it, you would just
/// `import` this file in your project, anywhere you needed it.
/// `import 'path/to/theme.dart';`

final ThemeData themeData = ThemeData(
  fontFamily: FontFamily.productSans,
  brightness: Brightness.light,
  primarySwatch:
      MaterialColor(AppColors.darkBlue[500]!.value, AppColors.darkBlue),
  primaryColor: AppColors.lightTextTheme,
  highlightColor: AppColors.darkTextTheme,
  selectedRowColor: Colors.yellow.shade600,
  indicatorColor: Colors.black87,
  bottomAppBarColor: Color.alphaBlend(
      AppColors.lightTextTheme.withOpacity(0.7), Colors.black87),
  dividerColor: AppColors.lightTextTheme,
  focusColor: Colors.black87,
  iconTheme: const IconThemeData(color: Colors.black54),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: Colors.black87,
      fontSize: Dimens.medium_text,
    ),
    bodyMedium: TextStyle(
      color: Colors.black87,
      fontSize: Dimens.lightly_medium_text,
    ),
    bodySmall: TextStyle(
      color: Colors.black87,
      fontSize: Dimens.small_text,
    ),
    labelMedium: TextStyle(
      color: AppColors.darkTextTheme,
      fontSize: Dimens.lightly_medium_text,
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black54),
);

final ThemeData themeDataDark = ThemeData(
  fontFamily: FontFamily.productSans,
  brightness: Brightness.dark,
  primaryColor: AppColors.darkTextTheme,
  highlightColor: AppColors.lightTextTheme,
  selectedRowColor: Colors.yellow.shade800,
  indicatorColor: Colors.white70,
  bottomAppBarColor: Color.alphaBlend(
      AppColors.darkTextTheme.withOpacity(0.7), Colors.black87),
  dividerColor: AppColors.darkTextTheme,
  focusColor: Colors.white70,
  iconTheme: const IconThemeData(color: Colors.white70),
  primaryTextTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: Colors.white70,
      fontSize: Dimens.medium_text,
    ),
    bodyMedium: TextStyle(
      color: Colors.white70,
      fontSize: Dimens.lightly_medium_text,
    ),
    bodySmall: TextStyle(
      color: Colors.white70,
      fontSize: Dimens.small_text,
    ),
    labelMedium: TextStyle(
      color: AppColors.lightTextTheme,
      fontSize: Dimens.lightly_medium_text,
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white70),
);
