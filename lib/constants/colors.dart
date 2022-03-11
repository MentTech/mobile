import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // this basically makes it so you can't instantiate this class

  static const Map<int, Color> darkBlue = <int, Color>{
    50: Color(0xFFC6C5E0),
    100: Color(0xFFA6A5C2),
    200: Color(0xFF8E8DA8),
    300: Color(0xFF7A7991),
    400: Color(0xFF65647A),
    500: Color(0xFF535266),
    600: Color(0xFF4A485E),
    700: Color(0xFF3F3D56),
    800: Color(0xFF363352),
    900: Color(0xFF2D2A4F)
  };

  static final Color lightThemeColor = darkBlue[200]!;
  static final Color darkThemeColor = darkBlue[700]!;

  static const Color lightTextTheme = Color(0xFF00BFA6);
  static const Color darkTextTheme = Color(0xFF013D35);

  static final Color firstGradientBackgroundTheme = darkBlue[600]!;
  static const Color secondGradientBackgroundTheme = lightTextTheme;
}
