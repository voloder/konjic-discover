import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:discover/backend.dart';
import 'package:discover/entities/kategorija.dart';
import 'package:discover/entities/sekcija.dart';
import 'package:discover/ui/lokacije.dart';
import 'package:discover/postavke.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  late final localizations = AppLocalizations.of(context)!;
  late final naslovImage = const AssetImage("assets/images/konjic.jpg");
  // late final naslovImage =  "assets/images/konjic.jpg";
  @override
  Widget build(BuildContext context) {
    // double sliverAppBarHeight = 130;

    super.build(context);
    final backend = Provider.of<Backend>(context);

    late final sekcije = backend.sekcije;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 210,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(38),
                      bottomRight: Radius.circular(38)),
                  image: DecorationImage(
                    image: naslovImage,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  )),
              child: const Center(
                child: Text(
                  "KONJIC",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SekcijeView(sekcije: sekcije)
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SekcijeView extends StatefulWidget {
  final List<Sekcija> sekcije;

  const SekcijeView({super.key, required this.sekcije});

  @override
  State<SekcijeView> createState() => _SekcijeViewState();
}

class _SekcijeViewState extends State<SekcijeView> {
  @override
  Widget build(BuildContext context) {
    final postavke = Provider.of<Postavke>(context);

    Jezik jezik = postavke.jezik!;

    return ListView.builder(
        cacheExtent: 1000,
        shrinkWrap: true,
        itemCount: widget.sekcije.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final sekcija = widget.sekcije[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 6, bottom: 5),
                child: Center(
                  child: Text(
                      jezik == Jezik.bosanski ? sekcija.naziv : sekcija.nazivEn,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: ListView.builder(
                    // shrinkWrap: true,
                    cacheExtent: 1000,
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: sekcija.kategorije.length,
                    itemBuilder: (context, index) {
                      final kategorija = sekcija.kategorije[index];
                      return LocationWidget(
                        kategorija: kategorija,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              )
            ],
          );
        });
  }
}

class LocationWidget extends StatefulWidget {
  Kategorija kategorija;
  LocationWidget({super.key, required this.kategorija});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  void openLokacijePage(Kategorija kategorija) {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => LokacijePage(
            kategorija: kategorija,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.linearToEaseOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ));
    // Navigator.of(context).push(
    //   MaterialPageRoute(builder: (context) => DetailsPage(item: item)),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final postavke = Provider.of<Postavke>(context);

    Jezik jezik = postavke.jezik!;

    return GestureDetector(
      onTap: () => openLokacijePage(widget.kategorija),
      child: Row(
        children: [
          SizedBox(
              width: 200,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    // child: Container(color: Colors.red),
                    child: CachedNetworkImage(
                      // fadeInDuration:
                      //     const Duration(milliseconds: 300),
                      // fadeOutDuration:
                      //     const Duration(milliseconds: 300),
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      imageUrl: widget.kategorija.slika!,
                      // memCacheWidth: 700,
                      // memCacheHeight:700,

                      // placeholder: (context, ulr) =>
                      //     Shimmer.fromColors(
                      //   period:
                      //       const Duration(milliseconds: 800),
                      //   baseColor: Colors.grey.shade400,
                      //   highlightColor: Colors.grey.shade300,
                      //   child: Container(
                      //     width: 120,
                      //     height: 170,
                      //     color: Colors.grey.shade400,
                      //   ),
                      // ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  Center(
                      child: AutoSizeText(
                    minFontSize: 20,
                    softWrap: true,
                    wrapWords: false,
                    jezik == Jezik.bosanski
                        ? widget.kategorija.naziv.toUpperCase()
                        : widget.kategorija.naziv_en.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  )),
                ],
              )),
          const SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }
}
