import 'package:condo_plus/controllers/auth_controller.dart';
import 'package:condo_plus/pages/avisos_page.dart';
import 'package:condo_plus/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _authController = Get.put(AuthController());
  bool entrar = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        _authController.atualizarUsuarioEPerfil();
        if (snapshot.connectionState == ConnectionState.waiting) return const CircularProgressIndicator();
        if (snapshot.hasData) return const AvisosPage();
        return LoginPage();
      },
    );
  }
}
