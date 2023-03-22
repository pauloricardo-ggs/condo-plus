import 'package:condo_plus/models/apartamento.dart';
import 'package:condo_plus/models/pessoa.dart';

class Morador extends Pessoa {
  Apartamento apartamento;
  bool proprietario;

  Morador({
    required this.proprietario,
    required this.apartamento,
    required super.nome,
    required super.cpf,
    required super.email,
    required super.telefone,
    required super.dataNascimento,
    required super.foto,
    required super.cargo,
  });

  factory Morador.fromJson(Map<String, dynamic> json) {
    return new Morador(
      apartamento: Apartamento.fromJson(json['apartamento']),
      nome: json['nome'],
      cpf: json['cpf'],
      email: json['email'],
      telefone: json['telefone'],
      dataNascimento: json['dataNascimento'],
      foto: json['foto'],
      cargo: json['cargo'],
      proprietario: json['proprietario'],
    );
  }
}
