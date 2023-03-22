import 'package:condo_plus/models/pessoa.dart';

class Funcionario extends Pessoa {
  Funcionario({
    required super.nome,
    required super.cpf,
    required super.email,
    required super.telefone,
    required super.dataNascimento,
    required super.foto,
    required super.cargo,
  });

  factory Funcionario.fromJson(Map<String, dynamic> json) {
    return new Funcionario(
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
