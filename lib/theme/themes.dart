import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeData _theme = DefaultValues.themes[3];
  dynamic _appColor = AppColorsDarkGreen();

  get themeMode => _themeMode;
  get selectedTheme => _theme;
  get appColor => _appColor;

  Color textfield_fill = Color.fromRGBO(0, 0, 0, 0.12);
  Color textfield_border = Color.fromRGBO(0, 0, 0, 0.2);
  Color textfield_focused_border = Color.fromRGBO(255, 255, 255, 0.2);
  Color textfield_hint = Color.fromRGBO(255, 255, 255, 0.5);
  Color textfield_disabled_fill = Color.fromRGBO(36, 36, 36, 0.701);
  Color textfield_disabled = Color.fromRGBO(255, 255, 255, 0.5);
  Color login_textfield_border = Color.fromRGBO(0, 0, 0, 0.2);

  alterarTema(ThemeData newTheme, bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _theme = newTheme;

    int index = DefaultValues.themes.indexOf(_theme);
    _appColor = DefaultValues.appColors[index];

    notifyListeners();
  }
}

class DefaultValues {
  static const double horizontalPadding = 15.0;
  static const double borderRadius = 15.0;
  static const double moradorButtonHorizontalPadding = 15.0;
  static const double moradorButtonBorderRadius = 15.0;

  static const String fontFamily = 'SanFrancisco';

  static const int timeToLogin = 1;
  static const int timeLoadAvisos = 1;
  static const int timeToLoadMoradores = 1;
  static const int timeToLoadReservas = 1;

  static List<ThemeData> themes = [PurpleLightTheme, PurpleDarkTheme, GreenLightTheme, GreenDarkTheme];
  static List<dynamic> appColors = [AppColorsLightPurple(), AppColorsDarkPurple(), AppColorsLightGreen(), AppColorsDarkGreen()];
}

// Light Purple
class AppColorsLightPurple {
  static const Color _login_textfield_fill = Color.fromRGBO(0, 0, 0, 0.06);
  static const Color _login_textfield_hint = Color.fromRGBO(0, 0, 0, 0.45);
  static const Color _morador_button = Color.fromRGBO(60, 0, 255, 0.6);
  static const Color _aviso_skeleton_header = Color.fromRGBO(0, 0, 0, 0.07);
  static const Color _skeleton_background = Color.fromRGBO(0, 0, 0, 0.05);
  static const Color _enquete_aprovados = Color.fromRGBO(37, 193, 71, 1);
  static const Color _enquete_reprovados = Color.fromRGBO(151, 0, 0, 1);

  get login_textfield_fill => _login_textfield_fill;
  get login_textfield_hint => _login_textfield_hint;
  get morador_button => _morador_button;
  get aviso_skeleton_header => _aviso_skeleton_header;
  get skeleton_background => _skeleton_background;
  get enquete_aprovados => _enquete_aprovados;
  get enquete_reprovados => _enquete_reprovados;
}

ThemeData PurpleLightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    primary: Color(0xFF6D49E2),
    secondary: Color(0x33FFFFFF),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFF6D49E2)),
      shape: MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(DefaultValues.borderRadius))),
    ),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Color(0xFF6D49E2),
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(style: BorderStyle.solid, color: Color(0xFFD4D4D4)),
      borderRadius: BorderRadius.circular(DefaultValues.borderRadius),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(style: BorderStyle.solid, color: Color(0xFF6D49E2)),
      borderRadius: BorderRadius.circular(DefaultValues.borderRadius),
    ),
    hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
    fillColor: Color(0xFF000000).withOpacity(0.35),
    filled: true,
  ),
  appBarTheme: AppBarTheme(
    elevation: 4,
    backgroundColor: Color(0xFF6D49E2),
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontFamily: DefaultValues.fontFamily,
      fontSize: 22,
    ),
  ),
);

// Dark Purple
class AppColorsDarkPurple {
  static const Color _login_textfield_fill = Color.fromRGBO(0, 0, 0, 0.14);
  static const Color _login_textfield_hint = Color.fromRGBO(255, 255, 255, 0.25);
  static const Color _morador_button = Color.fromRGBO(37, 0, 100, 1);
  static const Color _aviso_skeleton_header = Color.fromRGBO(255, 255, 255, 0.1);
  static const Color _skeleton_background = Color.fromRGBO(255, 255, 255, 0.04);
  static const Color _enquete_aprovados = Colors.green;
  static const Color _enquete_reprovados = Color.fromRGBO(255, 0, 0, 1);

  get login_textfield_fill => _login_textfield_fill;
  get login_textfield_hint => _login_textfield_hint;
  get morador_button => _morador_button;
  get aviso_skeleton_header => _aviso_skeleton_header;
  get skeleton_background => _skeleton_background;
  get enquete_aprovados => _enquete_aprovados;
  get enquete_reprovados => _enquete_reprovados;
}

