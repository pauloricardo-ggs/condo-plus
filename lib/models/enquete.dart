class Enquete {
  int id;
  String nome;
  String descricao;
  int aprovado;
  int rejeitado;

  Enquete({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.aprovado,
    required this.rejeitado,
  });

  factory Enquete.fromJson(Map<String, dynamic> map) {
    return Enquete(
      id: map['id'] as int,
      nome: map['nome'] as String,
      descricao: map['descricao'] as String,
      aprovado: map['aprovado'] as int,
      rejeitado: map['rejeitado'] as int,
    );
  }
}
