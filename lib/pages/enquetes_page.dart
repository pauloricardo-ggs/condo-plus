import 'dart:convert';

import 'package:condo_plus/components/enquetes/enquete_adicionar_button.dart';
import 'package:condo_plus/components/enquetes/enquete_button.dart';
import 'package:condo_plus/components/geral/filter.dart';
import 'package:condo_plus/models/enquete.dart';
import 'package:condo_plus/models/enquete_escolha.dart';
import 'package:condo_plus/pages/custom_drawer.dart';
import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EnquetesPage extends StatefulWidget {
  final dynamic usuarioLogado;

  const EnquetesPage({required this.usuarioLogado});

  @override
  State<EnquetesPage> createState() => _EnquetesPageState();
}

class _EnquetesPageState extends State<EnquetesPage> {
  static const List<String> filtros = ['Todas', 'Respondidas', 'Não respondidas', 'Aprovadas', 'Rejeitadas'];
  List<dynamic> _enquetes = [];
  List<dynamic> _enquetesEscolha = [];
  late int filtroSelecionado;
  late bool _isLoading;

  @override
  void initState() {
    filtroSelecionado = 0;
    obterEnquetes();
    obterEnquetesEscolha();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enquetes', style: TextStyle(fontFamily: DefaultValues.fontFamily)),
      ),
      drawer: CustomDrawer(index: 2, usuarioLogado: widget.usuarioLogado),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DefaultValues.horizontalPadding),
        child: Column(
          children: [
            FilterAddButton(filtros: filtros, filtroSelecionado: filtroSelecionado, tag: 'enquetes-filter', callback: (novoFiltro) => atualizarFiltro(novoFiltro)),
            EnqueteButtonList(enquetes: _enquetes, enquetesEscolha: _enquetesEscolha, filtroSelecionado: filtroSelecionado, filtros: filtros)
          ],
        ),
      ),
      floatingActionButton: EnqueteAdicionarButton(),
    );
  }

  void obterEnquetes() async {
    setState(() => _isLoading = true);

    var caminho = 'json/enquetes.json';
    try {
      final String response = await rootBundle.loadString(caminho);
      final data = await json.decode(response);
      setState(() => _enquetes = data['enquetes'].map((data) => Enquete.fromJson(data)).toList());
    } catch (exception) {
      _enquetes = [];
    }

    await Future.delayed(Duration(seconds: DefaultValues.timeToLoadReservas));

    setState(() => _isLoading = false);
  }

  void obterEnquetesEscolha() async {
    setState(() => _isLoading = true);

    var caminho = 'json/enquetes_escolha.json';
    try {
      final String response = await rootBundle.loadString(caminho);
      final data = await json.decode(response);
      setState(() => _enquetesEscolha = data['enquetes_escolha'].map((data) => EnqueteEscolha.fromJson(data)).toList());
    } catch (exception) {
      _enquetesEscolha = [];
    }

    await Future.delayed(Duration(seconds: DefaultValues.timeToLoadReservas));

    setState(() => _isLoading = false);
  }

  Future<void> atualizarFiltro(int novoFiltro) async {
    setState(() {
      _isLoading = true;
      filtroSelecionado = novoFiltro;
    });
    await Future.delayed(Duration(seconds: DefaultValues.timeToLoadReservas));
    setState(() => _isLoading = false);
  }
}
