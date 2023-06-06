import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:condo_plus/models/perfil_usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthRepository {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;

  final perfisCollection = 'perfilUsuarios';

  Future<void> logar(String email, String senha) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: senha);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<UserCredential> cadastrarUsuario(String email, String senha) async {
    try {
      return await firebaseAuth.createUserWithEmailAndPassword(email: email, password: senha);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<void> cadastrarPerfilUsuario(String usuarioId, Map<String, dynamic> perfilUsuario) async {
    try {
      await firebaseFirestore.collection(perfisCollection).doc(usuarioId).set(perfilUsuario);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<String> uploadFotoPerfil(String usuarioId, File foto) async {
    final diretorio = firebaseStorage.ref().child('imagens/perfis/$usuarioId');
    await diretorio.putFile(foto);
    return await diretorio.getDownloadURL();
  }

  Future sair() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException {
      rethrow;
    }
  }

  User? obterUsuarioLogado() {
    return firebaseAuth.currentUser;
  }

  Future<PerfilUsuario?> obterPerfilUsuario(String? usuarioId) async {
    if (usuarioId == null) return null;
    final doc = await firebaseFirestore.collection(perfisCollection).doc(usuarioId).get();
    final map = doc.data();
    if (map != null) return PerfilUsuario.fromMap(map);
    return null;
  }
}
