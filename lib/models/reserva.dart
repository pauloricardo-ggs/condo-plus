// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:condo_plus/models/apartamento.dart';
import 'package:condo_plus/models/area_de_lazer.dart';
import 'package:condo_plus/models/convidado.dart';

class Reserva {
  String data;
  String status;
  String icon;
  String horaEntrada;
  String horaSaida;
  Apartamento apartamento;
  AreaDeLazer areaReservada;
  List<Convidado> convidados;

  Reserva({
    required this.data,
    required this.status,
    required this.icon,
    required this.horaEntrada,
    required this.horaSaida,
    required this.apartamento,
    required this.areaReservada,
    required this.convidados,
  });

  factory Reserva.fromJson(Map<String, dynamic> json) {
    var list = json['convidados'] as List;
    List<Convidado> convidadoList = list.map((i) => Convidado.fromJson(i)).toList();

    return new Reserva(
      data: json['data'],
      status: json['status'],
      icon: json['icon'],
      horaEntrada: json['horaEntrada'],
      horaSaida: json['horaSaida'],
      apartamento: Apartamento.fromJson(json['apartamento']),
      areaReservada: AreaDeLazer.fromJson(json['areaReservada']),
      convidados: convidadoList,
    );
  }
}
