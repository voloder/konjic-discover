class Lokacija {
  final String naziv;
  final String nazivEn;
  final String opis;
  final String opisEn;
  final List<String> slike;
  final String kategorija;
  final Map<String, dynamic> detalji;
  final double? lat;
  final double? long;

  Lokacija({
    required this.naziv,
    required this.opis,
    required this.nazivEn,
    required this.opisEn,
    required this.slike,
    required this.kategorija,
    required this.detalji,
    required this.lat,
    required this.long,
  });

  factory Lokacija.fromMap(Map<String, dynamic> map) {
    print(map["kategorija"].id);
    return Lokacija(
      naziv: map['naziv'],
      opis: map['opis'] ?? "",
      nazivEn: map['naziv_en'],
      opisEn: map['opis_en'] ?? "",
      slike: List<String>.from(map['slike']),
      kategorija: map['kategorija'].id,
      detalji: Map<String, dynamic>.from(map['detalji']),
      lat: map['lat'],
      long: map['long'],
    );
  }
}