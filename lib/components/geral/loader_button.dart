import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/material.dart';

class LoaderButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final String text;
  final Color? color;
  final double? width;
  final double bottomPadding;
  final double horizontalPadding;

  const LoaderButton({
    required this.isLoading,
    required this.onPressed,
    required this.text,
    this.width,
    this.bottomPadding = 0,
    this.horizontalPadding = 0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding, left: horizontalPadding, right: horizontalPadding),
      child: isLoading
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.5),
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  color: color,
                ),
              ),
            )
          : SizedBox(
              width: width,
              child: ElevatedButton(
                child: Text(
                  text,
                  style: TextStyle(fontSize: 21, color: Colors.white, fontFamily: DefaultValues.fontFamily),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  minimumSize: const Size.fromHeight(55),
                  backgroundColor: color,
                ),
                onPressed: isLoading ? null : onPressed,
              ),
            ),
    );
  }
}
