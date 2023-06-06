import 'dart:core';

import 'package:condo_plus/dev_pack.dart';
import 'package:condo_plus/models/enquete.dart';
import 'package:condo_plus/repositories/enquete_repository.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class EnquetesController extends GetxController {
  final _enqueteRepository = Get.put(EnqueteRepository());
  final _devPack = const DevPack();

  Future<void> cadastrar({
    required String titulo,
    required String mensagem,
    required String dataFim,
  }) async {
    try {
      var id = Uuid().v4();

      final enquete = Enquete(
        id: id,
        titulo: titulo,
        descricao: mensagem,
        quantidadeAprovado: 0,
        quantidadeRejeitado: 0,
        status: 'Andamento',
        dataFim: dataFim,
      );

      await _enqueteRepository.cadastrar(id, enquete.toMap());

      _devPack.notificaoSucesso(mensagem: 'Enquete cadastrada com sucesso!');
    } catch (e) {
      _devPack.notificaoErro(mensagem: '$e');
      rethrow;
    }
  }

  Stream<List<Enquete>> listar(String filtro) {
    return _enqueteRepository.listar(filtro);
  }
}
