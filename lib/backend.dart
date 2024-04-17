import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discover/entities/kategorija.dart';
import 'package:firebase_core/firebase_core.dart';
import 'entities/lokacija.dart';
import 'entities/sekcija.dart';
import 'firebase_options.dart';


class Backend  {
  late List<Kategorija> kategorije;
  late List<Lokacija> lokacije;
  late List<Sekcija> sekcije;

  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);
  }

  Future<void> ucitaj() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final lokacijeSnapshot = await FirebaseFirestore.instance.collection('lokacije').get();
    final kategorijeSnapshot = await FirebaseFirestore.instance.collection('kategorije').get();
    final sekcijeSnapshot = await FirebaseFirestore.instance.collection('sekcije').get();

    kategorije = kategorijeSnapshot.docs.map((e) => Kategorija.fromMap(e.data())..id = e.id).toList();
    lokacije = lokacijeSnapshot.docs.map((e) => Lokacija.fromMap(e.data())).toList();
    sekcije = sekcijeSnapshot.docs.map((e) => Sekcija.fromMap(e.data())..id = e.id).toList();

    for(final sekcija in sekcije) {
      sekcija.kategorije =
          kategorije.where((element) => element.sekcija == sekcija.id).toList();
    }
    for(final kategorija in kategorije) {
      kategorija.lokacije =
          lokacije.where((element) => element.kategorija == kategorija.id).toList();
    }
  }
}