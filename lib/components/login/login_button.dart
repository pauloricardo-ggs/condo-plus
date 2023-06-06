import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final String text;

  const LoginButton({
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
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 8.0),
                child: Text(
                  text,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
              onPressed: onPressed,
            ),
          );
  }
}
