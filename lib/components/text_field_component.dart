// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:condo_plus/configuracoes.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldComponent extends StatelessWidget {
  final String hint;
  final bool obscureText;
  final double padding_horizontal;
  final double padding_bottom;

  TextFieldComponent({
    Key? key,
    required this.hint,
    this.obscureText = false,
    this.padding_horizontal = defaultPadding,
    this.padding_bottom = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: padding_horizontal, right: padding_horizontal, bottom: padding_bottom),
      child: TextField(
        obscureText: obscureText,
        style: GoogleFonts.comfortaa(color: text_color_light),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: border_box_color_light),
            borderRadius: BorderRadius.circular(defaultBorderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: main_color),
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            gapPadding: 100,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: defaultPadding),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          fillColor: box_background_color,
          filled: true,
        ),
      ),
    );
  }
}
