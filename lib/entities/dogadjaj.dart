import 'package:cloud_firestore/cloud_firestore.dart';

class Dogadjaj {
  final String naziv;
  final String opis;
  final DateTime vrijeme;
  final List<String> slike;

  Dogadjaj({
    required this.naziv,
    required this.opis,
    required this.vrijeme,
    required this.slike,
  });

  factory Dogadjaj.fromMap(Map<String, dynamic> map) {
    return Dogadjaj(
      naziv: map['naziv'],
      opis: map['opis'] ?? "",
      vrijeme: (map["vrijeme"] as Timestamp).toDate(),
      slike: List<String>.from(map['slike']),
    );
  }

}