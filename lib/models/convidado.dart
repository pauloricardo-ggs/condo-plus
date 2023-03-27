class Convidado {
  String nome;

  Convidado({
    required this.nome,
  });

  factory Convidado.fromJson(Map<String, dynamic> json) {
    return new Convidado(
      nome: json['nome'],
    );
  }
}
