import 'package:condo_plus/dev_pack.dart';
import 'package:condo_plus/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _authRepository = Get.put(AuthRepository());
  final _devPack = const DevPack();

  User? _usuario;
  User? get usuario => _usuario;

  AuthController() {
    _atualizarUsuarioLogado();
  }

  Future<void> logar({required String email, required String senha}) async {
    try {
      await _authRepository.logar(email, senha);
      _atualizarUsuarioLogado();
    } on FirebaseAuthException {
      _devPack.notificaoErro(mensagem: 'Usuário ou senha inválidos');
      rethrow;
    }
  }

  Future<void> cadastrar({required String email, required String senha, required String nome, required String cpf, required String dataNascimento, required String telefone}) async {
    try {
      var credential = await _authRepository.cadastrarUsuario(email, senha);

      final json = {
        'nomeCompleto': nome,
        'cpf': cpf,
        'dataNascimento': dataNascimento,
        'telefone': telefone,
      };

      await _authRepository.cadastrarPerfilUsuario(credential.user!.uid, json);

      _usuario = credential.user;
      _devPack.notificaoSucesso(mensagem: 'Usuário cadastrado com sucesso!');
      _atualizarUsuarioLogado();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        _devPack.notificaoErro(mensagem: 'Já existe uma conta com o email informado');
      } else {
        _devPack.notificaoErro(mensagem: e.code);
      }
    }
  }

  Future<void> sair() async {
    try {
      await _authRepository.sair();
      _atualizarUsuarioLogado();
    } on FirebaseAuthException catch (e) {
      _devPack.notificaoErro(mensagem: e.code);
    }
  }

  _atualizarUsuarioLogado() {
    _usuario = _authRepository.obterUsuarioLogado();
  }

  bool logado() {
    return usuario != null;
  }
}
