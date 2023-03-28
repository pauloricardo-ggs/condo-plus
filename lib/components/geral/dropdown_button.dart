
import 'dart:math';

import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  final List<String> itens;
  final String itemSelecionado;
  final Function(String novoItemSelecionado) onChanged;

  const CustomDropdownButton({
    required this.itens,
    required this.itemSelecionado,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return DropdownButton<String>(
      iconSize: 15,
      elevation: 4,
      isExpanded: true,
      menuMaxHeight: 400,
      value: itemSelecionado,
      borderRadius: BorderRadius.circular(DefaultValues.borderRadius),
      underline: Container(
        height: 2,
        color: colorScheme.primary,
      ),
      icon: Transform.rotate(
        angle: -pi / 2,
        child: Icon(
          Icons.arrow_back_ios_new,
          color: colorScheme.primary,
        ),
      ),
      onChanged: (String? novoItemSelecionado) async {
        onChanged(novoItemSelecionado!);
      },
      items: itens
          .map<DropdownMenuItem<String>>(
            (String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: DefaultValues.fontFamily,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
