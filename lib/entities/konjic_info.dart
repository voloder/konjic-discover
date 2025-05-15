import 'package:discover/entities/lokacija.dart';
import 'package:discover/postavke.dart';



class KonjicInfo {
  final String naziv;
  final String opis;
  final String nazivEn;
  final String opisEn;
  final List<String> slike;
  // final Map<String, dynamic> detalji;
  // final double lat;
  // final double long;
  final String nazivDe;
  final String opisDe;
  final String nazivTr;
  final String opisTr;
  KonjicInfo({
    required this.naziv,
    required this.opis,
    required this.nazivEn,
    required this.opisEn,
    required this.slike,
    // required this.detalji,
    // required this.lat,
    // required this.long,
    required this.nazivDe,
    required this.opisDe,
    required this.nazivTr,
    required this.opisTr,
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

  factory KonjicInfo.fromMap(Map<String, dynamic> map) {
    return KonjicInfo(
      nazivDe: map['nazivDe'] ?? "naziv_de",
      opisDe: map['opisDe'] ?? "opisDe",
      nazivTr: map['nazivTr'] ?? "naziv_tr",
      opisTr: map['opisTr'] ?? "opisTr",
      naziv: map['naziv'],
      opis: map['opis'] ?? "",
      nazivEn: map['nazivEn'],
      opisEn: map['opisEn'] ?? "",
      slike: List<String>.from(map['slike']),
      // kategorija: map['kategorija'].id,
      // detalji: Map<String, dynamic>.from(map['detalji']),
      // lat: map['lat'],
      // long: map['long'],
    );
  }
}
