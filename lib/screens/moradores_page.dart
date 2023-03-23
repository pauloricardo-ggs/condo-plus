import 'dart:convert';
import 'dart:math';

import 'package:condo_plus/components/drawer_component.dart';
import 'package:condo_plus/components/google_font_text.dart';
import 'package:condo_plus/components/popup/add_morador_button.dart';
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
      drawer: DrawerComponent(usuarioLogado: widget.usuarioLogado, selectedIndex: 3),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: defaultPadding, left: defaultPadding, right: defaultPadding),
            child: Column(
              children: [
                selecaoBlocoApto(),
                SizedBox(height: 30),
                _carregandoMoradores ? listaBotaoMoradorSkelton() : listaBotaoMorador(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: AddMoradorButton(apartamento: Apartamento(bloco: _blocoSelecionado, numApto: _aptoSelecionado)),
    );
  }

  Widget selecaoBlocoApto() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: defaultPadding),
            child: dropdownButton(blocos, _blocoSelecionado, atualizarBlocoSelecionado),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: defaultPadding),
            child: dropdownButton(numerosApartamentos, _aptoSelecionado, atualizarAptoSelecionado),
          ),
        ),
      ],
    );
  }

  Widget dropdownButton(List<String> listaDeItens, String itemSelecionado, void Function(String novoItemSelecionado) atualizarItemSelecionado) {
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
        atualizarItemSelecionado(novoItemSelecionado!);
        await obterMoradores();
      },
      items: listaDeItens.map<DropdownMenuItem<String>>((String item) => DropdownMenuItem<String>(value: item, child: GoogleFontText(texto: item, fontSize: 18))).toList(),
    );
  }

  Widget listaBotaoMorador() {
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
              itemBuilder: (context, index) => botaoMorador(morador: moradores[index]),
              separatorBuilder: (context, index) => const SizedBox(height: 8),
            ),
          );
  }

  Widget listaBotaoMoradorSkelton() {
    return Expanded(
      child: ListView.separated(
        itemCount: 4,
        itemBuilder: (context, index) => botaoMoradorSkelton(),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
      ),
    );
  }

  Widget botaoMoradorSkelton() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(defaultBorderRadius), color: box_background_color.withOpacity(0.56)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 6.5),
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
                padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 17),
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

  Widget botaoMorador({required Morador morador}) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/' + tipoAvatar + '/' + morador.foto + '.png'),
                  backgroundColor: avatar_background_color_light,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 17),
                    child: GoogleFontText(
                      texto: formatarParaDoisNomes(morador.nome),
                      color: widget.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                morador.cargo == 'sindico'
                    ? Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(Icons.workspace_premium, color: widget.textColor),
                      )
                    : Icon(null),
                morador.proprietario ? Icon(Icons.add_business, color: widget.textColor) : Icon(null),
              ],
            ),
            style: ElevatedButton.styleFrom(
              foregroundColor: main_color,
              minimumSize: const Size.fromHeight(55),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              backgroundColor: widget.buttonColor,
            ),
            onPressed: () => print,
          ),
        ),
      ],
    );
  }

  Future<void> obterMoradores() async {
    setState(() {
      _carregandoMoradores = true;
    });

    var caminho = 'json/moradores' + _blocoSelecionado + _aptoSelecionado + '.json';
    try {
      final String response = await rootBundle.loadString(caminho);
      final data = await json.decode(response);
      setState(() {
        moradores = data['moradores'].map((data) => Morador.fromJson(data)).toList();
      });
    } catch (exception) {
      moradores = [];
    }
    await Future.delayed(Duration(seconds: tempoParaCarregarMoradores));
    setState(() {
      _carregandoMoradores = false;
    });
  }

  void atualizarAptoSelecionado(String novoApto) {
    setState(() {
      _aptoSelecionado = novoApto;
    });
  }

  void atualizarBlocoSelecionado(String novoBloco) {
    setState(() {
      _blocoSelecionado = novoBloco;
    });
  }
}
