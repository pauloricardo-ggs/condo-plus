import 'dart:convert';

class PerfilUsuario {
  String id;
  String email;
  String nomeCompleto;
  String cpf;
  String dataNascimento;
  String telefone;
  String bloco;
  String apartamento;
  String foto;
  String cargo;
  bool proprietario;

  PerfilUsuario({
    required this.id,
    required this.email,
    required this.nomeCompleto,
    required this.cpf,
    required this.dataNascimento,
    required this.telefone,
    required this.bloco,
    required this.apartamento,
    required this.foto,
    required this.cargo,
    required this.proprietario,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'nomeCompleto': nomeCompleto,
      'cpf': cpf,
      'dataNascimento': dataNascimento,
      'telefone': telefone,
      'bloco': bloco,
      'apartamento': apartamento,
      'foto': foto,
      'cargo': cargo,
      'proprietario': proprietario,
    };
  }

  factory PerfilUsuario.fromMap(Map<String, dynamic> map) {
    return PerfilUsuario(
      id: map['id'] as String,
      email: map['email'] as String,
      nomeCompleto: map['nomeCompleto'] as String,
      cpf: map['cpf'] as String,
      dataNascimento: map['dataNascimento'] as String,
      telefone: map['telefone'] as String,
      bloco: map['bloco'] as String,
      apartamento: map['apartamento'] as String,
      foto: map['foto'] as String,
      cargo: map['cargo'] as String,
      proprietario: map['proprietario'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory PerfilUsuario.fromJson(String source) => PerfilUsuario.fromMap(json.decode(source) as Map<String, dynamic>);
}
