import 'dart:io';

import 'package:condo_plus/components/geral/blurred_container.dart';
import 'package:condo_plus/components/popup/custom_rect_tween.dart';
import 'package:condo_plus/controllers/avisos_controller.dart';
import 'package:condo_plus/dev_pack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AvisoAdicionarPopup extends StatefulWidget {
  final String tag;

  const AvisoAdicionarPopup({
    required this.tag,
  });

  @override
  State<AvisoAdicionarPopup> createState() => _AvisoAdicionarPopupState();
}

class _AvisoAdicionarPopupState extends State<AvisoAdicionarPopup> {
  bool _carregando = false;
  File? _foto = null;

  final _formKey = GlobalKey<FormState>();
  final _devPack = const DevPack();

  final _avisoController = Get.put(AvisosController());
  final _tituloController = TextEditingController();
  final _mensagemController = TextEditingController();

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
                            const SizedBox(height: 17.0),
                            buildFoto(context),
                            const SizedBox(height: 17.0),
                            buildTitulo(colorScheme),
                            const SizedBox(height: 17.0),
                            buildAviso(colorScheme),
                            const SizedBox(height: 20.0),
                            buildBotaoCadastrar(colorScheme),
                            const SizedBox(height: 25.0),
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

  Widget buildAviso(ColorScheme colorScheme) {
    return TextFormField(
      autocorrect: false,
      minLines: 5,
      maxLines: 100,
      maxLength: 2000,
      scrollPhysics: NeverScrollableScrollPhysics(),
      controller: _mensagemController,
      decoration: InputDecoration(label: Text("Mensagem"), alignLabelWithHint: true),
      style: TextStyle(color: colorScheme.onSecondary, fontSize: 14),
      validator: (value) {
        if (value!.removeAllWhitespace.length < 10) return 'A mensagem deve ter no mínimo 10 caracteres';
        return null;
      },
      onSaved: (value) => _mensagemController.value = _mensagemController.value.copyWith(text: value),
    );
  }

  Widget buildFoto(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup(context: context, builder: buildSelecaoOrigem);
      },
      child: AspectRatio(
        aspectRatio: 16 / 10,
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            color: colorScheme.secondary,
            image: _foto == null ? null : DecorationImage(image: FileImage(_foto!)),
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: Colors.white60),
          ),
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

  bool camposValidos() {
    return _formKey.currentState!.validate();
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
      await _avisoController.cadastrar(foto: _foto!, titulo: _tituloController.text, mensagem: _mensagemController.text);

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
      var croppedImage = await cortarImagens(File(image.path));
      return croppedImage;
    } on Exception catch (e) {
      debugPrint('Failed to pick image: $e');
      return null;
    }
  }

  Future<File?> cortarImagens(File imageFile) async {
    var croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 10),
    );
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }
}
