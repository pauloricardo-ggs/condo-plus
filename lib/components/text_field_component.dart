// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:condo_plus/configuracoes.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldComponent extends StatelessWidget {
  final String hint;
  final bool obscureText;
  final double horizontalPadding;
  final double bottomPadding;
  final double borderRadius;

  TextFieldComponent({
    Key? key,
    required this.hint,
    this.obscureText = false,
    this.horizontalPadding = defaultPadding,
    this.bottomPadding = 0,
    this.borderRadius = border_radius_text_field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: horizontalPadding, right: horizontalPadding, bottom: bottomPadding),
      child: TextField(
        obscureText: obscureText,
        style: GoogleFonts.comfortaa(color: text_color_light),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: border_box_color_light),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: main_color),
            borderRadius: BorderRadius.circular(borderRadius),
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
