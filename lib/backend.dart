import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discover/entities/dogadjaj.dart';
import 'package:discover/entities/kategorija.dart';
import 'package:firebase_core/firebase_core.dart';
import 'entities/lokacija.dart';
import 'entities/sekcija.dart';
import 'firebase_options.dart';

class Backend {
  List<Kategorija> kategorije = [];
  List<Lokacija> lokacije = [];
  List<Sekcija> sekcije = [];
  List<Dogadjaj> dogadjaji = [];

  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseFirestore.instance.settings =
        const Settings(persistenceEnabled: true);
  }

  Future<void> ucitaj() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final lokacijeSnapshot =
        await FirebaseFirestore.instance.collection("lokacije").get();
    final kategorijeSnapshot =
        await FirebaseFirestore.instance.collection("kategorije").get();
    final sekcijeSnapshot =
        await FirebaseFirestore.instance.collection("sekcije").get();
    final dogadjajiSnapshot =
        await FirebaseFirestore.instance.collection("dogadjaji").get();

    kategorijeSnapshot.docs.forEach((element) {
      try {
        kategorije.add(Kategorija.fromMap(element.data())..id = element.id);
      } catch (e) {
        print("Greska: " + element.data().toString());
        print(e);
      }
    });

    lokacijeSnapshot.docs.forEach((element) {
      try {
        lokacije.add(Lokacija.fromMap(element.data()));
      } catch (e) {
        print("Greska: " + element.data().toString());
        print(e);
      }
    });

    sekcijeSnapshot.docs.forEach((element) {
      try {
        sekcije.add(Sekcija.fromMap(element.data())..id = element.id);
      } catch (e) {
        print("Greska: " + element.data().toString());
        print(e);
      }
    });

    dogadjajiSnapshot.docs.forEach((element) {
      try {
        dogadjaji.add(Dogadjaj.fromMap(element.data()));
      } catch (e) {
        print("Greska: " + element.data().toString());
        print(e);
      }
    });

    kategorije.sort((a, b) => (b.priority ?? 0).compareTo(a.priority ?? 0));

    for (final sekcija in sekcije) {
      sekcija.kategorije =
          kategorije.where((element) => element.sekcija == sekcija.id).toList();
    }
    for (final kategorija in kategorije) {
      kategorija.lokacije = lokacije
          .where((element) => element.kategorija == kategorija.id)
          .toList();
    }
  }
}
