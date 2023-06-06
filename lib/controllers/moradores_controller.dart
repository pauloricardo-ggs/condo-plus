import 'package:condo_plus/models/perfil_usuario.dart';
import 'package:condo_plus/repositories/morador_repository.dart';
import 'package:get/get.dart';

class MoradoresController extends GetxController {
  final _moradorRepository = Get.put(MoradorRepository());

  Stream<List<PerfilUsuario>> obterPorApartamento(String bloco, String apartamento) {
    return _moradorRepository.obterPorApartamento(bloco, apartamento);
  }

  Future<PerfilUsuario?> obterProprietario(String bloco, String apartamento) async {
    return await _moradorRepository.obterProprietario(bloco, apartamento);
  }

  Future<bool> proprietarioJaEstaCadastrado(String bloco, String apartamento) async {
    return await _moradorRepository.obterProprietario(bloco, apartamento) != null;
  }

  Future<void> promoverParaSindico(String moradorId) async {
    await _moradorRepository.rebaixarParaMorador();
    await _moradorRepository.promoverParaSindico(moradorId);
  }

  Future<void> adicionarPostoProprietario(String moradorId, String bloco, String apartamento) async {
    await _moradorRepository.retirarPostoProprietario(bloco, apartamento);
    await _moradorRepository.adicionarPostoProprietario(moradorId);
  }
}
