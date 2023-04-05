import 'package:flutter/material.dart';

import 'package:condo_plus/components/enquetes/enquete_adicionar_popup.dart';
import 'package:condo_plus/components/popup/open_popup_button.dart';

class EnqueteAdicionarButton extends StatelessWidget {
  const EnqueteAdicionarButton();

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return OpenPopupButton(
      popupCard: EnqueteAdicionarPopup(tag: 'add-enquete-hero'),
      tag: 'add-enquete-hero',
      child: Material(
        borderOnForeground: true,
        color: colorScheme.primary,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: const Icon(
            Icons.assignment_add,
            size: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
