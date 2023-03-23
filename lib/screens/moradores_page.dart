import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:condo_plus/components/custom_drawer.dart';
import 'package:condo_plus/components/google_font_text.dart';
import 'package:condo_plus/components/popup/add_morador_button.dart';
import 'package:condo_plus/components/popup/custom_rect_tween.dart';
import 'package:condo_plus/components/popup/hero_dialog_route.dart';
import 'package:condo_plus/devPack.dart';
import 'package:condo_plus/models/apartamento.dart';
import 'package:condo_plus/models/morador.dart';
import 'package:flutter/material.dart';
import 'package:condo_plus/configuracoes.dart';
import 'package:flutter/services.dart';
import 'package:skeletons/skeletons.dart';

class MoradoresPage extends StatefulWidget {
  final dynamic usuarioLogado;
  final Color buttonColor = avatar_background_color_light;
  final Color textColor = Colors.white;

  const MoradoresPage({
    Key? key,
    this.usuarioLogado,
  }) : super(key: key);

  @override
  State<MoradoresPage> createState() => _MoradoresPageState();
}

class _MoradoresPageState extends State<MoradoresPage> {
  final List<String> blocos = ['Alpha', 'Beta', 'Gama'];
  final List<String> numerosApartamentos = ['101', '102', '103', '104', '201', '202', '203', '204', '301', '302', '303', '304', '1204'];

  List<dynamic> moradores = [];
  late String _aptoSelecionado;
  late String _blocoSelecionado;
  late bool _carregandoMoradores;

  @override
  void initState() {
    _aptoSelecionado = numerosApartamentos.first;
    _blocoSelecionado = blocos.first;
    obterMoradores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color_light,
      appBar: AppBar(
        backgroundColor: main_color,
        title: const GoogleFontText(texto: 'Moradores', color: Colors.white),
        centerTitle: true,
      ),
      drawer: CustomDrawer(usuarioLogado: widget.usuarioLogado, selectedIndex: 3),
      body: Padding(
        padding: const EdgeInsets.only(top: defaultPadding, left: defaultPadding, right: defaultPadding),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: defaultPadding),
                    child: _DropdownButton(
                      listaDeItens: blocos,
                      itemSelecionado: _blocoSelecionado,
                      onChanged: (novoBlocoSelecionado) {
                        setState(() => _blocoSelecionado = novoBlocoSelecionado);
                        obterMoradores();
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: defaultPadding),
                    child: _DropdownButton(
                      listaDeItens: numerosApartamentos,
                      itemSelecionado: _aptoSelecionado,
                      onChanged: (novoAptoSelecionado) {
                        setState(() => _aptoSelecionado = novoAptoSelecionado);
                        obterMoradores();
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            _carregandoMoradores ? _MoradorButtonSkeletonList() : _MoradorButtonList(moradores: moradores),
          ],
        ),
      ),
      floatingActionButton: AddMoradorButton(apartamento: Apartamento(bloco: _blocoSelecionado, numApto: _aptoSelecionado)),
    );
  }

  void obterMoradores() async {
    setState(() => _carregandoMoradores = true);

    var caminho = 'json/moradores' + _blocoSelecionado + _aptoSelecionado + '.json';
    try {
      final String response = await rootBundle.loadString(caminho);
      final data = await json.decode(response);
      setState(() => moradores = data['moradores'].map((data) => Morador.fromJson(data)).toList());
    } catch (exception) {
      moradores = [];
    }
    await Future.delayed(Duration(seconds: tempoParaCarregarMoradores));
    setState(() => _carregandoMoradores = false);
  }
}

class _DropdownButton extends StatelessWidget {
  final List<String> listaDeItens;
  final String itemSelecionado;
  final Function(String novoItemSelecionado) onChanged;

  const _DropdownButton({
    required this.listaDeItens,
    required this.itemSelecionado,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      iconSize: 15,
      elevation: 1,
      isExpanded: true,
      menuMaxHeight: 400,
      value: itemSelecionado,
      borderRadius: BorderRadius.circular(defaultBorderRadius),
      dropdownColor: background_color_light.withOpacity(0.9),
      underline: Container(height: 2, color: main_color),
      icon: Transform.rotate(
        angle: -90 * pi / 180,
        child: Icon(Icons.arrow_back_ios_new, color: text_color_light),
      ),
      onChanged: (String? novoItemSelecionado) async {
        onChanged(novoItemSelecionado!);
      },
      items: listaDeItens.map<DropdownMenuItem<String>>((String item) => DropdownMenuItem<String>(value: item, child: GoogleFontText(texto: item, fontSize: 18))).toList(),
    );
  }
}

class _MoradorButtonList extends StatelessWidget {
  final List<dynamic> moradores;

  const _MoradorButtonList({required this.moradores});

  @override
  Widget build(BuildContext context) {
    return moradores.isEmpty
        ? Column(
            children: [
              SizedBox(height: 60),
              Text('Esse apartamento está vazio.\nCadastre moradores para ele.', style: TextStyle(color: text_color_light, fontSize: 20)),
            ],
          )
        : Expanded(
            child: ListView.separated(
              itemCount: moradores.length,
              itemBuilder: (context, index) => _MoradorButton(morador: moradores[index], index: index),
              separatorBuilder: (context, index) => const SizedBox(height: 8),
            ),
          );
  }
}

class _MoradorButtonSkeletonList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: 4,
        itemBuilder: (context, index) => _MoradorButtonSkeleton(),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
      ),
    );
  }
}

