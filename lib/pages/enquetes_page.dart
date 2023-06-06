import 'package:condo_plus/components/enquetes/enquete_adicionar_button.dart';
import 'package:condo_plus/components/enquetes/enquete_button.dart';
import 'package:condo_plus/components/geral/filter.dart';
import 'package:condo_plus/controllers/auth_controller.dart';
import 'package:condo_plus/controllers/enquetes_controller.dart';
import 'package:condo_plus/models/enquete.dart';
import 'package:condo_plus/pages/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnquetesPage extends StatefulWidget {
  const EnquetesPage();

  @override
  State<EnquetesPage> createState() => _EnquetesPageState();
}

class _EnquetesPageState extends State<EnquetesPage> {
  static const List<String> filtros = ['Todas', 'Aprovadas', 'Rejeitadas', 'Andamento', 'Finalizadas'];
  List<Enquete> _enquetes = [];
  int filtroSelecionado = 0;

  final _enquetesController = Get.put(EnquetesController());
  final _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enquetes'),
      ),
      drawer: CustomDrawer(index: 2),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            FilterAddButton(filtros: filtros, filtroSelecionado: filtroSelecionado, tag: 'enquetes-filter', callback: (novoFiltro) => atualizarFiltro(novoFiltro)),
            buildEnquetes(),
          ],
        ),
      ),
      floatingActionButton: _authController.ehAdministracaoOuSindico() ? EnqueteAdicionarButton() : const SizedBox.shrink(),
    );
  }

  Widget buildEnquetes() {
    return StreamBuilder<List<Enquete>>(
      stream: _enquetesController.listar(filtros[filtroSelecionado]),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text(snapshot.error.toString());
        if (!snapshot.hasData) return CircularProgressIndicator();
        _enquetes = snapshot.data!;

        return _enquetes.isEmpty
            ? Column(
                children: [
                  SizedBox(height: 60),
                  Text(
                    'Nenhum aviso cadastrado.',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              )
            : ListView.separated(
                shrinkWrap: true,
                itemCount: _enquetes.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12.0),
                itemBuilder: (context, index) {
                  return EnqueteButton(
                    enquete: _enquetes[index],
                    tag: 'morador-button-hero-' + {index}.toString(),
                  );
                },
              );
      },
    );
  }

  Future<void> atualizarFiltro(int novoFiltro) async {
    setState(() {
      filtroSelecionado = novoFiltro;
    });
  }
}
