import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Jezik {
  bosanski,
  engleski,
}

enum Tema {
  svijetla,
  tamna,
  auto,
}

class Postavke extends ChangeNotifier {


  Jezik? jezik;
  Tema? tema;
  bool? prviPut;


  Future<void> ucitaj() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    jezik = Jezik.values[prefs.getInt("jezik") ?? 1];
    tema = Tema.values[prefs.getInt("tema") ?? 2];
    prviPut = prefs.getBool("prviPut") ?? true;
  }

  Future<void> postaviJezik(Jezik jezik) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("jezik", jezik.index);
    this.jezik = jezik;
    notifyListeners();
  }

  Future<void> postaviTemu(Tema tema) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("tema", tema.index);
    this.tema = tema;
    notifyListeners();
  }

  Future<void> postaviPrviPut(bool prviPut) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("prviPut", prviPut);
    this.prviPut = prviPut;
  }
}