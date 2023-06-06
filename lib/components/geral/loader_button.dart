import 'package:flutter/material.dart';

class LoaderButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final String text;

  const LoaderButton({
    required this.isLoading,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.5),
            child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                strokeWidth: 5,
              ),
            ),
          )
        : SizedBox(
            child: ElevatedButton(
              child: Text(
                text,
                style: TextStyle(fontSize: 21, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 4,
              ),
              onPressed: isLoading ? null : onPressed,
            ),
          );
  }
}
