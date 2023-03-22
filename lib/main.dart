import 'package:condo_plus/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonTheme(
      themeMode: ThemeMode.light,
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
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: const LoginPage(),
      ),
    );
  }
}
