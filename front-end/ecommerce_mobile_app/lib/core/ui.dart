import 'package:flutter/material.dart';

class AppColors {
  static Color accent = const Color.fromARGB(255, 218, 159, 159);
  static Color white = const Color(0xffffffff);
  static Color text = const Color.fromARGB(255, 41, 41, 41);
  static Color textLight = const Color.fromARGB(255, 88, 88, 88);
}

class Themes {
  static ThemeData defaultTheme = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.accent,
        iconTheme: IconThemeData(
          color: AppColors.text,
        ),
        titleTextStyle: TextStyle(
          color: AppColors.text,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
      colorScheme: ColorScheme.light(
        primary: AppColors.accent,
        secondary: AppColors.accent,
      ));
}

class TextStyles {
  static TextStyle heading1 = TextStyle(
    fontSize: 38,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  );

  static TextStyle heading2 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  );

  static TextStyle heading3 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  );

  static TextStyle body1 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.text,
  );

  static TextStyle body2 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.text,
  );
}
