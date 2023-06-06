import 'package:condo_plus/components/avisos/aviso_button.dart';
import 'package:condo_plus/components/avisos/aviso_button_skeleton.dart';
import 'package:condo_plus/components/avisos/cadastrar_aviso_popup.dart';
import 'package:condo_plus/components/popup/open_popup_button.dart';
import 'package:condo_plus/controllers/auth_controller.dart';
import 'package:condo_plus/controllers/avisos_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:condo_plus/pages/custom_drawer.dart';
import 'package:condo_plus/models/aviso.dart';
import 'package:get/get.dart';

class AvisosPage extends StatefulWidget {
  const AvisosPage();

  @override
  State<AvisosPage> createState() => _AvisosPageState();
}

class _AvisosPageState extends State<AvisosPage> {
  List<Aviso> _avisos = [];
  final _avisosController = Get.put(AvisosController());
  final _authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avisos'),
        centerTitle: true,
        actions: [
          _authController.ehMorador()
              ? const SizedBox.shrink()
              : OpenPopupButton(
                  popupCard: AvisoAdicionarPopup(tag: 'cadastrar-aviso-tag'),
                  tag: 'cadastrar-aviso',
                  child: Icon(CupertinoIcons.add),
                ),
          const SizedBox(width: 15.0),
        ],
      ),
      drawer: CustomDrawer(index: 0),
      body: buildAvisos(),
    );
  }

  Widget buildAvisos() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: StreamBuilder<List<Aviso>>(
        stream: _avisosController.listar(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text(snapshot.error.toString());
          if (!snapshot.hasData) return CircularProgressIndicator();
          _avisos = snapshot.data!;

          return _avisos.isEmpty
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
                  itemCount: _avisos.length + 2,
                  separatorBuilder: (context, index) => const SizedBox(height: 12.0),
                  itemBuilder: (context, index) {
                    if (index == 0 || index == _avisos.length + 1) return const SizedBox();
                    return AvisoButton(
                      aviso: _avisos[index - 1],
                      tag: 'morador-button-hero-' + {index - 1}.toString(),
                    );
                  },
                );
        },
      ),
    );
  }
}
