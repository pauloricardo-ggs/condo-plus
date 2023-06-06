import 'package:condo_plus/controllers/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:condo_plus/components/login/app_gradient_name.dart';
import 'package:condo_plus/components/login/login_button.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _authController = Get.put(AuthController());

  bool _carregando = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/icon/condo-plus-logo.png',
                  scale: 2,
                ),
                AppGradientName(),
                const SizedBox(height: 80),
                buildEmail(colorScheme),
                const SizedBox(height: 10.0),
                buildSenha(colorScheme),
                const SizedBox(height: 30.0),
                buildBotaoEntrar(),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBotaoEntrar() {
    return LoginButton(
      text: 'Entrar',
      isLoading: _carregando,
      onPressed: logar,
    );
  }

  Widget buildSenha(ColorScheme colorScheme) {
    return TextFormField(
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      autocorrect: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.key),
        label: Text('Senha'),
        fillColor: colorScheme.primary,
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      obscureText: true,
      controller: _senhaController,
    );
  }

  Widget buildEmail(ColorScheme colorScheme) {
    return TextFormField(
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      autocorrect: false,
      decoration: InputDecoration(
        prefixIcon: Icon(CupertinoIcons.mail_solid),
        label: Text('Email'),
        fillColor: colorScheme.primary,
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      controller: _emailController,
    );
  }

  void logar() async {
    if (mounted) setState(() => _carregando = true);
    try {
      await _authController.logar(email: _emailController.text, senha: _senhaController.text);
    } catch (e) {
      if (mounted) setState(() => _carregando = false);
    }
  }
}
