import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discover/entities/dogadjaj.dart';
import 'package:discover/entities/kategorija.dart';
import 'package:discover/entities/konjic_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'entities/lokacija.dart';
import 'entities/sekcija.dart';
import 'firebase_options.dart';

class Backend {
  List<Kategorija> kategorije = [];
  List<Lokacija> lokacije = [];
  List<Sekcija> sekcije = [];
  List<Dogadjaj> dogadjaji = [];
  List<KonjicInfo> konjicInfo = [];

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
    final konjicInfoSnapshot =
        await FirebaseFirestore.instance.collection("konjic_info").get();

    
    for (var element in kategorijeSnapshot.docs) {
      try {
        kategorije.add(Kategorija.fromMap(element.data())..id = element.id);
      } catch (e) {
        // print("Greska: ${element.data()}");
        // print(e);
      }
    }

    for (var element in lokacijeSnapshot.docs) {
      try {
        lokacije.add(Lokacija.fromMap(element.data()));
        // print(Lokacija.fromMap(element.data()));
      } catch (e) {
        // print("Greska: ${element.data()}");
        // print(e);
      }
    }

    for (var element in sekcijeSnapshot.docs) {
      try {
        sekcije.add(Sekcija.fromMap(element.data())..id = element.id);
      } catch (e) {
        // print("Greska: ${element.data()}");
        // print(e);
      }
    }

    for (var element in dogadjajiSnapshot.docs) {
      try {
        dogadjaji.add(Dogadjaj.fromMap(element.data()));
      } catch (e) {
        // print("Greska: ${element.data()}");
        // print(e);
      }
    }

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

    sekcije.sort((a, b) => (b.priority ?? 0).compareTo(a.priority ?? 0));

    for (var element in konjicInfoSnapshot.docs) {
        // print("OVOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
      try {
        konjicInfo.add(KonjicInfo.fromMap(element.data()));
        // print(KonjicInfo.fromMap(element.data()));
        // print(konjicInfo.length);
        // print("OVOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
      } catch (e) {
        // print("Greska: ${element.data()}");
        // print(e);
      }
    }
  }

  // void test() {
  //   for (Kategorija kategorija in kategorije) {
  //     print(kategorija.slika);
  //   }
  // }

  Future<void> precacheImagesForKategorija(context) async {
    for (Kategorija kategorija in kategorije) {
      // print("precached kategorijas' images");

      precacheImage(CachedNetworkImageProvider(kategorija.slika!), context);
      // print(kategorija.slika);
    }
  }

  Future<void> precacheImagesForLokacija(context) async {
    for (Lokacija lokacija in lokacije) {
      precacheImage(CachedNetworkImageProvider(lokacija.slike.first), context);
      // print(lokacija.slike.first);
    }
  }

  Future<void> precacheImagesForDogadjaj(context) async {
    // print("Dogadjaj precache!");
    for (Dogadjaj dogadjaj in dogadjaji) {
      precacheImage(CachedNetworkImageProvider(dogadjaj.slike.first), context);
      // print(dogadjaj.slike.first);
    }
  }
}
