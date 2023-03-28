import 'dart:convert';

import 'package:condo_plus/components/geral/loader_button.dart';
import 'package:condo_plus/components/login/login_text_field.dart';
import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:condo_plus/models/funcionario.dart';
import 'package:condo_plus/models/morador.dart';

import 'avisos_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              Image.asset(
                'assets/images/icon/condo-plus-logo.png',
                scale: 2,
              ),
              ShaderMask(
                blendMode: BlendMode.srcATop,
                shaderCallback: (bounds) => LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [Color.fromRGBO(0, 98, 255, 1), Color.fromRGBO(201, 0, 255, 1)],
                ).createShader(bounds),
                child: Text(
                  'condo+',
                  style: TextStyle(fontSize: 54, fontFamily: 'Comfortaa'),
                ),
              ),
              SizedBox(height: 80),
              LoginTextField(hint: "cpf", horizontalPadding: 30.0, bottomPadding: 10.0),
              LoginTextField(hint: "senha", obscureText: true, horizontalPadding: 30.0, bottomPadding: 30.0),
              LoaderButton(text: 'Entrar', width: 120, isLoading: _isLoading, onPressed: login),
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
