import 'package:condo_plus/models/funcionario.dart';
import 'package:flutter/material.dart';

class Aviso {
  String titulo;
  String descricao;
  Funcionario funcionario;
  String dataHora;
  AssetImage imagem;

  Aviso({
    required this.titulo,
    required this.descricao,
    required this.funcionario,
    required this.dataHora,
    required this.imagem,
  });

  factory Aviso.fromJson(Map<String, dynamic> json) {
    return new Aviso(
      titulo: json['titulo'],
      descricao: json['descricao'],
      funcionario: Funcionario.fromJson(json['funcionario']),
      dataHora: json['dataHora'],
      imagem: AssetImage('assets/images/avisos/' + json['imagem']),
    );
  }
}
