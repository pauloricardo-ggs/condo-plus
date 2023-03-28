import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:condo_plus/components/geral/filter.dart';
import 'package:condo_plus/components/reservas/reserva_adicionar_button.dart';
import 'package:condo_plus/components/reservas/reserva_button.dart';
import 'package:condo_plus/components/reservas/reserva_button_skeleton.dart';
import 'package:condo_plus/models/apartamento.dart';
import 'package:condo_plus/models/reserva.dart';
import 'package:condo_plus/pages/custom_drawer.dart';
import 'package:condo_plus/theme/themes.dart';

class ReservasPage extends StatefulWidget {
  final dynamic usuarioLogado;

  const ReservasPage({required this.usuarioLogado});

  @override
  State<ReservasPage> createState() => _ReservasPageState();
}

class _ReservasPageState extends State<ReservasPage> {
  static const List<String> filtros = ['Todas', 'Finalizada', 'Paga', 'Aguardando pagamento', 'Cancelada'];
  List<dynamic> _reservas = [];
  late bool _isLoading;
  late int filtroSelecionado;

  @override
  void initState() {
    filtroSelecionado = 0;
    obterReservas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reservas')),
      drawer: CustomDrawer(usuarioLogado: widget.usuarioLogado, index: 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DefaultValues.horizontalPadding),
        child: Column(
          children: [
            FilterAddButton(filtros: filtros, filtroSelecionado: filtroSelecionado, tag: 'reservas-filter', callback: (novoFiltro) => atualizarFiltro(novoFiltro)),
            _isLoading ? ReservaButtonSkeletonList() : ReservaButtonList(reservas: _reservas, filtros: filtros, filtroSelecionado: filtroSelecionado),
          ],
        ),
      ),
      floatingActionButton: ReservaAdicionarButton(apartamento: Apartamento(bloco: '_blocoSelecionado', numApto: '_aptoSelecionado')),
    );
  }

  void obterReservas() async {
    setState(() => _isLoading = true);

    var caminho = 'json/reservas.json';
    try {
      final String response = await rootBundle.loadString(caminho);
      final data = await json.decode(response);
      setState(() => _reservas = data['reservas'].map((data) => Reserva.fromJson(data)).toList());
    } catch (exception) {
      _reservas = [];
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
