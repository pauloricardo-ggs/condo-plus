import 'dart:convert';

import 'package:condo_plus/components/geral/custom_blurred_container.dart';
import 'package:condo_plus/components/geral/filter_button.dart';
import 'package:condo_plus/components/geral/load_button.dart';
import 'package:condo_plus/components/popup/custom_rect_tween.dart';
import 'package:condo_plus/components/popup/open_popup_button.dart';
import 'package:condo_plus/components/reservas/reserva_button.dart';
import 'package:condo_plus/components/reservas/reserva_button_skeleton.dart';
import 'package:condo_plus/models/apartamento.dart';
import 'package:condo_plus/models/reserva.dart';
import 'package:condo_plus/screens/custom_drawer.dart';
import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ReservasPage extends StatefulWidget {
  final dynamic usuarioLogado;

  const ReservasPage({required this.usuarioLogado});

  @override
  State<ReservasPage> createState() => _ReservasPageState();
}

class _ReservasPageState extends State<ReservasPage> {
  static const List<String> filtros = ['Todas', 'Finalizada', 'Paga', 'Aguardando pagamento', 'Cancelada'];
  List<dynamic> _reservas = [];
  late bool _isLoading;
  late int filtroSelecionado;

  @override
  void initState() {
    filtroSelecionado = 0;
    obterReservas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reservas')),
      drawer: CustomDrawer(usuarioLogado: widget.usuarioLogado, index: 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DefaultValues.horizontalPadding),
        child: Column(
          children: [
            AddFilterButton(filtros: filtros, filtroSelecionado: filtroSelecionado, tag: 'reservas-filter', callback: (novoFiltro) => atualizarFiltro(novoFiltro)),
            _isLoading ? ReservaButtonSkeletonList() : ReservaButtonList(reservas: _reservas, filtros: filtros, filtroSelecionado: filtroSelecionado),
          ],
        ),
      ),
      floatingActionButton: AddReservaButton(apartamento: Apartamento(bloco: '_blocoSelecionado', numApto: '_aptoSelecionado')),
    );
  }

  void obterReservas() async {
    setState(() => _isLoading = true);

    var caminho = 'json/reservas.json';
    try {
      final String response = await rootBundle.loadString(caminho);
      final data = await json.decode(response);
      setState(() => _reservas = data['reservas'].map((data) => Reserva.fromJson(data)).toList());
    } catch (exception) {
      _reservas = [];
    }

    await Future.delayed(Duration(seconds: DefaultValues.timeToLoadReservas));

    setState(() => _isLoading = false);
  }

  Future<void> atualizarFiltro(int novoFiltro) async {
    setState(() {
      _isLoading = true;
      filtroSelecionado = novoFiltro;
    });
    await Future.delayed(Duration(seconds: DefaultValues.timeToLoadReservas));
    setState(() => _isLoading = false);
  }
}

class AddReservaButton extends StatelessWidget {
  final Apartamento apartamento;

  const AddReservaButton({
    required this.apartamento,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return OpenPopupButton(
      popupCard: AddReservaPopupCard(apartamento: apartamento, tag: 'add-reserva-hero'),
      tag: 'add-reserva-hero',
      child: Material(
        borderOnForeground: true,
        color: colorScheme.primary,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: const Icon(
            CupertinoIcons.calendar_badge_plus,
            size: 24,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}

class AddReservaPopupCard extends StatefulWidget {
  final Apartamento apartamento;
  final String tag;

  const AddReservaPopupCard({
    required this.apartamento,
    required this.tag,
  });

  @override
  State<AddReservaPopupCard> createState() => _AddReservaPopupCardState();
}

class _AddReservaPopupCardState extends State<AddReservaPopupCard> {
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

    return CustomBlurredContainer(
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
