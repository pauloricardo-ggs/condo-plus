import 'package:condo_plus/firebase_options.dart';
import 'package:condo_plus/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'condo',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SkeletonTheme(
      shimmerGradient: LinearGradient(
        colors: [Color(0xFFBECDD3), Color(0xFFC8D5DA), Color(0xFFBECDD3)],
        stops: [0.1, 0.3, 0.9],
      ),
      darkShimmerGradient: LinearGradient(
        colors: [
          Color(0xFF222222).withOpacity(0.98),
          Color(0xFF242424).withOpacity(0.98),
          Color(0xFF2B2B2B).withOpacity(0.98),
          Color(0xFF242424).withOpacity(0.98),
          Color(0xFF222222).withOpacity(0.98),
        ],
        stops: [0.0, 0.2, 0.5, 0.8, 1],
        begin: Alignment(-2.4, -0.2),
        end: Alignment(2.4, 0.2),
        tileMode: TileMode.clamp,
      ),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Condo+',
        darkTheme: _darkColorTheme(context),
        theme: _lightColorTheme(context),
        themeMode: ThemeMode.system,
        home: const AuthPage(),
      ),
    );
  }

  ThemeData _lightColorTheme(BuildContext context) {
    var primary = Colors.deepPurpleAccent.shade200;
    var secondary = Colors.deepPurpleAccent.shade700;

    return ThemeData(
      fontFamily: "SFPro",
      colorScheme: Theme.of(context).colorScheme.copyWith(
            brightness: Brightness.light,
            primary: primary,
            secondary: secondary,
            onBackground: Colors.black,
            onSurface: Colors.white,
            onSecondary: Colors.white,
          ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: secondary,
        labelStyle: TextStyle(color: Colors.white70),
        prefixIconColor: Colors.white70,
        errorStyle: TextStyle(color: Colors.white),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Colors.white60),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: const Color.fromARGB(255, 255, 17, 0)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Colors.red.shade200),
        ),
      ),
      buttonTheme: const ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }

  ThemeData _darkColorTheme(BuildContext context) {
    var primary = Colors.deepPurpleAccent.shade700;
    var secondary = Colors.deepPurpleAccent.shade200;

    return ThemeData(
      fontFamily: "SFPro",
      scaffoldBackgroundColor: Colors.black,
      colorScheme: Theme.of(context).colorScheme.copyWith(
            brightness: Brightness.dark,
            primary: primary,
            secondary: secondary,
            onBackground: Colors.white,
          ),
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) return Colors.grey;
              return primary;
            },
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: secondary,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: primary),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Color.fromARGB(78, 255, 0, 0)),
        ),
      ),
    );
  }
}
