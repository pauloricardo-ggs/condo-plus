import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:condo_plus/models/perfil_usuario.dart';

class MoradorRepository {
  final firebaseFirestore = FirebaseFirestore.instance;

  final collection = 'perfilUsuarios';

  Stream<List<PerfilUsuario>> obterPorApartamento(String bloco, String apartamento) {
    return firebaseFirestore
        .collection(collection)
        .where('bloco', isEqualTo: bloco)
        .where('apartamento', isEqualTo: apartamento)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => PerfilUsuario.fromMap(doc.data())).toList());
  }

  Future<PerfilUsuario?> obterProprietario(String bloco, String apartamento) async {
    var query = await firebaseFirestore.collection(collection).where('bloco', isEqualTo: bloco).where('apartamento', isEqualTo: apartamento).where('proprietario', isEqualTo: true).get();

    if (query.docs.isEmpty) return null;
    return PerfilUsuario.fromMap(query.docs.first.data());
  }

  Future<PerfilUsuario?> obterSindico() async {
    final query = await firebaseFirestore.collection(collection).where('cargo', isEqualTo: 'sindico').get();

    if (query.docs.isEmpty) return null;
    return PerfilUsuario.fromMap(query.docs.first.data());
  }

  Future<PerfilUsuario?> obterPorId(String id) async {
    final query = await firebaseFirestore.collection(collection).where('id', isEqualTo: id).get();

    if (query.docs.isEmpty) return null;
    return PerfilUsuario.fromMap(query.docs.first.data());
  }

  Future<void> rebaixarParaMorador() async {
    var sindico = await obterSindico();
    if (sindico == null) return;
    sindico.cargo = 'morador';
    final doc = firebaseFirestore.collection(collection).doc(sindico.id);
    await doc.update(sindico.toMap());
  }

  Future<void> promoverParaSindico(String moradorId) async {
    var morador = await obterPorId(moradorId);
    if (morador == null) return;
    morador.cargo = 'sindico';
    final doc = firebaseFirestore.collection(collection).doc(moradorId);
    await doc.update(morador.toMap());
  }

  Future<void> retirarPostoProprietario(String bloco, String apartamento) async {
    var proprietario = await obterProprietario(bloco, apartamento);
    if (proprietario == null) return;
    proprietario.proprietario = false;
    final doc = firebaseFirestore.collection(collection).doc(proprietario.id);
    await doc.update(proprietario.toMap());
  }

  Future<void> adicionarPostoProprietario(String moradorId) async {
    var morador = await obterPorId(moradorId);
    if (morador == null) return;
    morador.proprietario = true;
    final doc = firebaseFirestore.collection(collection).doc(moradorId);
    await doc.update(morador.toMap());
  }
}
