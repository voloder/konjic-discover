import 'lokacija.dart';

class Kategorija {
  final String? slika;
  final String naziv;
  final String? sekcija;
  String? id;

  List<Lokacija> lokacije = [];

  Kategorija({required this.slika, required this.naziv, required this.sekcija});

  factory Kategorija.fromMap(Map<String, dynamic> map) {
    print(map['id']);
    return Kategorija(
      slika: map['slika'],
      naziv: map['naziv'],
      sekcija: map['sekcija']?.id,
    );
  }
}