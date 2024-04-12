import 'package:discover/entities/kategorija.dart';
import 'package:flutter/material.dart';

import 'lokacija_page.dart';

class LokacijePage extends StatelessWidget {
  final Kategorija kategorija;
  const LokacijePage({super.key, required this.kategorija});

  @override
  Widget build(BuildContext context) {
    final lokacije = kategorija.lokacije;
    return Scaffold(
      appBar: AppBar(
        title: Text(kategorija.naziv),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(kategorija.slika!, height: 200, width: double.infinity, fit: BoxFit.cover),
            ...lokacije.map((e) => ListTile(
              title: Text(e.naslov),
              subtitle: Text(e.deskripcija.length > 100 ? "${e.deskripcija.substring(0, 100)}..." : e.deskripcija ),
              //leading: Image.network(e.slike.first),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LokacijaPage(lokacija: e),
                ));
              },
            )).toList()
          ],
        ),
      ),

    );
  }
}
