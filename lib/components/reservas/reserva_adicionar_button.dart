import 'package:condo_plus/components/popup/open_popup_button.dart';
import 'package:condo_plus/components/reservas/reserva_adicionar_popup.dart';
import 'package:condo_plus/models/apartamento.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReservaAdicionarButton extends StatelessWidget {
  final Apartamento apartamento;

  const ReservaAdicionarButton({
    required this.apartamento,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return OpenPopupButton(
      popupCard: ReservaAdicionarPopup(apartamento: apartamento, tag: 'add-reserva-hero'),
      tag: 'add-reserva-hero',
      child: Material(
        borderOnForeground: true,
        color: colorScheme.primary,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: const Icon(
            CupertinoIcons.calendar_badge_plus,
            size: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
