import 'package:flutter/material.dart';

class AppColors {
  // Cores padrao
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color blue = Colors.blue;
  static const Color transparent = Colors.transparent;

  // Cores gerais
  static const Color cursor = Color.fromARGB(255, 117, 75, 255);
  static const Color textfield_fill = Color.fromRGBO(0, 0, 0, 0.12);
  static const Color textfield_border = Color.fromRGBO(0, 0, 0, 0.2);
  static const Color textfield_focused_border = Color.fromRGBO(255, 255, 255, 0.2);
  static const Color textfield_hint = Color.fromRGBO(255, 255, 255, 0.5);
  static const Color textfield_disabled_fill = Color.fromRGBO(36, 36, 36, 0.701);
  static const Color textfield_disabled = Color.fromRGBO(255, 255, 255, 0.5);
  static const Color login_textfield_border = Color.fromRGBO(0, 0, 0, 0.2);

  // Cores tema claro
  static const Color light_primary = Color.fromRGBO(109, 73, 226, 1);
  static const Color light_secondary = Color.fromRGBO(255, 255, 255, 0.2);
  static const Color light_login_textfield_fill = Color.fromRGBO(0, 0, 0, 0.06);
  static const Color light_login_textfield_hint = Color.fromRGBO(0, 0, 0, 0.45);
  static const Color light_aviso_skeleton_header = Color.fromRGBO(0, 0, 0, 0.07);
  static const Color light_morador_button = Color.fromRGBO(60, 0, 255, 0.6);

  // Cores tema escuro
  static const Color dark_primary = Color.fromRGBO(37, 0, 100, 1);
  static const Color dark_secondary = Color.fromRGBO(255, 255, 255, 0.15);
  static const Color dark_login_textfield_fill = Color.fromRGBO(0, 0, 0, 0.14);
  static const Color dark_login_textfield_hint = Color.fromRGBO(255, 255, 255, 0.25);
  static const Color dark_aviso_skeleton_header = Color.fromRGBO(255, 255, 255, 0.1);
  static const Color dark_morador_button = Color.fromRGBO(37, 0, 100, 1);
}

class DefaultValues {
  static const double horizontalPadding = 15.0;
  static const double borderRadius = 15.0;
  static const double moradorButtonHorizontalPadding = 32.0;
  static const double moradorButtonBorderRadius = 15.0;

  static const String fontFamily = 'SanFrancisco';

  static const int timeToLogin = 2;
  static const int timeLoadAvisos = 2;
  static const int timeToLoadMoradores = 2;
}

ThemeData LightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color.fromARGB(255, 0, 0, 0),
  colorScheme: ColorScheme.light(
    primary: AppColors.light_primary,
    secondary: AppColors.light_secondary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll<Color>(AppColors.light_primary),
      shape: MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(DefaultValues.borderRadius))),
    ),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppColors.light_primary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(style: BorderStyle.solid, color: Color.fromARGB(255, 212, 212, 212)),
      borderRadius: BorderRadius.circular(DefaultValues.borderRadius),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(style: BorderStyle.solid, color: AppColors.light_primary),
      borderRadius: BorderRadius.circular(DefaultValues.borderRadius),
    ),
    hintStyle: TextStyle(color: Colors.grey),
    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
    fillColor: Colors.black.withOpacity(0.35),
    filled: true,
  ),
  appBarTheme: AppBarTheme(
    elevation: 4,
    backgroundColor: AppColors.light_primary,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontFamily: DefaultValues.fontFamily,
      fontSize: 22,
    ),
  ),
);

ThemeData DarkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.dark_primary,
  colorScheme: ColorScheme.dark(
    primary: AppColors.dark_primary,
    secondary: AppColors.dark_secondary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll<Color>(AppColors.dark_primary),
      shape: MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(DefaultValues.borderRadius))),
    ),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppColors.dark_primary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(style: BorderStyle.solid, color: Color.fromARGB(255, 106, 106, 106)),
      borderRadius: BorderRadius.circular(DefaultValues.borderRadius),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(style: BorderStyle.solid, color: AppColors.dark_primary),
      borderRadius: BorderRadius.circular(DefaultValues.borderRadius),
    ),
    hintStyle: TextStyle(color: Colors.grey),
    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
    fillColor: Color.fromARGB(255, 67, 67, 67),
    filled: true,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.dark_primary,
    centerTitle: true,
  ),
);
