import 'package:flutter/material.dart';

import 'package:condo_plus/components/geral/blurred_container.dart';
import 'package:condo_plus/components/popup/custom_rect_tween.dart';
import 'package:condo_plus/models/enquete.dart';
import 'package:condo_plus/theme/themes.dart';

class EnqueteDetalhesPopup extends StatelessWidget {
  final Enquete enquete;
  final int index;
  final String tag;
  final String? escolha;

  const EnqueteDetalhesPopup({
    required this.enquete,
    required this.index,
    required this.tag,
    this.escolha,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return BlurredContainer(
      child: Center(
        child: Hero(
          tag: tag,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Padding(
            padding: const EdgeInsets.all(DefaultValues.moradorButtonHorizontalPadding - 3),
            child: SingleChildScrollView(
              child: Material(
                color: colorScheme.primary,
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DefaultValues.borderRadius)),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        enquete.nome,
                        style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: DefaultValues.fontFamily),
                        softWrap: false,
                      ),
                      Divider(color: Colors.white.withOpacity(0.9), height: 30, thickness: 0.5),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: colorScheme.secondary,
                          borderRadius: BorderRadius.circular(DefaultValues.borderRadius),
                        ),
                        constraints: BoxConstraints(maxHeight: 400),
                        child: SingleChildScrollView(
                          child: Text(
                            enquete.descricao,
                            style: TextStyle(fontSize: 18, color: Colors.white, fontFamily: DefaultValues.fontFamily),
                          ),
                        ),
                      ),
                      Divider(color: Colors.white.withOpacity(0.9), height: 30, thickness: 0.5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: escolha != null ? null : () => print,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  disabledBackgroundColor: escolha == 'Aprovado' ? Colors.green.shade900 : Colors.grey,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: Colors.black.withOpacity(0.4),
                                      size: 25,
                                    ),
                                    Text(
                                      enquete.aprovado.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: DefaultValues.fontFamily,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black.withOpacity(0.4),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 30),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: escolha != null ? null : () => print,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  disabledBackgroundColor: escolha == 'Reprovado' ? Colors.red.shade900 : Colors.grey,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.close,
                                      color: Colors.black.withOpacity(0.4),
                                      size: 25,
                                    ),
                                    Text(
                                      enquete.rejeitado.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: DefaultValues.fontFamily,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black.withOpacity(0.4),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