ThemeData PurpleDarkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Color(0xFF250064),
    secondary: Color(0x25FFFFFF),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFF250064)),
      shape: MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(DefaultValues.borderRadius))),
    ),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Color(0xFF250064),
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(style: BorderStyle.solid, color: Color(0xFF6A6A6A)),
      borderRadius: BorderRadius.circular(DefaultValues.borderRadius),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(style: BorderStyle.solid, color: Color(0xFF250064)),
      borderRadius: BorderRadius.circular(DefaultValues.borderRadius),
    ),
    hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
    fillColor: Color(0xFF434343),
    filled: true,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF250064),
    centerTitle: true,
  ),
);

// Light Green
class AppColorsLightGreen {
  static const Color _login_textfield_fill = Color.fromRGBO(0, 0, 0, 0.06);
  static const Color _login_textfield_hint = Color.fromRGBO(0, 0, 0, 0.45);
  static const Color _morador_button = Color.fromRGBO(0, 147, 32, 0.9);
  static const Color _aviso_skeleton_header = Color.fromRGBO(0, 0, 0, 0.07);
  static const Color _skeleton_background = Color.fromRGBO(0, 0, 0, 0.05);
  static const Color _enquete_aprovados = Color.fromRGBO(53, 255, 97, 1);
  static const Color _enquete_reprovados = Color.fromRGBO(182, 0, 0, 1);

  get login_textfield_fill => _login_textfield_fill;
  get login_textfield_hint => _login_textfield_hint;
  get morador_button => _morador_button;
  get aviso_skeleton_header => _aviso_skeleton_header;
  get skeleton_background => _skeleton_background;
  get enquete_aprovados => _enquete_aprovados;
  get enquete_reprovados => _enquete_reprovados;
}

ThemeData GreenLightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    primary: Color.fromRGBO(0, 147, 32, 1),
    secondary: Color.fromARGB(67, 255, 255, 255),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFF009320)),
      shape: MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(DefaultValues.borderRadius))),
    ),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Color(0xFF009320),
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(style: BorderStyle.solid, color: Color(0xFFD4D4D4)),
      borderRadius: BorderRadius.circular(DefaultValues.borderRadius),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(style: BorderStyle.solid, color: Color(0xFF009320)),
      borderRadius: BorderRadius.circular(DefaultValues.borderRadius),
    ),
    hintStyle: TextStyle(color: Color.fromARGB(255, 171, 170, 170)),
    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
    fillColor: Colors.black.withOpacity(0.35),
    filled: true,
  ),
  appBarTheme: AppBarTheme(
    elevation: 4,
    backgroundColor: Color(0xFF009320),
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontFamily: DefaultValues.fontFamily,
      fontSize: 22,
    ),
  ),
);

// Dark Green
class AppColorsDarkGreen {
  static const Color _login_textfield_fill = Color.fromRGBO(0, 0, 0, 0.06);
  static const Color _login_textfield_hint = Color.fromRGBO(0, 0, 0, 0.45);
  static const Color _morador_button = Color.fromRGBO(0, 89, 19, 0.9);
  static const Color _aviso_skeleton_header = Color.fromRGBO(0, 0, 0, 0.07);
  static const Color _skeleton_background = Color.fromRGBO(0, 0, 0, 0.05);
  static const Color _enquete_aprovados = Color.fromARGB(255, 86, 201, 90);
  static const Color _enquete_reprovados = Color.fromRGBO(108, 0, 0, 1);

  get login_textfield_fill => _login_textfield_fill;
  get login_textfield_hint => _login_textfield_hint;
  get morador_button => _morador_button;
  get aviso_skeleton_header => _aviso_skeleton_header;
  get skeleton_background => _skeleton_background;
  get enquete_aprovados => _enquete_aprovados;
  get enquete_reprovados => _enquete_reprovados;
}

ThemeData GreenDarkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Color(0xFF005913),
    secondary: Color(0x25FFFFFF),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFF005913)),
      shape: MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(DefaultValues.borderRadius))),
    ),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Color(0xFF005913),
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(style: BorderStyle.solid, color: Color(0xFF6A6A6A)),
      borderRadius: BorderRadius.circular(DefaultValues.borderRadius),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(style: BorderStyle.solid, color: Color(0xFF005913)),
      borderRadius: BorderRadius.circular(DefaultValues.borderRadius),
    ),
    hintStyle: TextStyle(color: Color.fromARGB(255, 171, 170, 170)),
    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
    fillColor: Colors.black.withOpacity(0.35),
    filled: true,
  ),
  appBarTheme: AppBarTheme(
    elevation: 4,
    backgroundColor: Color(0xFF005913),
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontFamily: DefaultValues.fontFamily,
      fontSize: 22,
    ),
  ),
);
