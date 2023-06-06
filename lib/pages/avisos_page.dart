import 'dart:convert';

import 'package:condo_plus/components/avisos/aviso_button.dart';
import 'package:condo_plus/components/avisos/aviso_button_skeleton.dart';
import 'package:condo_plus/components/avisos/cadastrar_aviso_popup.dart';
import 'package:condo_plus/components/popup/open_popup_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:condo_plus/pages/custom_drawer.dart';
import 'package:condo_plus/models/aviso.dart';

class AvisosPage extends StatefulWidget {
  const AvisosPage();

  @override
  State<AvisosPage> createState() => _AvisosPageState();
}

class _AvisosPageState extends State<AvisosPage> {
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
      appBar: AppBar(
        title: Text('Avisos'),
        centerTitle: true,
        actions: [
          OpenPopupButton(
            popupCard: AvisoAdicionarPopup(tag: 'cadastrar-aviso-tag'),
            tag: 'cadastrar-aviso',
            child: Icon(CupertinoIcons.add),
          ),
          const SizedBox(width: 15.0),
        ],
      ),
      drawer: CustomDrawer(index: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(children: [_isLoading ? AvisoButtonSkeletonList() : AvisoButtonList(avisos: _avisos)]),
      ),
    );
  }

  void obterAvisos() async {
    // final String response = await rootBundle.loadString('json/avisos.json');
    // final data = await json.decode(response);

    // setState(() {
    //   _avisos = data['avisos'].map((data) => Aviso.fromJson(data)).toList();
    //   _isLoading = false;
    // });
  }
}
