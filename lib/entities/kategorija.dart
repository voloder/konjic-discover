import 'package:discover/postavke.dart';

import 'lokacija.dart';

class Kategorija {
  final String? slika;
  final String naziv;
  final String naziv_en;
  final String? sekcija;
  final String nazivDe;
  final String nazivTr;
  final int? priority;
  String? id;

  List<Lokacija> lokacije = [];

  Kategorija(
      {required this.slika,
      required this.nazivDe,
      required this.nazivTr,
      required this.naziv,
      required this.sekcija,
      required this.naziv_en,
      this.priority});
  String getLocalizedNaziv(Jezik jezik) {
    switch (jezik) {
      case Jezik.bosanski:
        return naziv;
      case Jezik.engleski:
        return naziv_en;
      case Jezik.njemacki:
        return nazivDe;
      case Jezik.turski:
        return nazivTr;
      default:
        return naziv; // Fallback to Bosnian
    }
  }

  factory Kategorija.fromMap(Map<String, dynamic> map) {
    // print(map['id']);
    return Kategorija(
      slika: map['slika'],
      naziv: map['naziv'],
      naziv_en: map['naziv_en'],
      sekcija: map['sekcija']?.id,
      priority: map['priority'],
      nazivDe: map['naziv_de'],
      nazivTr: map['naziv_tr'],
    );
  }
}
