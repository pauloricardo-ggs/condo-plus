import 'package:condo_plus/components/geral/custom_blurred_container.dart';
import 'package:condo_plus/components/geral/load_button.dart';
import 'package:condo_plus/components/popup/custom_rect_tween.dart';
import 'package:condo_plus/components/popup/hero_dialog_route.dart';
import 'package:condo_plus/models/apartamento.dart';
import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddMoradorButton extends StatelessWidget {
  final Apartamento apartamento;
  final String tag;

  const AddMoradorButton({
    required this.apartamento,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(HeroDialogRoute(builder: (context) {
          return AddMoradorPopupCard(apartamento: apartamento, tag: tag);
        }));
      },
      child: Hero(
        tag: tag,
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        child: Material(
          borderOnForeground: true,
          surfaceTintColor: Colors.red,
          color: colorScheme.primary,
          elevation: 10,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: const Icon(
              CupertinoIcons.person_add_solid,
              size: 24,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class AddMoradorPopupCard extends StatefulWidget {
  final Apartamento apartamento;
  final String tag;

  const AddMoradorPopupCard({
    required this.apartamento,
    required this.tag,
  });

  @override
  State<AddMoradorPopupCard> createState() => _AddMoradorPopupCardState();
}

class _AddMoradorPopupCardState extends State<AddMoradorPopupCard> {
  late bool isLoading;
  late String selectedDate;
  late Color selectedDateColor;

  @override
  void initState() {
    isLoading = false;
    selectedDate = 'data de nascimento';
    selectedDateColor = AppColors.textfield_hint;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return CustomBlurredContainer(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
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
                    UploadFoto(padding_bottom: 15, padding_top: 20),
                    CustomTextField(hint: "nome Completo", bottomPadding: 10.0),
                    CustomTextField(hint: "cpf", bottomPadding: 10.0),
                    CustomTextField(hint: "email", bottomPadding: 10.0),
                    CustomTextField(hint: "telefone", bottomPadding: 10.0),
                    CustomDateTextField(
                        selectedDate: selectedDate,
                        selectedDateColor: selectedDateColor,
                        bottomPadding: 10.0,
                        onTimeChanged: (novaData) => atualizarData(novaData, theme.brightness == Brightness.dark)),
                    CustomTextFormField(initialValue: widget.apartamento.bloco, enabled: false, bottomPadding: 10.0),
                    CustomTextFormField(initialValue: widget.apartamento.numApto, enabled: false, bottomPadding: 20.0),
                    LoadButton(text: 'Cadastrar', isLoading: isLoading, bottomPadding: 20, horizontalPadding: 100.0, width: 150, onPressed: cadastrar, color: theme.colorScheme.secondary),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void atualizarData(String novaData, bool isDark) {
    setState(() {
      selectedDate = novaData;
      selectedDateColor = AppColors.white;
    });
  }

  void cadastrar() async {
    setState(() => isLoading = true);
    await Future.delayed(Duration(seconds: 2));
    setState(() => isLoading = false);
  }
}

class UploadFoto extends StatelessWidget {
  final double padding_bottom;
  final double padding_top;

  const UploadFoto({
    this.padding_bottom = 0,
    this.padding_top = 0,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.only(bottom: padding_bottom, top: padding_top),
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          color: AppColors.textfield_fill,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.textfield_border),
        ),
        child: IconButton(
          iconSize: 50,
          onPressed: () => print,
          icon: Icon(
            Icons.add_a_photo_outlined,
            color: AppColors.textfield_hint,
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hint;
  final double bottomPadding;

  CustomTextField({
    required this.hint,
    this.bottomPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: bottomPadding),
      child: TextField(
        cursorColor: AppColors.cursor,
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

class CustomTextFormField extends StatelessWidget {
  final String initialValue;
  final bool enabled;
  final double bottomPadding;

  CustomTextFormField({
    required this.initialValue,
    this.enabled = true,
    this.bottomPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: bottomPadding),
      child: TextFormField(
        initialValue: initialValue,
        style: TextStyle(color: AppColors.textfield_disabled, fontSize: 18),
        decoration: InputDecoration(
          enabled: enabled,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DefaultValues.borderRadius),
            borderSide: BorderSide(color: AppColors.transparent),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          fillColor: AppColors.textfield_disabled_fill,
          filled: true,
        ),
      ),
    );
  }
}

class CustomDateTextField extends StatelessWidget {
  final double bottomPadding;
  final String selectedDate;
  final Color selectedDateColor;
  final Function(String novoItemSelecionado) onTimeChanged;

  CustomDateTextField({
    this.bottomPadding = 0,
    required this.selectedDate,
    required this.selectedDateColor,
    required this.onTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    DateTime? dataSelecionada = DateTime.tryParse(selectedDate);

    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: bottomPadding),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.textfield_fill,
          border: Border.all(color: AppColors.textfield_border),
          borderRadius: BorderRadius.circular(DefaultValues.borderRadius),
        ),
        child: TextButton(
          style: ButtonStyle(
            padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 18)),
            alignment: Alignment.centerLeft,
            minimumSize: MaterialStatePropertyAll(Size.fromHeight(54)),
          ),
          onPressed: () async {
            onTimeChanged(DateFormat('dd/MM/yyyy').format(DateTime.now()).toString());
            showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  color: isDark ? Color.fromRGBO(48, 48, 48, 1) : AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text('Done', style: TextStyle(color: isDark ? AppColors.white : AppColors.blue, fontFamily: DefaultValues.fontFamily)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Expanded(
                        child: CupertinoDatePicker(
                          initialDateTime: dataSelecionada == null ? DateTime.now() : dataSelecionada,
                          mode: CupertinoDatePickerMode.date,
                          minimumYear: DateTime.now().year - 120,
                          maximumYear: DateTime.now().year,
                          maximumDate: DateTime.now(),
                          onDateTimeChanged: (date) {
                            onTimeChanged(DateFormat('dd/MM/yyyy').format(date).toString());
                          },
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
          child: Text(
            selectedDate,
            style: TextStyle(color: selectedDateColor, fontSize: 18, fontFamily: DefaultValues.fontFamily),
          ),
        ),
      ),
    );
  }
}
