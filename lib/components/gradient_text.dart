import 'package:condo_plus/components/google_font_text.dart';
import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Gradient gradient;

  GradientText({required this.text, required this.fontSize, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) => gradient.createShader(bounds),
      child: GoogleFontText(
        texto: text,
        fontSize: fontSize,
        color: Colors.white,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
