import 'package:condo_plus/components/geral/blurred_container.dart';
import 'package:condo_plus/components/popup/custom_rect_tween.dart';
import 'package:condo_plus/models/apartamento.dart';
import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/material.dart';

class ReservaAdicionarPopup extends StatefulWidget {
  final Apartamento apartamento;
  final String tag;

  const ReservaAdicionarPopup({
    required this.apartamento,
    required this.tag,
  });

  @override
  State<ReservaAdicionarPopup> createState() => _ReservaAdicionarPopupState();
}

class _ReservaAdicionarPopupState extends State<ReservaAdicionarPopup> {
  late bool isLoading;
  late String selectedDate;
  late Color selectedDateColor;

  @override
  void initState() {
    isLoading = false;
    selectedDate = 'data';
    selectedDateColor = AppColors.textfield_hint;
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
                    SizedBox(height: 20),
                    CalendarDatePicker(
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().subtract(Duration(days: 90)),
                      lastDate: DateTime.now().add(Duration(days: 90)),
                      onDateChanged: print,
                    ),
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
