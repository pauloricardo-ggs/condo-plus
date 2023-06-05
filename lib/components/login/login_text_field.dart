import 'package:condo_plus/main.dart';
import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final controller;
  final String hint;
  final bool obscureText;

  LoginTextField({
    required this.controller,
    required this.hint,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        autocorrect: false,
        obscureText: obscureText,
        decoration: InputDecoration(
          fillColor: themeManager.appColor.login_textfield_fill,
          hintText: hint,
          hintStyle: TextStyle(color: themeManager.appColor.login_textfield_hint),
        ),
      ),
    );
  }
}
