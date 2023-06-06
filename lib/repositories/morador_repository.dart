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
}
