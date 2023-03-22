// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:condo_plus/components/date_text_field_component.dart';
import 'package:condo_plus/components/google_font_text.dart';
import 'package:condo_plus/components/text_field_component.dart';
import 'package:condo_plus/components/text_form_field_component.dart';
import 'package:condo_plus/configuracoes.dart';
import 'package:condo_plus/models/apartamento.dart';

class CadastroMoradorPage extends StatelessWidget {
  final Apartamento apartamento;
  final double padding_bottom = 10;

  const CadastroMoradorPage({
    Key? key,
    required this.apartamento,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color_light,
      appBar: AppBar(
        title: GoogleFontText(texto: "Cadastro de Morador", color: Colors.white),
        centerTitle: true,
        leading: BackButton(onPressed: () => Navigator.pop(context)),
        backgroundColor: main_color,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            UploadFoto(padding_bottom: 30),
            TextFieldComponent(hint: "nome Completo", padding_bottom: padding_bottom),
            TextFieldComponent(hint: "cpf", padding_bottom: padding_bottom),
            TextFieldComponent(hint: "email", padding_bottom: padding_bottom),
            TextFieldComponent(hint: "telefone", padding_bottom: padding_bottom),
            TextFormFieldComponent(initialValue: apartamento.bloco, enabled: false, padding_bottom: padding_bottom),
            TextFormFieldComponent(initialValue: apartamento.numApto, enabled: false, padding_bottom: padding_bottom),
            DateTextFieldComponent(hint: "data de Nascimento", padding_bottom: 20),
            BotaoCadastrar(padding_bottom: 40),
          ],
        ),
      ),
    );
  }
}

class BotaoCadastrar extends StatelessWidget {
  final double padding_bottom;
  final bool isLoading;

  const BotaoCadastrar({
    Key? key,
    this.padding_bottom = 0,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: defaultPadding, right: defaultPadding, bottom: padding_bottom),
      child: ElevatedButton(
        child: isLoading
            ? SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: main_color,
                  strokeWidth: 5,
                ),
              )
            : GoogleFontText(texto: 'Cadastrar', color: Colors.white, fontSize: 20),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(55),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultBorderRadius)),
          backgroundColor: main_color,
          disabledBackgroundColor: background_color_light,
          enableFeedback: false,
          foregroundColor: background_color_light,
        ),
        onPressed: () => isLoading ? null : print,
      ),
    );
  }
}

class UploadFoto extends StatelessWidget {
  final double padding_bottom;

  const UploadFoto({
    Key? key,
    this.padding_bottom = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: padding_bottom),
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          color: box_background_color,
          shape: BoxShape.circle,
          border: Border.all(color: border_box_color_light),
        ),
        child: IconButton(
          iconSize: 50,
          onPressed: () => print,
          icon: Icon(
            Icons.add_a_photo_outlined,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
