import 'package:discover/backend.dart';
import 'package:discover/entities/sekcija.dart';
import 'package:discover/lokacije.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final backend = Backend();
    late final sekcije = backend.sekcije;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Discover'),
        ),
        body: Column(
          children: [SekcijeView(sekcije: sekcije)],
        ));
  }
}

class SekcijeView extends StatelessWidget {
  final List<Sekcija> sekcije;
  const SekcijeView({super.key, required this.sekcije});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: sekcije.length,
      itemBuilder: (context, index) {
        final sekcija = sekcije[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(sekcija.naziv),
            Container(
              height: 150,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: sekcija.kategorije.length,
                itemBuilder: (context, index) {
                  final kategorija = sekcija.kategorije[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LokacijePage(
                          kategorija: kategorija,
                        ),
                      ));
                    },
                    child: Container(
                        width: 120,
                        margin: const EdgeInsets.all(5),

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.3), BlendMode.darken),
                                image: NetworkImage(kategorija.slika!),
                                fit: BoxFit.cover)),
                        child: Center(
                            child: Text(
                          kategorija.naziv,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ))),
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
