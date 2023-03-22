// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:condo_plus/configuracoes.dart';

class GoogleFontText extends StatelessWidget {
  final String texto;
  final Color color;
  final double? fontSize;
  final double strokeWidth;
  final FontWeight fontWeight;
  final bool outlined;

  const GoogleFontText({
    Key? key,
    required this.texto,
    this.color = text_color_light,
    this.fontSize,
    this.strokeWidth = 1.3,
    this.fontWeight = FontWeight.w600,
    this.outlined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return outlined
        ? Stack(
            children: [
              Text(
                texto,
                style: GoogleFonts.comfortaa(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..color = Colors.black
                    ..strokeWidth = 1.3,
                ),
              ),
              Text(
                texto,
                style: GoogleFonts.comfortaa(
                  color: color,
                  fontSize: fontSize == null ? null : fontSize!,
                  fontWeight: fontWeight,
                ),
              ),
            ],
          )
        : Text(
            texto,
            style: GoogleFonts.comfortaa(
              color: color,
              fontSize: fontSize == null ? null : fontSize!,
              fontWeight: fontWeight,
            ),
          );
  }
}
