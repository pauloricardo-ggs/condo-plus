import 'dart:convert';

class PerfilUsuario {
  final String nomeCompleto;
  final String cpf;
  final String dataNascimento;
  final String telefone;
  final String bloco;
  final String apartamento;
  final String foto;
  final String cargo;

  const PerfilUsuario({
    required this.nomeCompleto,
    required this.cpf,
    required this.dataNascimento,
    required this.telefone,
    required this.bloco,
    required this.apartamento,
    required this.foto,
    required this.cargo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nomeCompleto': nomeCompleto,
      'cpf': cpf,
      'dataNascimento': dataNascimento,
      'telefone': telefone,
      'bloco': bloco,
      'apartamento': apartamento,
      'foto': foto,
      'cargo': cargo,
    };
  }

  factory PerfilUsuario.fromMap(Map<String, dynamic> map) {
    return PerfilUsuario(
      nomeCompleto: map['nomeCompleto'] as String,
      cpf: map['cpf'] as String,
      dataNascimento: map['dataNascimento'] as String,
      telefone: map['telefone'] as String,
      bloco: map['bloco'] as String,
      apartamento: map['apartamento'] as String,
      foto: map['foto'] as String,
      cargo: map['cargo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PerfilUsuario.fromJson(String source) => PerfilUsuario.fromMap(json.decode(source) as Map<String, dynamic>);
}
