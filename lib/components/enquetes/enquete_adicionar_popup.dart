import 'package:condo_plus/controllers/enquetes_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:condo_plus/components/geral/blurred_container.dart';
import 'package:condo_plus/components/popup/custom_rect_tween.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EnqueteAdicionarPopup extends StatefulWidget {
  final String tag;

  const EnqueteAdicionarPopup({required this.tag});

  @override
  State<EnqueteAdicionarPopup> createState() => _EnqueteAdicionarPopupState();
}

class _EnqueteAdicionarPopupState extends State<EnqueteAdicionarPopup> {
  final _formKey = GlobalKey<FormState>();
  final _enquetesController = Get.put(EnquetesController());
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _dataFimController = TextEditingController();

  bool _carregando = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        BlurredContainer(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 90.0),
              child: Hero(
                tag: widget.tag,
                createRectTween: (begin, end) {
                  return CustomRectTween(begin: begin!, end: end!);
                },
                child: Material(
                  color: colorScheme.primary,
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 15.0),
                            buildTitulo(colorScheme),
                            const SizedBox(height: 10.0),
                            buildDataFim(context, colorScheme),
                            const SizedBox(height: 10.0),
                            buildDescricao(colorScheme),
                            ElevatedButton(
                                onPressed: cadastrar,
                                style: ElevatedButton.styleFrom(backgroundColor: colorScheme.secondary),
                                child: Text(
                                  'Cadastrar',
                                  style: TextStyle(fontSize: 18, color: Colors.white),
                                )),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        _carregando
            ? const Stack(
                children: [
                  ModalBarrier(dismissible: false),
                  BlurredContainer(
                    child: Center(
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(color: Colors.white54),
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox(),
      ],
    );
  }

  Widget buildTitulo(ColorScheme colorScheme) {
    return TextFormField(
      minLines: 1,
      maxLines: 2,
      autocorrect: false,
      controller: _tituloController,
      decoration: const InputDecoration(label: Text("Título")),
      style: TextStyle(color: colorScheme.onSecondary),
      inputFormatters: [LengthLimitingTextInputFormatter(60)],
      validator: (value) {
        if (value!.removeAllWhitespace.length < 5) return 'O título deve ter no entre 5 e 80 caracteres';
        return null;
      },
      onSaved: (value) => _tituloController.value = _tituloController.value.copyWith(text: value),
    );
  }

  Widget buildDescricao(ColorScheme colorScheme) {
    return TextFormField(
      autocorrect: false,
      minLines: 5,
      maxLines: 100,
      maxLength: 2000,
      scrollPhysics: NeverScrollableScrollPhysics(),
      controller: _descricaoController,
      decoration: InputDecoration(label: Text("Descrição"), alignLabelWithHint: true),
      style: TextStyle(color: colorScheme.onSecondary, fontSize: 14),
      validator: (value) {
        if (value!.removeAllWhitespace.length < 10) return 'A descrição deve ter no mínimo 10 caracteres';
        return null;
      },
      onSaved: (value) => _descricaoController.value = _descricaoController.value.copyWith(text: value),
    );
  }

  Widget buildDataFim(BuildContext context, ColorScheme colorScheme) {
    return TextFormField(
      controller: _dataFimController,
      readOnly: true,
      decoration: InputDecoration(label: Text('Data de encerramento')),
      style: TextStyle(color: colorScheme.onSecondary),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Selecione uma data';
        }
        return null;
      },
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.3,
              color: Get.isDarkMode ? Color.fromRGBO(48, 48, 48, 1) : Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text('Done', style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.blue)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: CupertinoDatePicker(
                      minimumDate: DateTime.now(),
                      initialDateTime: _dataFimController.text.isEmpty ? DateTime.now() : DateFormat('dd/MM/yyyy').parse(_dataFimController.text),
                      mode: CupertinoDatePickerMode.date,
                      dateOrder: DatePickerDateOrder.dmy,
                      onDateTimeChanged: (date) {
                        setState(() {
                          _dataFimController.text = DateFormat('dd/MM/yyyy').format(date);
                        });
                      },
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  bool camposValidos() {
    return _formKey.currentState!.validate();
  }

  void cadastrar() async {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() => _carregando = true);

    if (!camposValidos()) {
      setState(() => _carregando = false);
      return;
    }

    try {
      await _enquetesController.cadastrar(
        titulo: _tituloController.text,
        mensagem: _descricaoController.text,
        dataFim: _dataFimController.text,
      );

      Navigator.pop(context);
    } on Exception catch (e) {
      debugPrint('$e');
    }
    if (mounted) setState(() => _carregando = false);
  }
}
