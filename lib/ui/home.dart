import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:discover/backend.dart';
import 'package:discover/entities/sekcija.dart';
import 'package:discover/ui/lokacije.dart';
import 'package:discover/postavke.dart';
import 'package:discover/ui/postavke_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin   {
  late final localizations = AppLocalizations.of(context)!;
  late final naslovImage = const AssetImage("assets/images/konjic.jpg");

  @override
  void didChangeDependencies() {
    precacheImage(naslovImage, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final backend = Provider.of<Backend>(context);

    late final sekcije = backend.sekcije;


    return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image:  DecorationImage(
                            image: naslovImage,
                            fit: BoxFit.cover)),
                    child: const Center(
                      child: Text(
                        "KONJIC",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Image.asset(
                        Theme.of(context).brightness == Brightness.light
                            ? "assets/images/discover.png"
                            : "assets/images/discover_dark.png",
                        width: 300,
                      )),
                ),
                SekcijeView(sekcije: sekcije),
              ],
            ),
          ),
        ));
  }
  @override
  bool get wantKeepAlive => true;
}

class SekcijeView extends StatelessWidget {
  final List<Sekcija> sekcije;

  const SekcijeView({super.key, required this.sekcije});

  @override
  Widget build(BuildContext context) {
    final postavke = Provider.of<Postavke>(context);

    Jezik jezik = postavke.jezik!;

    return ListView.builder(
        shrinkWrap: true,
        itemCount: sekcije.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final sekcija = sekcije[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 10, bottom: 3),
                child: Text(
                    jezik == Jezik.bosanski ? sekcija.naziv : sekcija.nazivEn,
                    style: const TextStyle(fontSize: 14)),
              ),
              Container(
                height: 150,
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 15),
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
                          width: 125,
                          margin: const EdgeInsets.all(5),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  fadeInDuration:
                                  const Duration(milliseconds: 300),
                                  fadeOutDuration:
                                  const Duration(milliseconds: 300),
                                  color: Colors.black.withOpacity(0.25),
                                  colorBlendMode: BlendMode.darken,
                                  width: 125,
                                  height: 150,
                                  fit: BoxFit.cover,
                                  imageUrl: kategorija.slika!,
                                  placeholder: (context, ulr) =>
                                      Shimmer.fromColors(
                                        period: const Duration(milliseconds: 800),
                                        baseColor: Colors.grey.shade400,
                                        highlightColor: Colors.grey.shade300,
                                        child: Container(
                                          width: 120,
                                          height: 170,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                ),
                              ),
                              Center(
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    softWrap: true,
                                    wrapWords: false,
                                    jezik == Jezik.bosanski
                                        ? kategorija.naziv.toUpperCase()
                                        : kategorija.naziv_en.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.white),
                                  )),
                            ],
                          )),
                    );
                  },
                ),
              )
            ],
          );
        });
  }
}
