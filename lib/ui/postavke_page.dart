import 'package:discover/main.dart';
import 'package:discover/postavke.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostavkePage extends StatefulWidget {
  const PostavkePage({super.key});

  @override
  State<PostavkePage> createState() => _PostavkePageState();
}

class _PostavkePageState extends State<PostavkePage> {


  Map<Jezik, String> jezici = {
    Jezik.bosanski: "Bosanski",
    Jezik.engleski: "English",
  };

  @override
  Widget build(BuildContext context) {
    final postavke = Provider.of<Postavke>(context);
    Jezik jezik = postavke.jezik!;

    Map<Tema, String> teme = {
      Tema.svijetla: "Svijetla",
      Tema.tamna: "Tamna",
      Tema.auto: "Auto",
    };
    return Scaffold(
        appBar: AppBar(
          title:  Text(jezik == Jezik.bosanski ? "Postavke" : "Settings"),
        ),
        body: Column(
          children: [
            Text(jezik == Jezik.bosanski ? "Jezik" : "Language"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                collapsedShape: RoundedRectangleBorder(
                    side:  BorderSide(color: Theme.of(context).colorScheme.onSurface),
                    borderRadius: BorderRadius.circular(10)),
                shape: RoundedRectangleBorder(
                    side:  BorderSide(color: Theme.of(context).colorScheme.onSurface),
                    borderRadius: BorderRadius.circular(10)),
                title: Text(jezici[postavke.jezik]!),
                children: jezici.entries
                    .map((e) => ListTile(
                          title: Text(e.value),
                          onTap: () {
                            setState(() {
                              postavke.postaviJezik(e.key);
                            });
                          },
                        ))
                    .toList(),
              ),
            ),
            Text(jezik == Jezik.bosanski ? "Tema" : "Theme"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                collapsedShape: RoundedRectangleBorder(
                    side:  BorderSide(color: Theme.of(context).colorScheme.onSurface),
                    borderRadius: BorderRadius.circular(10)),
                shape: RoundedRectangleBorder(
                    side:  BorderSide(color: Theme.of(context).colorScheme.onSurface),
                    borderRadius: BorderRadius.circular(10)),
                title: Text(teme[postavke.tema]!),
                children: teme.entries
                    .map((e) => ListTile(
                          title: Text(e.value),
                          onTap: () {
                            setState(() {
                              postavke.postaviTemu(e.key);
                            });
                          },
                        ))
                    .toList(),
              ),
            ),
          ],
        ));
  }
}