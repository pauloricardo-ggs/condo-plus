import 'dart:io';

import 'package:condo_plus/components/geral/blurred_container.dart';
import 'package:condo_plus/components/popup/custom_rect_tween.dart';
import 'package:condo_plus/controllers/auth_controller.dart';
import 'package:condo_plus/dev_pack.dart';
import 'package:condo_plus/models/apartamento.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MoradorAdicionarPopup extends StatefulWidget {
  final Apartamento apartamento;
  final String tag;

  const MoradorAdicionarPopup({
    required this.apartamento,
    required this.tag,
  });

  @override
  State<MoradorAdicionarPopup> createState() => _MoradorAdicionarPopupState();
}

class _MoradorAdicionarPopupState extends State<MoradorAdicionarPopup> {
  bool _carregando = false;
  File? _foto = null;

  final _formKey = GlobalKey<FormState>();
  final _devPack = const DevPack();

  final _authController = Get.put(AuthController());
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _dataNascimentoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildFoto(context),
                            buildNomeCompleto(colorScheme),
                            const SizedBox(height: 17.0),
                            Row(
                              children: [
                                Expanded(child: buildCpf(colorScheme)),
                                const SizedBox(width: 17.0),
                                Expanded(child: buildTelefone(colorScheme)),
                              ],
                            ),
                            const SizedBox(height: 17.0),
                            buildEmail(colorScheme),
                            const SizedBox(height: 17.0),
                            buildDataDeNascimento(context, colorScheme),
                            const SizedBox(height: 17.0),
                            Row(
                              children: [
                                Expanded(child: buildBloco(colorScheme)),
                                const SizedBox(width: 12.0),
                                Expanded(child: buildApartamento(colorScheme)),
                              ],
                            ),
                            const SizedBox(height: 25.0),
                            buildBotaoCadastrar(colorScheme),
                            const SizedBox(height: 20.0),
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