class _MoradorButton extends StatelessWidget {
  final Morador morador;
  final int index;

  const _MoradorButton({
    Key? key,
    required this.morador,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(HeroDialogRoute(builder: (context) {
          return _DetalhesMoradorPopupCard(morador: morador, index: index);
        }));
      },
      child: Hero(
        tag: 'morador-button-hero-' + index.toString(),
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        child: Material(
          color: avatar_background_color_light,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 17),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/memoji/' + morador.foto + '.png'),
                  backgroundColor: avatar_background_color_light,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: GoogleFontText(
                      texto: formatarParaDoisNomes(morador.nome),
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      outlined: true,
                      strokeWidth: 1,
                    ),
                  ),
                ),
                morador.cargo == 'sindico'
                    ? Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(Icons.workspace_premium, color: Colors.white),
                      )
                    : Icon(null),
                morador.proprietario ? Icon(Icons.add_business, color: Colors.white) : Icon(null),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MoradorButtonSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(defaultBorderRadius), color: box_background_color.withOpacity(0.56)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 6),
        child: Row(
          children: [
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                width: 40,
                height: 40,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 17),
                child: SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 20,
                    randomLength: true,
                    minLength: 100,
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                  ),
                ),
              ),
            ),
            SkeletonLine(
              style: SkeletonLineStyle(
                height: 26,
                width: 26,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            SizedBox(width: 3),
          ],
        ),
      ),
    );
  }
}

class _DetalhesMoradorPopupCard extends StatefulWidget {
  final Morador morador;
  final int index;

  const _DetalhesMoradorPopupCard({
    Key? key,
    required this.morador,
    required this.index,
  }) : super(key: key);

  @override
  State<_DetalhesMoradorPopupCard> createState() => _DetalhesMoradorPopupCardState();
}

class _DetalhesMoradorPopupCardState extends State<_DetalhesMoradorPopupCard> {
  final double bottomPadding = 10;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var morador = widget.morador;
    double fonte = 18;

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
              tag: 'morador-button-hero-' + widget.index.toString(),
              createRectTween: (begin, end) {
                return CustomRectTween(begin: begin!, end: end!);
              },
              child: Material(
                color: main_color,
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultBorderRadius)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/images/memoji/' + morador.foto + '.png'),
                          backgroundColor: avatar_background_color_light,
                          radius: 60,
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                          child: _MultiLineText(text: morador.nome, maxSize: 26),
                        ),
                        SizedBox(height: 25),
                        Divider(color: Colors.white.withOpacity(0.9), height: 20, thickness: 0.5),
                        GoogleFontText(texto: 'Cpf:', color: Colors.white, fontSize: fonte, outlined: true, strokeWidth: 1),
                        SizedBox(height: 8),
                        GoogleFontText(texto: morador.cpf, color: Colors.white, fontSize: fonte, fontWeight: FontWeight.normal, outlined: true, strokeWidth: 1),
                        SizedBox(height: 8),
                        Divider(color: Colors.white.withOpacity(0.9), height: 20, thickness: 0.5),
                        GoogleFontText(texto: 'Email:', color: Colors.white, fontSize: fonte, fontWeight: FontWeight.normal, outlined: true, strokeWidth: 1),
                        SizedBox(height: 8),
                        GoogleFontText(texto: morador.email, color: Colors.white, fontSize: fonte, fontWeight: FontWeight.normal, outlined: true, strokeWidth: 1),
                        Divider(color: Colors.white.withOpacity(0.9), height: 20, thickness: 0.5),
                        GoogleFontText(texto: 'Telefone:', color: Colors.white, fontSize: fonte, fontWeight: FontWeight.normal, outlined: true, strokeWidth: 1),
                        SizedBox(height: 8),
                        GoogleFontText(texto: morador.telefone, color: Colors.white, fontSize: fonte, fontWeight: FontWeight.normal, outlined: true, strokeWidth: 1),
                        Divider(color: Colors.white.withOpacity(0.9), height: 20, thickness: 0.5),
                        GoogleFontText(texto: 'Data de nascimento', color: Colors.white, fontSize: fonte, fontWeight: FontWeight.normal, outlined: true, strokeWidth: 1),
                        SizedBox(height: 8),
                        GoogleFontText(texto: morador.dataNascimento, color: Colors.white, fontSize: fonte, fontWeight: FontWeight.normal, outlined: true, strokeWidth: 1),
                        Divider(color: Colors.white.withOpacity(0.9), height: 20, thickness: 0.5),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MultiLineText extends StatelessWidget {
  final String text;
  final double maxSize;

  _MultiLineText({required this.text, required this.maxSize});

  List<String> _splitText(String text) {
    if (text.length <= 28) return [text, ''];
    int ultimoEspaco = text.lastIndexOf(' ');
    return [text.substring(0, ultimoEspaco), text.substring(ultimoEspaco + 1)];
  }

  @override
  Widget build(BuildContext context) {
    List<String> texts = _splitText(text);
    return Container(
      child: Wrap(
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: GoogleFontText(texto: texts[0], fontSize: maxSize, color: Colors.white, outlined: true, strokeWidth: 1),
          ),
          if (texts[1].isNotEmpty) ...[
            FittedBox(
              fit: BoxFit.scaleDown,
              child: GoogleFontText(texto: texts[1], fontSize: maxSize, color: Colors.white, outlined: true, strokeWidth: 1),
            ),
          ],
        ],
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
      ),
    );
  }
}
