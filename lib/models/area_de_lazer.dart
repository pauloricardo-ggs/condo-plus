import 'package:condo_plus/models/ata.dart';

class AreaDeLazer {
  String nome;
  int taxa;
  List<Ata> regimento;

  AreaDeLazer({
    required this.nome,
    required this.taxa,
    required this.regimento,
  });

  factory AreaDeLazer.fromJson(Map<String, dynamic> json) {
    var list = json['regimento'] as List;
    List<Ata> ataList = list.map((i) => Ata.fromJson(i)).toList();

    return new AreaDeLazer(
      nome: json['nome'],
      taxa: json['taxa'],
      regimento: ataList,
    );
  }
}
