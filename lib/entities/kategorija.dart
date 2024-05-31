import 'lokacija.dart';

class Kategorija {
  final String? slika;
  final String naziv;
  final String naziv_en;
  final String? sekcija;
  final int? priority;
  String? id;

  List<Lokacija> lokacije = [];

  Kategorija({required this.slika, required this.naziv, required this.sekcija, required this.naziv_en, this.priority});

  factory Kategorija.fromMap(Map<String, dynamic> map) {
    print(map['id']);
    return Kategorija(
      slika: map['slika'],
      naziv: map['naziv'],
      naziv_en: map['naziv_en'],
      sekcija: map['sekcija']?.id,
      priority: map['priority'],
    );
  }
}