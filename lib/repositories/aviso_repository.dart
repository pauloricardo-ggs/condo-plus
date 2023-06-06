import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:condo_plus/models/aviso.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AvisoRepository {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;

  final collection = 'avisos';

  Future<void> cadastrar(String id, Map<String, dynamic> aviso) async {
    try {
      await firebaseFirestore.collection(collection).doc(id).set(aviso);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<String> uploadImagem(String avisoId, File foto) async {
    final diretorio = firebaseStorage.ref().child('imagens/avisos/$avisoId');
    await diretorio.putFile(foto);
    return await diretorio.getDownloadURL();
  }

  Stream<List<Aviso>> listar() {
    return firebaseFirestore.collection(collection).snapshots().map((snapshot) => snapshot.docs.map((doc) => Aviso.fromMap(doc.data())).toList());
  }
}
