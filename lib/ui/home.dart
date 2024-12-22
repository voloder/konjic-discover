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
  // late final naslovImage = "assets/images/konjic.jpg";

  @override
  void didChangeDependencies() {
    // precacheImage(naslovImage, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final backend = Provider.of<Backend>(context);

    late final sekcije = backend.sekcije;

    return Scaffold(
      // extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   toolbarHeight: 160,
      //   flexibleSpace: Container(
      //     color: Colors.transparent,
      //     // color: Theme.of(context).colorScheme.background.withOpacity(0.8),

      //   ),
      //   backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0),
      // ),
      // title: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Image.asset(
      //     Theme.of(context).brightness == Brightness.light
      //         ? "assets/images/discover.png"
      //         : "assets/images/discover_dark.png",
      //   ),
      // ),
      // actions: [
      //   Shimmer.fromColors(
      //     period: const Duration(milliseconds: 5000),
      //     baseColor:
      //         Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
      //     highlightColor: Theme.of(context).brightness == Brightness.light
      //         ? Colors.grey
      //         : Colors.white,
      //     child: IconButton(
      //         icon: const Icon(Icons.map),
      //         onPressed: () {
      //           Navigator.of(context).push(MaterialPageRoute(
      //             builder: (context) => const MapPage(),
      //           ));
      //         }),
      //   )
      // ],

      // body: Container(
      //   // color:  Theme.of(context).colorScheme.background.withOpacity(0),
      //   child: SingleChildScrollView(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         SekcijeView(sekcije: sekcije),
      //       ],
      //     ),
      //   ),
      // ),

      // body: CustomScrollView(slivers: [
      //   SliverAppBar(
      //     expandedHeight: 180,
      //     flexibleSpace: FlexibleSpaceBar(
      //       collapseMode: CollapseMode.parallax,
      //       background: Container(
      //         height: double.maxFinite,
      //         width: double.infinity,
      //         decoration: BoxDecoration(
      //             borderRadius: const BorderRadius.only(
      //                 bottomLeft: Radius.circular(25),
      //                 bottomRight: Radius.circular(25)),
      //             image:
      //                 DecorationImage(image: naslovImage, fit: BoxFit.cover)),
      //         child: const Center(
      //           child: Text(
      //             "KONJIC",
      //             style: TextStyle(
      //                 fontSize: 24,
      //                 fontWeight: FontWeight.bold,
      //                 color: Colors.white),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      //   SliverToBoxAdapter(
      //     // color:  Theme.of(context).colorScheme.background.withOpacity(0),
      //     // child: ClipRRect(
      //     //   borderRadius: const BorderRadius.only(
      //     //       topLeft: Radius.circular(35), topRight: Radius.circular(35)),
      //     child: Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      // children: [
      //   SekcijeView(sekcije: sekcije),
      // ],
      //     ),
      //   ),
      // ]),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 210,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(38),
                      bottomRight: Radius.circular(38)),
                  image:
                      DecorationImage(image: naslovImage, fit: BoxFit.cover)),
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
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: sekcija.kategorije.length,
                    itemBuilder: (context, index) {
                      final kategorija = sekcija.kategorije[index];
                      return GestureDetector(
                        onTap: () => openLokacijePage(kategorija),
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
                                        fit: BoxFit.cover,
                                        imageUrl: kategorija.slika!,
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
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                    ),
                                    Center(
                                        child: AutoSizeText(
                                      minFontSize: 20,
                                      softWrap: true,
                                      wrapWords: false,
                                      jezik == Jezik.bosanski
                                          ? kategorija.naziv.toUpperCase()
                                          : kategorija.naziv_en.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )),
                                  ],
                                )),
                            const SizedBox(
                              width: 15,
                            )
                          ],
                        ),
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
