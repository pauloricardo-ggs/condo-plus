import 'dart:io';

import 'package:condo_plus/dev_pack.dart';
import 'package:condo_plus/models/perfil_usuario.dart';
import 'package:condo_plus/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _authRepository = Get.put(AuthRepository());
  final _devPack = const DevPack();

  User? _usuario;
  User? get usuario => _usuario;

  PerfilUsuario? _perfil;
  PerfilUsuario? get perfil => _perfil;

  Future<void> logar({required String email, required String senha}) async {
    try {
      await _authRepository.logar(email, senha);
      await atualizarUsuarioEPerfil();
    } on FirebaseAuthException {
      _devPack.notificaoErro(mensagem: 'Usuário ou senha inválidos');
      rethrow;
    }
  }

  Future<void> cadastrar({
    required String email,
    required String senha,
    required String nome,
    required String cpf,
    required String dataNascimento,
    required String telefone,
    required String bloco,
    required String apartamento,
    required File foto,
    required String cargo,
    required bool proprietario,
  }) async {
    try {
      var credential = await _authRepository.cadastrarUsuario(email, senha);

      var diretorioFoto = await _authRepository.uploadFotoPerfil(credential.user!.uid, foto);

      final perfil = PerfilUsuario(
        id: credential.user!.uid,
        email: email,
        nomeCompleto: nome,
        cpf: cpf,
        dataNascimento: dataNascimento,
        telefone: telefone,
        bloco: bloco,
        apartamento: apartamento,
        foto: diretorioFoto,
        cargo: cargo,
        proprietario: proprietario,
      );

      await _authRepository.cadastrarPerfilUsuario(credential.user!.uid, perfil.toMap());

      _usuario = credential.user;
      _devPack.notificaoSucesso(mensagem: 'Usuário cadastrado com sucesso!');
      await atualizarUsuarioEPerfil();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        _devPack.notificaoErro(mensagem: 'Já existe uma conta com o email informado');
      } else {
        _devPack.notificaoErro(mensagem: e.code);
      }
      rethrow;
    }
  }

  Future<void> sair() async {
    try {
      await _authRepository.sair();
      await atualizarUsuarioEPerfil();
    } on FirebaseAuthException catch (e) {
      _devPack.notificaoErro(mensagem: e.code);
    }
  }

  Future<void> atualizarUsuarioEPerfil() async {
    _usuario = _authRepository.obterUsuarioLogado();
    _perfil = await _authRepository.obterPerfilUsuario(_usuario?.uid);
  }

  bool ehAdministracao() {
    return _perfil!.cargo == 'administracao';
  }

  bool ehSindico() {
    return _perfil!.cargo == 'sindico';
  }

  bool ehAdministracaoOuSindico() {
    return ehAdministracao() || ehSindico();
  }

  bool ehMorador() {
    if (_perfil == null) return true;
    return _perfil!.cargo == 'morador';
  }

  Future<PerfilUsuario?> obterPerfilUsuarioLogado() async {
    return await _authRepository.obterPerfilUsuarioLogado();
  }

  bool logado() {
    return usuario != null;
  }
}
