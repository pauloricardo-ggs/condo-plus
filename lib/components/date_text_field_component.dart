import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:condo_plus/components/blurry_container_component.dart';
import 'package:condo_plus/configuracoes.dart';

class DateTextFieldComponent extends StatefulWidget {
  final String hint;
  final double horizontalPadding;
  final double bottomPadding;
  final double borderRadius;

  DateTextFieldComponent({
    Key? key,
    required this.hint,
    this.horizontalPadding = defaultPadding,
    this.bottomPadding = 0,
    this.borderRadius = border_radius_text_field,
  }) : super(key: key);

  _DateTextFieldComponentState createState() => _DateTextFieldComponentState();
}

class _DateTextFieldComponentState extends State<DateTextFieldComponent> {
  TextEditingController dateinput = TextEditingController();
  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: widget.horizontalPadding, right: widget.horizontalPadding, bottom: widget.bottomPadding),
      child: TextField(
        style: TextStyle(color: text_color_light),
        controller: dateinput,
        readOnly: true,
        onTap: () async {
          var pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            builder: (context, child) {
              return BlurryContainerComponent(
                child: Theme(
                  data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.highContrastLight(
                        primary: main_color,
                        onPrimary: Colors.white,
                        onSurface: text_color_light,
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor: main_color,
                        ),
                      ),
                      dialogBackgroundColor: background_color_light,
                      dialogTheme: DialogTheme(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius))))),
                  child: child!,
                ),
              );
            },
          );

          if (pickedDate != null) {
            print(pickedDate);
            String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
            print(formattedDate);

            setState(() {
              dateinput.text = formattedDate;
            });
          } else {
            print("Date is not selected");
          }
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: border_box_color_light),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: main_color),
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gapPadding: 100,
          ),
          hintText: widget.hint,
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: defaultPadding),
          hintStyle: GoogleFonts.comfortaa(color: Colors.grey),
          fillColor: box_background_color,
          filled: true,
        ),
      ),
    );
  }
}
