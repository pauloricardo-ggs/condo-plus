import 'package:condo_plus/components/enquetes/enquete_detalhes_popup.dart';
import 'package:condo_plus/components/popup/open_popup_button.dart';
import 'package:condo_plus/models/enquete.dart';
import 'package:flutter/material.dart';

class EnqueteButtonList extends StatelessWidget {
  final List<dynamic> enquetes;
  final List<dynamic> enquetesEscolha;
  final int filtroSelecionado;
  final List<String> filtros;

  const EnqueteButtonList({
    required this.enquetes,
    required this.enquetesEscolha,
    required this.filtroSelecionado,
    required this.filtros,
  });

  @override
  Widget build(BuildContext context) {
    List<Enquete> enquetesFiltradas = enquetes.cast<Enquete>();

    //if (filtroSelecionado != 0) enquetesFiltradas = enquetesFiltradas.where((enquete) => enquete.votada == filtros[filtroSelecionado]).toList();

    return enquetesFiltradas.isEmpty
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 0),
                child: Text(
                  textAlign: TextAlign.center,
                  filtroSelecionado == 0 ? 'alterar' : 'alterar',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          )
        : Expanded(
            child: ListView.separated(
              itemCount: enquetesFiltradas.length,
              itemBuilder: (context, index) {
                var escolha = enquetesEscolha.firstWhere((enqueteEscolha) => enqueteEscolha.enqueteId == enquetesFiltradas[index].id, orElse: () => null);
                return _EnqueteButton(
                  enquete: enquetesFiltradas[index],
                  escolha: escolha != null ? escolha.escolha : null,
                  index: index,
                  tag: 'enquete-button-hero-' + index.toString(),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 8),
            ),
          );
  }
}

class _EnqueteButton extends StatelessWidget {
  final Enquete enquete;
  final int index;
  final String tag;
  final String? escolha;

  const _EnqueteButton({
    required this.enquete,
    required this.index,
    required this.tag,
    this.escolha,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 43),
      child: OpenPopupButton(
        popupCard: EnqueteDetalhesPopup(enquete: enquete, escolha: escolha, index: index, tag: tag),
        tag: tag,
        child: Material(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Padding(
            padding: const EdgeInsets.only(top: 6.0, bottom: 6.0, left: 14.0, right: 14.0),
            child: Row(
              children: [
                Expanded(child: Text(enquete.nome, style: TextStyle(fontSize: 16, color: Colors.white))),
                SizedBox(width: 10),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check),
                        Text(enquete.aprovado.toString(), style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(width: 5),
                    Row(
                      children: [
                        Icon(Icons.close),
                        Text(enquete.rejeitado.toString(), style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
