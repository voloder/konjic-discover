import '../postavke.dart';

class Lokacija {
  final String naziv;
  final String nazivEn;
  final String nazivDe;
  final String nazivTr;
  final String opis;
  final String opisEn;
  final String opisDe;
  final String opisTr;
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
    required this.nazivDe,
    required this.opisDe,
    required this.opisTr,
    required this.nazivTr,
  });

  String getLocalizedNaziv(Jezik jezik) {
    switch (jezik) {
      case Jezik.bosanski:
        return naziv;
      case Jezik.engleski:
        return nazivEn;
      case Jezik.njemacki:
        return nazivDe;
      case Jezik.turski:
        return nazivTr;
    }
  }

  String getLocalizedOpis(Jezik jezik) {
      switch (jezik) {
        case Jezik.bosanski:
          return opis;
        case Jezik.engleski:
          return opisEn;
        case Jezik.njemacki:
          return opisDe;
        case Jezik.turski:
          return opisTr;
      }
    }

  factory Lokacija.fromMap(Map<String, dynamic> map) {
    return Lokacija(
      nazivDe: map['naziv_de'] ?? "naziv_de",
      opisDe: map['opis_de']  ?? "opisDe",
      nazivTr: map['naziv_tr'] ?? "naziv_tr",
      opisTr: map['opis_tr'] ?? "opisTr",
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