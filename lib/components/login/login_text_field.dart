import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final String hint;
  final double horizontalPadding;
  final double bottomPadding;
  final bool obscureText;

  LoginTextField({
    required this.hint,
    this.obscureText = false,
    this.horizontalPadding = DefaultValues.horizontalPadding,
    this.bottomPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.only(left: horizontalPadding, right: horizontalPadding, bottom: bottomPadding),
      child: TextField(
        autocorrect: false,
        obscureText: obscureText,
        style: TextStyle(fontFamily: DefaultValues.fontFamily, fontSize: 18),
        decoration: InputDecoration(
          fillColor: isDark ? AppColors.dark_login_textfield_fill : AppColors.light_login_textfield_fill,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DefaultValues.borderRadius),
            borderSide: BorderSide(color: AppColors.login_textfield_border),
          ),
          hintText: hint,
          hintStyle: TextStyle(color: isDark ? AppColors.dark_login_textfield_hint : AppColors.light_login_textfield_hint),
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        ),
      ),
    );
  }
}
