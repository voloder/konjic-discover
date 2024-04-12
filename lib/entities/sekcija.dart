import 'kategorija.dart';

class Sekcija {
  String naziv;
  String nazivEn;
  String? id;
  List<Kategorija> kategorije = [];

  Sekcija({
    required this.id,
    required this.naziv,
    required this.nazivEn,
  });

  factory Sekcija.fromMap(Map<String, dynamic> map) {
    return Sekcija(
      naziv: map['naziv'],
      nazivEn: map['naziv_en'],
      id: map['id']);
  }
}