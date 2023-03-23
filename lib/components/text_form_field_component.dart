// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:condo_plus/configuracoes.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldComponent extends StatelessWidget {
  final String initialValue;
  final bool enabled;
  final double horizontalPadding;
  final double bottomPadding;
  final double borderRadius;

  TextFormFieldComponent({
    Key? key,
    required this.initialValue,
    this.enabled = true,
    this.horizontalPadding = defaultPadding,
    this.bottomPadding = 0,
    this.borderRadius = border_radius_text_field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: horizontalPadding, right: horizontalPadding, bottom: bottomPadding),
      child: TextFormField(
        initialValue: initialValue,
        style: GoogleFonts.comfortaa(color: Colors.grey[400]),
        decoration: InputDecoration(
          enabled: enabled,
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 114, 114, 114)),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: defaultPadding),
          fillColor: Colors.black.withOpacity(0.4),
          filled: true,
        ),
      ),
    );
  }
}
