import 'dart:ui';

import 'package:condo_plus/components/date_text_field_component.dart';
import 'package:condo_plus/components/load_button.dart';
import 'package:condo_plus/components/text_field_component.dart';
import 'package:condo_plus/components/text_form_field_component.dart';
import 'package:condo_plus/configuracoes.dart';
import 'package:condo_plus/models/apartamento.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_rect_tween.dart';
import 'hero_dialog_route.dart';

class AddMoradorButton extends StatelessWidget {
  final Apartamento apartamento;

  const AddMoradorButton({
    Key? key,
    required this.apartamento,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(HeroDialogRoute(builder: (context) {
          return _AddMoradorPopupCard(apartamento: apartamento);
        }));
      },
      child: Hero(
        tag: 'add-morador-hero',
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        child: Material(
          color: main_color,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: const Icon(
              CupertinoIcons.person_add_solid,
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _AddMoradorPopupCard extends StatefulWidget {
  final Apartamento apartamento;

  const _AddMoradorPopupCard({Key? key, required this.apartamento}) : super(key: key);

  @override
  State<_AddMoradorPopupCard> createState() => _AddMoradorPopupCardState();
}

class _AddMoradorPopupCardState extends State<_AddMoradorPopupCard> {
  final double bottomPadding = 10;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 3.0,
            sigmaY: 3.0,
          ),
          child: const SizedBox.expand(),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Hero(
              tag: 'add-morador-hero',
              createRectTween: (begin, end) {
                return CustomRectTween(begin: begin!, end: end!);
              },
              child: Material(
                color: avatar_background_color_light,
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultBorderRadius)),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _UploadFoto(padding_bottom: 15, padding_top: 20),
                      TextFieldComponent(hint: "nome Completo", bottomPadding: bottomPadding),
                      TextFieldComponent(hint: "cpf", bottomPadding: bottomPadding),
                      TextFieldComponent(hint: "email", bottomPadding: bottomPadding),
                      TextFieldComponent(hint: "telefone", bottomPadding: bottomPadding),
                      TextFormFieldComponent(initialValue: widget.apartamento.bloco, enabled: false, bottomPadding: bottomPadding),
                      TextFormFieldComponent(initialValue: widget.apartamento.numApto, enabled: false, bottomPadding: bottomPadding),
                      DateTextFieldComponent(hint: "data de Nascimento", bottomPadding: 20),
                      LoadButton(text: 'Cadastrar', isLoading: isLoading, bottomPadding: 20, onPressed: cadastrar, width: 150),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void cadastrar() async {
    setState(() => isLoading = true);
    await Future.delayed(Duration(seconds: 2));
    setState(() => isLoading = false);
  }
}

class _UploadFoto extends StatelessWidget {
  final double padding_bottom;
  final double padding_top;

  const _UploadFoto({Key? key, this.padding_bottom = 0, this.padding_top = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: padding_bottom, top: padding_top),
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
