import 'package:discover/postavke.dart';

import 'kategorija.dart';

class Sekcija {
  String naziv;
  String nazivEn;
  String nazivDe;
  String nazivTr;
  String? id;
  List<Kategorija> kategorije = [];
  final int? priority;

  Sekcija({
    required this.id,
    required this.naziv,
    required this.nazivEn,
    required this.nazivDe,
    required this.nazivTr,
    this.priority,
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
      default:
        return naziv; // Fallback to Bosnian
    }
  }

  factory Sekcija.fromMap(Map<String, dynamic> map) {
    return Sekcija(
      naziv: map['naziv'],
      nazivEn: map['naziv_en'],
      id: map['id'],
      priority: map['priority'],
      nazivDe: map['naziv_de'],
      nazivTr: map['naziv_tr'],
    );
  }
}
