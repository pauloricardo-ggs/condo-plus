import 'package:condo_plus/components/moradores/morador_adicionar_button.dart';
import 'package:condo_plus/components/geral/dropdown_button.dart';
import 'package:condo_plus/components/moradores/morador_button.dart';
import 'package:condo_plus/components/moradores/morador_button_skeleton.dart';
import 'package:condo_plus/controllers/moradores_controller.dart';
import 'package:condo_plus/models/apartamento.dart';
import 'package:condo_plus/models/perfil_usuario.dart';
import 'package:condo_plus/pages/custom_drawer.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoradoresPage extends StatefulWidget {
  final dynamic usuarioLogado;

  const MoradoresPage({this.usuarioLogado});

  @override
  State<MoradoresPage> createState() => _MoradoresPageState();
}

class _MoradoresPageState extends State<MoradoresPage> {
  final List<String> _blocos = ['Alpha', 'Beta', 'Gama'];
  final List<String> _numerosApartamentos = ['101', '102', '103', '104', '201', '202', '203', '204', '301', '302', '303', '304', '1204'];

  List<PerfilUsuario> _moradores = [];
  late String _aptoSelecionado;
  late String _blocoSelecionado;

  final _moradoresController = Get.put(MoradoresController());

  @override
  void initState() {
    _aptoSelecionado = _numerosApartamentos.first;
    _blocoSelecionado = _blocos.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Moradores')),
      drawer: CustomDrawer(index: 3),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
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
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            buildMoradores(),
          ],
        ),
      ),
      floatingActionButton: MoradorAdicionarButton(apartamento: Apartamento(bloco: _blocoSelecionado, numApto: _aptoSelecionado), tag: 'add-morador-hero'),
    );
  }

  Widget buildMoradores() {
    return Column(
      children: [
        const SizedBox(height: 12.0),
        StreamBuilder<List<PerfilUsuario>>(
          stream: _moradoresController.obterPorApartamento(_blocoSelecionado, _aptoSelecionado),
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text(snapshot.error.toString());
            if (!snapshot.hasData) return MoradorButtonSkeletonList();
            _moradores = snapshot.data!;

            return _moradores.isEmpty
                ? Column(
                    children: [
                      SizedBox(height: 60),
                      Text(
                        'Esse apartamento está vazio,\ncadastre moradores para ele.',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _moradores.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 8.0),
                    itemBuilder: (context, index) => MoradorButton(
                      morador: _moradores[index],
                      index: index,
                      tag: 'morador-button-hero-' + index.toString(),
                    ),
                  );
          },
        ),
      ],
    );
  }
}
