import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:condo_plus/models/enquete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EnqueteRepository {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;

  final collection = 'enquetes';

  Future<void> cadastrar(String id, Map<String, dynamic> enquete) async {
    try {
      await firebaseFirestore.collection(collection).doc(id).set(enquete);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Stream<List<Enquete>> listar(String filtro) {
    if (filtro == 'Todas') {
      return firebaseFirestore.collection(collection).snapshots().map((snapshot) => snapshot.docs.map((doc) => Enquete.fromMap(doc.data())).toList());
    }
    return firebaseFirestore.collection(collection).where('status', isEqualTo: filtro).snapshots().map((snapshot) => snapshot.docs.map((doc) => Enquete.fromMap(doc.data())).toList());
  }
}