  Widget buildBotaoCadastrar(ColorScheme colorScheme) {
    return ElevatedButton(
      onPressed: _carregando ? null : () => cadastrar(),
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(colorScheme.secondary),
        padding: MaterialStatePropertyAll(EdgeInsets.all(12.0)),
      ),
      child: Text('Cadastrar', style: TextStyle(fontSize: 20)),
    );
  }

  Widget buildNomeCompleto(ColorScheme colorScheme) {
    return TextFormField(
      minLines: 1,
      maxLines: 2,
      autocorrect: false,
      controller: _nomeController,
      decoration: const InputDecoration(label: Text("Nome completo")),
      style: TextStyle(color: colorScheme.onSecondary),
      inputFormatters: [LengthLimitingTextInputFormatter(60)],
      validator: (value) {
        if (value!.removeAllWhitespace.length < 5) return 'O nome deve ter no entre 5 e 80 caracteres';
        return null;
      },
      onSaved: (value) => _nomeController.value = _nomeController.value.copyWith(text: value),
    );
  }

  Widget buildCpf(ColorScheme colorScheme) {
    final mask = MaskTextInputFormatter(mask: '###.###.###-##', filter: {'#': RegExp(r'[0-9]')});
    return TextFormField(
      autocorrect: false,
      controller: _cpfController,
      decoration: const InputDecoration(label: Text("CPF")),
      style: TextStyle(color: colorScheme.onSecondary),
      keyboardType: TextInputType.number,
      inputFormatters: [mask],
      validator: (value) {
        if (value == null || value.length < 11) {
          return 'CPF inválido';
        }
        return null;
      },
      onSaved: (value) => _cpfController.value = _cpfController.value.copyWith(text: value),
    );
  }

  Widget buildTelefone(ColorScheme colorScheme) {
    final mask = MaskTextInputFormatter(mask: '(##) #####-####', filter: {'#': RegExp(r'[0-9]')});
    return TextFormField(
      autocorrect: false,
      controller: _telefoneController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(label: Text("Telefone celular")),
      style: TextStyle(color: colorScheme.onSecondary),
      inputFormatters: [mask],
      validator: (value) {
        if (value == null || value.length < 11) {
          return 'Telefone inválido';
        }
        return null;
      },
      onSaved: (value) => _telefoneController.value = _telefoneController.value.copyWith(text: value),
    );
  }

  Widget buildEmail(ColorScheme colorScheme) {
    return TextFormField(
      autocorrect: false,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(label: Text("Email")),
      style: TextStyle(color: colorScheme.onSecondary),
      inputFormatters: [LengthLimitingTextInputFormatter(60)],
      validator: (value) {
        if (value != null && RegExp('^[a-z0-9.]+@[a-z0-9]+.[a-z]+.([a-z]+)?').hasMatch(value)) {
          return null;
        }
        return 'Email inválido';
      },
      onSaved: (value) => _emailController.value = _emailController.value.copyWith(text: value),
    );
  }

  Widget buildFoto(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: GestureDetector(
        onTap: () {
          showCupertinoModalPopup(context: context, builder: buildSelecaoOrigem);
        },
        child: Container(
          width: 90,
          height: 90,
          decoration:
              BoxDecoration(color: colorScheme.secondary, shape: BoxShape.circle, image: _foto == null ? null : DecorationImage(image: FileImage(_foto!)), border: Border.all(color: Colors.white60)),
          child: _foto == null
              ? Icon(
                  Icons.add_a_photo_outlined,
                  size: 40,
                  color: Colors.white60,
                )
              : SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget buildSelecaoOrigem(BuildContext context) {
    return CupertinoActionSheet(
      title: const Text("Adicionar foto"),
      message: const Text("De onde gostaria de adicionar a foto?"),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () async {
            Navigator.pop(context);
            var imagem = await obterImagem(source: ImageSource.camera);
            setState(() => _foto = imagem);
          },
          child: const Text("Câmera"),
        ),
        CupertinoActionSheetAction(
          onPressed: () async {
            Navigator.pop(context);
            var imagem = await obterImagem(source: ImageSource.gallery);
            setState(() => _foto = imagem);
          },
          child: const Text("Galeria"),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text("Cancelar"),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget buildApartamento(ColorScheme colorScheme) {
    return TextFormField(
      initialValue: widget.apartamento.numApto,
      readOnly: true,
      decoration: InputDecoration(label: Text('Apartamento')),
      style: TextStyle(color: colorScheme.onSecondary),
    );
  }

  Widget buildBloco(ColorScheme colorScheme) {
    return TextFormField(
      initialValue: widget.apartamento.bloco,
      readOnly: true,
      decoration: InputDecoration(label: Text('Bloco')),
      style: TextStyle(color: colorScheme.onSecondary),
    );
  }

  Widget buildDataDeNascimento(BuildContext context, ColorScheme colorScheme) {
    return TextFormField(
      controller: _dataNascimentoController,
      readOnly: true,
      decoration: InputDecoration(label: Text('Data de Nascimento')),
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
                      initialDateTime: _dataNascimentoController.text.isEmpty ? DateTime.now() : DateTime.parse(_dataNascimentoController.text),
                      mode: CupertinoDatePickerMode.date,
                      dateOrder: DatePickerDateOrder.dmy,
                      minimumYear: DateTime.now().year - 120,
                      maximumYear: DateTime.now().year,
                      maximumDate: DateTime.now(),
                      onDateTimeChanged: (date) {
                        var datadsahd = DateFormat('dd/MM/yyyy').format(date.toLocal()).toString();
                        setState(() {
                          _dataNascimentoController.text = datadsahd;
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
    final valido = _formKey.currentState!.validate();
    var dataNaoVazia = _dataNascimentoController.text.isNotEmpty;
    return valido && dataNaoVazia;
  }

  void cadastrar() async {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() => _carregando = true);

    if (_foto == null) {
      _devPack.notificaoErro(mensagem: 'Adicione uma foto');
      camposValidos();
      setState(() => _carregando = false);
      return;
    }

    if (!camposValidos()) {
      setState(() => _carregando = false);
      return;
    }

    try {
      await _authController.cadastrar(
          email: _emailController.text,
          senha: 'Teste@123',
          nome: _nomeController.text,
          cpf: _cpfController.text,
          dataNascimento: _dataNascimentoController.text,
          telefone: _telefoneController.text,
          bloco: widget.apartamento.bloco,
          apartamento: widget.apartamento.numApto,
          foto: _foto!,
          cargo: 'morador');

      Navigator.pop(context);
    } on Exception catch (e) {
      debugPrint('$e');
    }
    if (mounted) setState(() => _carregando = false);
  }

  Future<File?> obterImagem({required ImageSource source}) async {
    var picker = ImagePicker();
    try {
      final image = await picker.pickImage(source: source);
      if (image == null) return null;
      var croppedImage = await cortarImagens(File(image!.path));
      return croppedImage;
    } on Exception catch (e) {
      debugPrint('Failed to pick image: $e');
      return null;
    }
  }

  Future<File?> cortarImagens(File imageFile) async {
    var croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }
}
