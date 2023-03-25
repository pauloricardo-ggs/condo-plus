import 'package:condo_plus/devpack.dart';
import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/material.dart';

import 'package:condo_plus/models/aviso.dart';

class AvisoDetalhesPage extends StatelessWidget {
  final Aviso aviso;

  const AvisoDetalhesPage({required this.aviso});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(aviso.titulo),
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
                  border: Border.all(color: colorScheme.primary),
                  image: DecorationImage(
                    image: aviso.imagem,
                    fit: BoxFit.cover,
                    alignment: FractionalOffset.center,
                  ),
                  borderRadius: BorderRadius.circular(DefaultValues.borderRadius),
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      formatarParaDoisNomes(aviso.funcionario.nome) + ", " + aviso.funcionario.cargo,
                      style: TextStyle(fontSize: 16, fontFamily: DefaultValues.fontFamily),
                    ),
                    flex: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Align(
                      child: Text(
                        aviso.dataHora,
                        style: TextStyle(fontSize: 16, fontFamily: DefaultValues.fontFamily),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                aviso.descricao,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, fontFamily: DefaultValues.fontFamily),
              ),
              SizedBox(height: 45),
            ],
          ),
        ),
      ),
    );
  }
}
