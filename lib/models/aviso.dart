import 'dart:convert';

class Aviso {
  String id;
  String perfilUsuarioId;
  String perfilUsuarioNome;
  String perfilUsuarioCargo;
  String dataCadastro;
  String titulo;
  String descricao;
  String imagem;
  Aviso({
    required this.id,
    required this.perfilUsuarioId,
    required this.perfilUsuarioNome,
    required this.perfilUsuarioCargo,
    required this.dataCadastro,
    required this.titulo,
    required this.descricao,
    required this.imagem,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'perfilUsuarioId': perfilUsuarioId,
      'perfilUsuarioNome': perfilUsuarioNome,
      'perfilUsuarioCargo': perfilUsuarioCargo,
      'dataCadastro': dataCadastro,
      'titulo': titulo,
      'descricao': descricao,
      'imagem': imagem,
    };
  }

  factory Aviso.fromMap(Map<String, dynamic> map) {
    return Aviso(
      id: map['id'] as String,
      perfilUsuarioId: map['perfilUsuarioId'] as String,
      perfilUsuarioNome: map['perfilUsuarioNome'] as String,
      perfilUsuarioCargo: map['perfilUsuarioCargo'] as String,
      dataCadastro: map['dataCadastro'] as String,
      titulo: map['titulo'] as String,
      descricao: map['descricao'] as String,
      imagem: map['imagem'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Aviso.fromJson(String source) => Aviso.fromMap(json.decode(source) as Map<String, dynamic>);
}
