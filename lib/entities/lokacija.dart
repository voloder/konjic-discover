class Lokacija {
  final String naslov;
  final String deskripcija;
  final List<String> slike;
  final String kategorija;
  final Map<String, dynamic> detalji;
  final String lokacija;

  Lokacija({
    required this.naslov,
    required this.deskripcija,
    required this.slike,
    required this.kategorija,
    required this.detalji,
    required this.lokacija,
  });

  factory Lokacija.fromMap(Map<String, dynamic> map) {
    print(map["kategorija"].id);
    return Lokacija(
      naslov: map['naziv'],
      deskripcija: map['opis'] ?? "",
      slike: List<String>.from(map['slike']),
      kategorija: map['kategorija'].id,
      detalji: Map<String, dynamic>.from(map['detalji']),
      lokacija: map['lokacija'] ?? "",
    );
  }
}