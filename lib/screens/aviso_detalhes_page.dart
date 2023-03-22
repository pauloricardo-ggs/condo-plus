// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:condo_plus/components/google_font_text.dart';
import 'package:condo_plus/devpack.dart';
import 'package:flutter/material.dart';

import 'package:condo_plus/configuracoes.dart';
import 'package:condo_plus/models/aviso.dart';

class AvisoDetalhesPage extends StatelessWidget {
  final Aviso aviso;

  const AvisoDetalhesPage({
    Key? key,
    required this.aviso,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color_light,
      appBar: AppBar(
        title: GoogleFontText(texto: aviso.titulo, color: Colors.white),
        centerTitle: true,
        backgroundColor: main_color,
        leading: BackButton(onPressed: () => Navigator.pop(context)),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: aviso.imagem,
                    fit: BoxFit.cover,
                    alignment: FractionalOffset.center,
                  ),
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: GoogleFontText(texto: formatarParaDoisNomes(aviso.funcionario.nome) + ", " + aviso.funcionario.cargo, fontSize: 16), flex: 3),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Align(child: GoogleFontText(texto: aviso.dataHora, fontSize: 16), alignment: Alignment.centerRight),
                  ),
                ],
              ),
              SizedBox(height: 20),
              GoogleFontText(
                texto: aviso.descricao,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 45),
            ],
          ),
        ),
      ),
    );
  }
}
