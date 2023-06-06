import 'dart:convert';

class Enquete {
  String id;
  String titulo;
  String descricao;
  String status;
  String dataFim;
  int quantidadeAprovado;
  int quantidadeRejeitado;

  Enquete({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.status,
    required this.dataFim,
    required this.quantidadeAprovado,
    required this.quantidadeRejeitado,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'status': status,
      'dataFim': dataFim,
      'quantidadeAprovado': quantidadeAprovado,
      'quantidadeRejeitado': quantidadeRejeitado,
    };
  }

  factory Enquete.fromMap(Map<String, dynamic> map) {
    return Enquete(
      id: map['id'] as String,
      titulo: map['titulo'] as String,
      descricao: map['descricao'] as String,
      status: map['status'] as String,
      dataFim: map['dataFim'] as String,
      quantidadeAprovado: map['quantidadeAprovado'] as int,
      quantidadeRejeitado: map['quantidadeRejeitado'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Enquete.fromJson(String source) => Enquete.fromMap(json.decode(source) as Map<String, dynamic>);
}
