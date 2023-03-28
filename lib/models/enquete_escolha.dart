class EnqueteEscolha {
  int enqueteId;
  String escolha;

  EnqueteEscolha({
    required this.enqueteId,
    required this.escolha,
  });

  factory EnqueteEscolha.fromJson(Map<String, dynamic> map) {
    return EnqueteEscolha(
      enqueteId: map['enqueteId'] as int,
      escolha: map['escolha'] as String,
    );
  }
}
