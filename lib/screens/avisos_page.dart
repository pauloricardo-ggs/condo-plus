// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:condo_plus/components/google_font_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skeletons/skeletons.dart';

import 'package:condo_plus/components/blurry_container_component.dart';
import 'package:condo_plus/components/drawer_component.dart';
import 'package:condo_plus/configuracoes.dart';
import 'package:condo_plus/models/aviso.dart';
import 'package:condo_plus/screens/aviso_detalhes_page.dart';

class AvisosPage extends StatefulWidget {
  final dynamic usuarioLogado;

  const AvisosPage({
    Key? key,
    required this.usuarioLogado,
  }) : super(key: key);

  @override
  State<AvisosPage> createState() => _AvisosPageState();
}

class _AvisosPageState extends State<AvisosPage> {
  List<dynamic> avisos = [];
  late bool _carregandoAvisos;

  @override
  void initState() {
    _carregandoAvisos = true;
    obterAvisos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color_light,
      appBar: AppBar(
        backgroundColor: main_color,
        title: GoogleFontText(texto: "Avisos", color: Colors.white),
        centerTitle: true,
      ),
      drawer: DrawerComponent(usuarioLogado: widget.usuarioLogado, selectedIndex: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(children: [_carregandoAvisos ? listaAvisosSkelton() : listaAvisos()]),
      ),
    );
  }

  Widget aviso(Aviso aviso) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultBorderRadius)),
      ),
      child: Stack(
        children: [
          // Imagem
          Stack(
            children: [
              SkeletonLine(style: SkeletonLineStyle(height: 250, borderRadius: BorderRadius.circular(defaultBorderRadius))),
              Container(
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: main_color),
                  image: DecorationImage(
                    image: aviso.imagem,
                    fit: BoxFit.cover,
                    alignment: FractionalOffset.center,
                  ),
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                ),
              ),
            ],
          ),

          // Header
          Container(
            decoration: BoxDecoration(border: Border.all(color: main_color), borderRadius: BorderRadius.vertical(top: Radius.circular(defaultBorderRadius))),
            child: BlurryContainerComponent(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: defaultPadding),
              borderRadius: const BorderRadiusDirectional.vertical(top: Radius.circular(defaultBorderRadius)),
              color: main_color.withOpacity(1),
              blur: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GoogleFontText(texto: aviso.titulo, fontSize: 20, color: Colors.white),
                  SizedBox(height: 8),
                  GoogleFontText(texto: aviso.dataHora, fontSize: 13, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AvisoDetalhesPage(aviso: aviso)));
      },
    );
  }

  Widget avisoSkelton() {
    return Stack(
      children: [
        SkeletonLine(
          style: SkeletonLineStyle(
            height: 250,
            borderRadius: BorderRadius.circular(defaultBorderRadius),
          ),
        ),
        Container(
          height: 250,
          decoration: BoxDecoration(
            color: box_background_color.withOpacity(0.09),
            borderRadius: BorderRadius.circular(defaultBorderRadius),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: box_background_color.withOpacity(0.56),
            borderRadius: BorderRadius.circular(defaultBorderRadius),
          ),
          child: BlurryContainerComponent(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            height: 75,
            borderRadius: BorderRadiusDirectional.vertical(top: Radius.circular(12.0)),
            child: Column(
              children: [
                Spacer(flex: 2),
                Expanded(
                    child: SkeletonLine(
                      style: SkeletonLineStyle(
                        borderRadius: BorderRadius.circular(defaultBorderRadius),
                        randomLength: true,
                        minLength: 120,
                      ),
                    ),
                    flex: 3),
                Spacer(flex: 2),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        child: SkeletonLine(
                          style: SkeletonLineStyle(
                            borderRadius: BorderRadius.circular(defaultBorderRadius),
                            randomLength: true,
                            minLength: 150,
                          ),
                        ),
                        flex: 5,
                      ),
                      Spacer(flex: 1),
                      Expanded(
                        child: SkeletonLine(
                          style: SkeletonLineStyle(
                            borderRadius: BorderRadius.circular(defaultBorderRadius),
                          ),
                        ),
                        flex: 3,
                      ),
                    ],
                  ),
                ),
                Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget listaAvisos() {
    return Expanded(
      child: ListView.separated(
        itemCount: avisos.length,
        itemBuilder: (context, index) => aviso(avisos[index]),
        separatorBuilder: (context, index) => const SizedBox(height: defaultPadding),
        padding: EdgeInsets.symmetric(vertical: defaultPadding),
      ),
    );
  }

  Widget listaAvisosSkelton() {
    return Expanded(
      child: ListView.separated(
        itemCount: 4,
        itemBuilder: (context, index) => avisoSkelton(),
        separatorBuilder: (context, index) => const SizedBox(height: defaultPadding),
        padding: EdgeInsets.symmetric(vertical: defaultPadding),
      ),
    );
  }

  Future<void> obterAvisos() async {
    final String response = await rootBundle.loadString('json/avisos.json');
    final data = await json.decode(response);
    await Future.delayed(Duration(seconds: tempoParaCarregarAvisos));

    setState(() {
      avisos = data['avisos'].map((data) => Aviso.fromJson(data)).toList();
      _carregandoAvisos = false;
    });
  }
}
