// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:condo_plus/configuracoes.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldComponent extends StatelessWidget {
  final String initialValue;
  final bool enabled;
  final double padding_horizontal;
  final double padding_bottom;

  TextFormFieldComponent({
    Key? key,
    required this.initialValue,
    this.enabled = true,
    this.padding_horizontal = defaultPadding,
    this.padding_bottom = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: padding_horizontal, right: padding_horizontal, bottom: padding_bottom),
      child: TextFormField(
        initialValue: initialValue,
        style: GoogleFonts.comfortaa(color: text_color_light),
        decoration: InputDecoration(
          enabled: enabled,
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 114, 114, 114)),
            borderRadius: BorderRadius.circular(defaultBorderRadius),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: defaultPadding),
          fillColor: Colors.black.withOpacity(0.4),
          filled: true,
        ),
      ),
    );
  }
}
