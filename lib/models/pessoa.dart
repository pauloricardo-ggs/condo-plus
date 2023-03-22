class Pessoa {
  String nome;
  String cpf;
  String email;
  String telefone;
  String dataNascimento;
  String foto;
  String cargo;

  Pessoa({
    required this.nome,
    required this.cpf,
    required this.email,
    required this.telefone,
    required this.dataNascimento,
    required this.foto,
    required this.cargo,
  });

  factory Pessoa.fromJson(Map<String, dynamic> json) {
    return new Pessoa(
      nome: json['nome'],
      cpf: json['cpf'],
      email: json['email'],
      telefone: json['telefone'],
      dataNascimento: json['dataNascimento'],
      foto: json['foto'],
      cargo: json['cargo'],
    );
  }
}
