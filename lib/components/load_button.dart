import 'package:condo_plus/components/google_font_text.dart';
import 'package:condo_plus/configuracoes.dart';
import 'package:flutter/material.dart';

class LoadButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final String text;
  final double width;
  final double bottomPadding;
  final Color color;

  const LoadButton({
    Key? key,
    required this.isLoading,
    required this.onPressed,
    required this.text,
    this.color = main_color,
    this.width = 120,
    this.bottomPadding = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: isLoading
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.5),
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: color,
                  strokeWidth: 5,
                ),
              ),
            )
          : SizedBox(
              width: width,
              child: ElevatedButton(
                child: GoogleFontText(texto: text, color: Colors.white, fontSize: 20),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(55),
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultBorderRadius)),
                  enableFeedback: false,
                ),
                onPressed: isLoading ? null : onPressed,
              ),
            ),
    );
  }
}
