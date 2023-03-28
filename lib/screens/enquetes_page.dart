import 'package:condo_plus/components/geral/filter_button.dart';
import 'package:condo_plus/screens/custom_drawer.dart';
import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/material.dart';

class EnquetesPage extends StatefulWidget {
  final dynamic usuarioLogado;

  const EnquetesPage({required this.usuarioLogado});

  @override
  State<EnquetesPage> createState() => _EnquetesPageState();
}

class _EnquetesPageState extends State<EnquetesPage> {
  static const List<String> filtros = ['Todas', 'Respondidas', 'Não respondidas'];
  late int filtroSelecionado;
  late bool _isLoading;

  @override
  void initState() {
    filtroSelecionado = 0;
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
            AddFilterButton(filtros: filtros, filtroSelecionado: filtroSelecionado, tag: 'enquetes-filter', callback: (novoFiltro) => atualizarFiltro(novoFiltro)),
          ],
        ),
      ),
    );
  }

  void obterEnquetes() async {
    setState(() => _isLoading = true);

    // var caminho = 'json/enquetes.json';
    // try {
    //   final String response = await rootBundle.loadString(caminho);
    //   final data = await json.decode(response);
    //   setState(() => _enquetes = data['reservas'].map((data) => Enquete.fromJson(data)).toList());
    // } catch (exception) {
    //   _enquetes = [];
    // }

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
