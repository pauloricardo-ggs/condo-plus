import 'dart:core';
import 'dart:io';

import 'package:condo_plus/controllers/auth_controller.dart';
import 'package:condo_plus/dev_pack.dart';
import 'package:condo_plus/models/aviso.dart';
import 'package:condo_plus/repositories/aviso_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AvisosController extends GetxController {
  final _avisoRepository = Get.put(AvisoRepository());
  final _authController = Get.put(AuthController());
  final _devPack = const DevPack();

  // final RxList<Aviso> _avisos = <Aviso>[].obs;
  // RxList<Aviso> get avisos => _avisos;

  Future<void> cadastrar({
    required File foto,
    required String titulo,
    required String mensagem,
  }) async {
    try {
      var perfil = await _authController.obterPerfilUsuarioLogado();
      var id = Uuid().v4();
      var diretorioFoto = await _avisoRepository.uploadImagem(id, foto);

      final aviso = Aviso(
        id: id,
        perfilUsuarioId: perfil!.id,
        perfilUsuarioNome: perfil.nomeCompleto,
        perfilUsuarioCargo: perfil.cargo,
        dataCadastro: DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()),
        titulo: titulo,
        descricao: mensagem,
        imagem: diretorioFoto,
      );

      await _avisoRepository.cadastrar(id, aviso.toMap());

      _devPack.notificaoSucesso(mensagem: 'Aviso cadastrado com sucesso!');
    } catch (e) {
      _devPack.notificaoErro(mensagem: '$e');
      rethrow;
    }
  }

  Stream<List<Aviso>> obterPorApartamento(String bloco, String apartamento) {
    return _avisoRepository.listar();
  }
}
