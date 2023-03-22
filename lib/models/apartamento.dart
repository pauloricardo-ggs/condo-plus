class Apartamento {
  final String bloco;
  final String numApto;

  const Apartamento({
    required this.bloco,
    required this.numApto,
  });

  factory Apartamento.fromJson(Map<String, dynamic> json) {
    return new Apartamento(
      bloco: json['bloco'],
      numApto: json['numApto'],
    );
  }
}
