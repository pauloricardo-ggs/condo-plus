class Ata {
  String ata;

  Ata({
    required this.ata,
  });

  factory Ata.fromJson(Map<String, dynamic> json) {
    return new Ata(
      ata: json['ata'],
    );
  }
}
