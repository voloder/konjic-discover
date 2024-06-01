import 'package:cloud_firestore/cloud_firestore.dart';

class Dogadjaj {
  final String naziv;
  final String opis;
  final String naziv_en;
  final String opis_en;
  final DateTime? vrijeme;
  final List<String> slike;

  Dogadjaj({
    required this.naziv,
    required this.opis,
    required this.naziv_en,
    required this.opis_en,
    required this.vrijeme,
    required this.slike,
  });

  factory Dogadjaj.fromMap(Map<String, dynamic> map) {
    return Dogadjaj(
      naziv: map['naziv'],
      opis: map['opis'] ?? "",
      naziv_en: map['naziv_en'],
      opis_en: map['opis_en'] ?? "",
      vrijeme: map["vrijeme"] == null ? null : (map["vrijeme"] as Timestamp).toDate(),
      slike: List<String>.from(map['slike']),
    );
  }

}