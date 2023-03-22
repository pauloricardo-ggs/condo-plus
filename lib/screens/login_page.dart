import 'dart:convert';

import 'package:condo_plus/components/google_font_text.dart';
import 'package:condo_plus/components/gradient_text.dart';
import 'package:condo_plus/models/funcionario.dart';
import 'package:condo_plus/models/morador.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:condo_plus/configuracoes.dart';
import 'package:condo_plus/components/text_field_component.dart';

import 'avisos_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  dynamic usuarioLogado;
  bool logando = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color_light,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/icon/condo-plus-logo.png', scale: 3),
          GradientText(
            text: 'condo+',
            fontSize: 54,
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color.fromRGBO(89, 148, 241, 1), Color(0xFF70016A)],
            ),
          ),
          SizedBox(height: 50),
          TextFieldComponent(hint: "cpf", padding_horizontal: 40, padding_bottom: 10),
          TextFieldComponent(hint: "senha", obscureText: true, padding_horizontal: 40, padding_bottom: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: SizedBox(width: 120, child: botaoEntrar()),
          ),
        ],
      ),
    );
  }

  Widget botaoEntrar() {
    return ElevatedButton(
      child: logando
          ? SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                color: main_color,
                strokeWidth: 5,
              ),
            )
          : GoogleFontText(texto: 'Entrar', color: Colors.white, fontSize: 20),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultBorderRadius)),
        backgroundColor: main_color,
        disabledBackgroundColor: background_color_light,
        enableFeedback: false,
        foregroundColor: background_color_light,
      ),
      onPressed: logando ? null : logar,
    );
  }

  void logar() async {
    setState(() {
      logando = true;
    });

    final String response = await rootBundle.loadString('json/usuarioLogado.json');
    await Future.delayed(Duration(seconds: tempoParaLogar));
    final data = await json.decode(response);

    setState(() {
      data['usuario']['cargo'] == cargoAdministracao ? usuarioLogado = Funcionario.fromJson(data['usuario']) : usuarioLogado = Morador.fromJson(data['usuario']);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AvisosPage(usuarioLogado: usuarioLogado)));
      logando = false;
    });
  }
}
