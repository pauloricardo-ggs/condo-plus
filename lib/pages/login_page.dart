import 'dart:convert';

import 'package:condo_plus/models/funcionario.dart';
import 'package:condo_plus/models/morador.dart';
import 'package:condo_plus/pages/avisos_page.dart';
import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/material.dart';

import 'package:condo_plus/components/login/app_gradient_name.dart';
import 'package:condo_plus/components/login/login_button.dart';
import 'package:condo_plus/components/login/login_text_field.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  dynamic _loggedUser;
  bool _isLoading = false;

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
              LoginTextField(hint: "email", controller: emailController),

              SizedBox(height: 10.0),

              // password textfield
              LoginTextField(hint: "senha", obscureText: true, controller: passwordController),

              SizedBox(height: 30.0),

              // login button
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: LoginButton(text: 'Entrar', isLoading: _isLoading, onPressed: login),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    setState(() => _isLoading = true);

    final String response = await rootBundle.loadString('json/usuarioLogado.json');
    await Future.delayed(Duration(seconds: DefaultValues.timeToLogin));
    final data = await json.decode(response);

    setState(() {
      _loggedUser = data['usuario']['cargo'] == 'administracao' ? Funcionario.fromJson(data['usuario']) : Morador.fromJson(data['usuario']);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AvisosPage(loggedUser: _loggedUser)));
      _isLoading = false;
    });
  }
}
