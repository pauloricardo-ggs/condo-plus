import 'package:condo_plus/components/moradores/morador_adicionar_popup.dart';
import 'package:condo_plus/components/popup/open_popup_button.dart';
import 'package:condo_plus/models/apartamento.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoradorAdicionarButton extends StatelessWidget {
  final Apartamento apartamento;
  final String tag;

  const MoradorAdicionarButton({
    required this.apartamento,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return OpenPopupButton(
      popupCard: MoradorAdicionarPopup(apartamento: apartamento, tag: tag),
      tag: tag,
      child: Material(
        borderOnForeground: true,
        surfaceTintColor: Colors.red,
        color: colorScheme.primary,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: const Icon(
            CupertinoIcons.person_add_solid,
            size: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
