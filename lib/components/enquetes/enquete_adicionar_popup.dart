import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:condo_plus/components/geral/blurred_container.dart';
import 'package:condo_plus/components/popup/custom_rect_tween.dart';
import 'package:condo_plus/theme/themes.dart';

class EnqueteAdicionarPopup extends StatefulWidget {
  final String tag;

  const EnqueteAdicionarPopup({required this.tag});

  @override
  State<EnqueteAdicionarPopup> createState() => _EnqueteAdicionarPopupState();
}

class _EnqueteAdicionarPopupState extends State<EnqueteAdicionarPopup> {
  late bool isLoading;

  @override
  void initState() {
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlurredContainer(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Hero(
            tag: widget.tag,
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin!, end: end!);
            },
            child: Material(
              color: theme.colorScheme.primary,
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DefaultValues.borderRadius)),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _CustomTextField(hint: 'Título', bottomPadding: 15, topPadding: 15),
                    _CustomTextField(hint: 'Descrição', bottomPadding: 15, maxLines: 25, minLines: 5),
                    ElevatedButton(
                        onPressed: () => print,
                        style: ElevatedButton.styleFrom(backgroundColor: theme.colorScheme.secondary),
                        child: Text(
                          'Cadastrar',
                          style: TextStyle(fontFamily: DefaultValues.fontFamily, fontSize: 18, color: AppColors.white),
                        )),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void cadastrar() async {
    setState(() => isLoading = true);
    await Future.delayed(Duration(seconds: 2));
    setState(() => isLoading = false);
  }
}

class _CustomTextField extends StatelessWidget {
  final String hint;
  int? minLines;
  int? maxLines;
  final double bottomPadding;
  final double topPadding;

  _CustomTextField({
    required this.hint,
    this.minLines,
    this.maxLines,
    this.bottomPadding = 0,
    this.topPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: bottomPadding, top: topPadding),
      child: TextField(
        cursorColor: AppColors.cursor,
        maxLines: maxLines,
        minLines: minLines,
        autocorrect: false,
        style: TextStyle(fontFamily: DefaultValues.fontFamily, fontSize: 18, color: AppColors.white),
        decoration: InputDecoration(
          fillColor: AppColors.textfield_fill,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DefaultValues.borderRadius),
            borderSide: BorderSide(color: AppColors.textfield_border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DefaultValues.borderRadius),
            borderSide: BorderSide(color: AppColors.textfield_focused_border),
          ),
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.textfield_hint),
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        ),
      ),
    );
  }
}