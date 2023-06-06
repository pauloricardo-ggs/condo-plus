import 'package:condo_plus/components/enquetes/enquete_detalhes_popup.dart';
import 'package:condo_plus/components/popup/open_popup_button.dart';
import 'package:condo_plus/models/enquete.dart';
import 'package:flutter/material.dart';

class EnqueteButton extends StatelessWidget {
  final Enquete enquete;
  final String tag;
  final String? escolha;

  const EnqueteButton({
    required this.enquete,
    required this.tag,
    this.escolha,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      constraints: BoxConstraints(minHeight: 43),
      child: OpenPopupButton(
        popupCard: EnqueteDetalhesPopup(enquete: enquete, escolha: escolha, tag: tag),
        tag: tag,
        child: Material(
          elevation: 4,
          color: colorScheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Padding(
            padding: const EdgeInsets.only(top: 6.0, bottom: 6.0, left: 14.0, right: 14.0),
            child: Row(
              children: [
                Expanded(child: Text(enquete.titulo, style: TextStyle(fontSize: 14, color: Colors.white))),
                Row(
                  children: [
                    SizedBox(width: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.check,
                          size: 15,
                          color: Colors.green[300],
                        ),
                        Text(enquete.quantidadeAprovado.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green[300],
                            )),
                      ],
                    ),
                    SizedBox(width: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.close,
                          size: 15,
                          color: Colors.red,
                        ),
                        Text(enquete.quantidadeRejeitado.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                            )),
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
