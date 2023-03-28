import 'dart:convert';

import 'package:condo_plus/components/moradores/morador_adicionar_button.dart';
import 'package:condo_plus/components/geral/dropdown_button.dart';
import 'package:condo_plus/components/moradores/morador_button.dart';
import 'package:condo_plus/components/moradores/morador_button_skeleton.dart';
import 'package:condo_plus/models/apartamento.dart';
import 'package:condo_plus/models/morador.dart';
import 'package:condo_plus/pages/custom_drawer.dart';
import 'package:condo_plus/theme/themes.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MoradoresPage extends StatefulWidget {
  final dynamic usuarioLogado;

  const MoradoresPage({this.usuarioLogado});

  @override
  State<MoradoresPage> createState() => _MoradoresPageState();
}

class _MoradoresPageState extends State<MoradoresPage> {
  final List<String> _blocos = ['Alpha', 'Beta', 'Gama'];
  final List<String> _numerosApartamentos = ['101', '102', '103', '104', '201', '202', '203', '204', '301', '302', '303', '304', '1204'];

  List<dynamic> _moradores = [];
  late String _aptoSelecionado;
  late String _blocoSelecionado;
  late bool _isLoading;

  @override
  void initState() {
    _aptoSelecionado = _numerosApartamentos.first;
    _blocoSelecionado = _blocos.first;
    obterMoradores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Moradores')),
      drawer: CustomDrawer(usuarioLogado: widget.usuarioLogado, index: 3),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: DefaultValues.moradorButtonHorizontalPadding, right: DefaultValues.moradorButtonHorizontalPadding),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: CustomDropdownButton(
                      itens: _blocos,
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
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: CustomDropdownButton(
                      itens: _numerosApartamentos,
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
            _isLoading ? MoradorButtonSkeletonList() : MoradorButtonList(moradores: _moradores),
          ],
        ),
      ),
      floatingActionButton: MoradorAdicionarButton(apartamento: Apartamento(bloco: _blocoSelecionado, numApto: _aptoSelecionado), tag: 'add-morador-hero'),
    );
  }

  void obterMoradores() async {
    setState(() => _isLoading = true);

    var caminho = 'json/moradores' + _blocoSelecionado + _aptoSelecionado + '.json';
    try {
      final String response = await rootBundle.loadString(caminho);
      final data = await json.decode(response);
      setState(() => _moradores = data['moradores'].map((data) => Morador.fromJson(data)).toList());
    } catch (exception) {
      _moradores = [];
    }

    await Future.delayed(Duration(seconds: DefaultValues.timeToLoadMoradores));

    setState(() => _isLoading = false);
  }
}
