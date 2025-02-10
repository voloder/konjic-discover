import 'kategorija.dart';

class Sekcija {
  String naziv;
  String nazivEn;
  String? id;
  List<Kategorija> kategorije = [];
  final int? priority;

  Sekcija({
    required this.id,
    required this.naziv,
    required this.nazivEn,
    this.priority,
  });

  factory Sekcija.fromMap(Map<String, dynamic> map) {
    return Sekcija(
      naziv: map['naziv'],
      nazivEn: map['naziv_en'],
      id: map['id'],
      priority: map['priority'],
    );
  }
}
