import 'package:condo_plus/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

import 'package:condo_plus/components/login/app_gradient_name.dart';
import 'package:condo_plus/components/login/login_button.dart';
import 'package:condo_plus/components/login/login_text_field.dart';
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
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Image.asset(
                'assets/images/icon/condo-plus-logo.png',
                scale: 2,
              ),

              // app name
              AppGradientName(),

              SizedBox(height: 80),

              // email textfield
              LoginTextField(hint: "email", controller: _emailController),

              SizedBox(height: 10.0),

              // password textfield
              LoginTextField(hint: "senha", obscureText: true, controller: _senhaController),

              SizedBox(height: 30.0),

              // login button
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: LoginButton(
                  text: 'Entrar',
                  isLoading: _carregando,
                  onPressed: logar,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void logar() async {
    setState(() {
      _carregando = true;
    });
    try {
      await _authController.logar(email: _emailController.text, senha: _senhaController.text);
    } catch (e) {
      setState(() {
        _carregando = false;
      });
    }
  }
}
