import 'package:condo_plus/firebase_options.dart';
import 'package:condo_plus/pages/login_page.dart';
import 'package:condo_plus/theme/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'condo-plus',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

ThemeManager themeManager = new ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    themeManager.addListener(themeListener);
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeManager.selectedTheme,
        themeMode: themeManager.themeMode,
        home: const LoginPage(),
      ),
    );
  }
}
