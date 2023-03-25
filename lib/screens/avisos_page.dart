import 'dart:convert';

import 'package:condo_plus/components/avisos/card_aviso.dart';
import 'package:condo_plus/components/avisos/card_aviso_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:condo_plus/screens/custom_drawer.dart';
import 'package:condo_plus/models/aviso.dart';
import 'package:condo_plus/theme/themes.dart';

class AvisosPage extends StatefulWidget {
  final dynamic loggedUser;

  const AvisosPage({required this.loggedUser});

  @override
  State<AvisosPage> createState() => AvisosPageState();
}

class AvisosPageState extends State<AvisosPage> {
  List<dynamic> _avisos = [];
  late bool _isLoading;

  @override
  void initState() {
    _isLoading = true;
    obterAvisos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Avisos')),
      drawer: CustomDrawer(usuarioLogado: widget.loggedUser, index: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DefaultValues.horizontalPadding),
        child: Column(children: [_isLoading ? ListaCardAvisosSkeleton() : ListaCardAvisos(avisos: _avisos)]),
      ),
    );
  }

  void obterAvisos() async {
    final String response = await rootBundle.loadString('json/avisos.json');
    final data = await json.decode(response);
    await Future.delayed(Duration(seconds: DefaultValues.timeLoadAvisos));

    setState(() {
      _avisos = data['avisos'].map((data) => Aviso.fromJson(data)).toList();
      _isLoading = false;
    });
  }
}
