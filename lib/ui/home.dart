import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:discover/backend.dart';
import 'package:discover/entities/kategorija.dart';
import 'package:discover/entities/sekcija.dart';
import 'package:discover/ui/lokacije.dart';
import 'package:discover/postavke.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final localizations = AppLocalizations.of(context)!;
  late final naslovImage = const AssetImage("assets/images/konjic.jpg");
  late final Backend backend;
  late final List<Sekcija> sekcije;
  // late final naslovImage =  "assets/images/konjic.jpg";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final backend = Provider.of<Backend>(context, listen: false);
    sekcije = backend.sekcije;
  }

  @override
  Widget build(BuildContext context) {
    // double sliverAppBarHeight = 130;
    // super.build(context);
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
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
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
}

class SekcijeView extends StatefulWidget {
  final List<Sekcija> sekcije;
  const SekcijeView({super.key, required this.sekcije});

  @override
  State<SekcijeView> createState() => _SekcijeViewState();
}

class _SekcijeViewState extends State<SekcijeView> {
  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  // }
  openFunction(Kategorija kategorija) {
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
                        openFunction: openFunction,
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

class LocationWidget extends StatelessWidget {
  final Kategorija kategorija;
  final Function? openFunction;
  const LocationWidget(
      {super.key, required this.kategorija, required this.openFunction});

  // void openLokacijePage(Kategorija kategorija) {
  //   Navigator.push(
  //       context,
  //       PageRouteBuilder(
  //         pageBuilder: (context, animation, secondaryAnimation) => LokacijePage(
  //           kategorija: kategorija,
  //         ),
  //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //           const begin = Offset(0.0, 1.0);
  //           const end = Offset.zero;
  //           const curve = Curves.linearToEaseOut;

  //           var tween =
  //               Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  //           return SlideTransition(
  //             position: animation.drive(tween),
  //             child: child,
  //           );
  //         },
  //       ));
  //   // Navigator.of(context).push(
  //   //   MaterialPageRoute(builder: (context) => DetailsPage(item: item)),
  //   // );
  // }

  @override
  Widget build(BuildContext context) {
    final postavke = Provider.of<Postavke>(context);
    Jezik jezik = postavke.jezik!;

    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: 200,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: GestureDetector(
          onTap: () => openFunction!(kategorija),
          child: Stack(fit: StackFit.expand, children: [
            CachedNetworkImage(
              alignment: Alignment.center,
              imageUrl: kategorija.slika!,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.medium,
            ),
            Center(
              child: Text(
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 22,fontWeight: FontWeight.bold),
                softWrap: true,
                jezik == Jezik.bosanski
                    ? kategorija.naziv.toUpperCase()
                    : kategorija.naziv_en.toUpperCase(),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
// Center(
//                 child: AutoSizeText(
//               minFontSize: 20,
//               softWrap: true,
//               wrapWords: false,
              // jezik == Jezik.bosanski
              //     ? kategorija.naziv.toUpperCase()
              //     : kategorija.naziv_en.toUpperCase(),
//               textAlign: TextAlign.center,
//               style: const TextStyle(color: Colors.white),
//             )
            
//             ),

// return GestureDetector(
//       onTap: () => openFunction!(kategorija),
//       child: Row(
//         children: [
//           SizedBox(
//               width: 200,
//               child: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   CachedNetworkImage(
//                     // fadeInDuration:
//                     //     const Duration(milliseconds: 300),
//                     // fadeOutDuration:
//                     //     const Duration(milliseconds: 300),
//                     // filterQuality: FilterQuality.high,
//                     fit: BoxFit.cover,
//                     imageUrl: kategorija.slika!,
//                     // memCacheWidth: 700,
//                     // memCacheHeight:700,

//                     // placeholder: (context, ulr) =>
//                     //     Shimmer.fromColors(
//                     //   period:
//                     //       const Duration(milliseconds: 800),
//                     //   baseColor: Colors.grey.shade400,
//                     //   highlightColor: Colors.grey.shade300,
//                     //   child: Container(
//                     //     width: 120,
//                     //     height: 170,
//                     //     color: Colors.grey.shade400,
//                     //   ),
//                     // ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                         color: Colors.black.withValues(alpha: 0.3),
//                         borderRadius: BorderRadius.circular(25)),
//                   ),
//                   Center(
//                       child: AutoSizeText(
//                     minFontSize: 20,
//                     softWrap: true,
//                     wrapWords: false,
//                     jezik == Jezik.bosanski
//                         ? kategorija.naziv.toUpperCase()
//                         : kategorija.naziv_en.toUpperCase(),
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(color: Colors.white),
//                   )),
//                 ],
//               )),
//           const SizedBox(
//             width: 15,
//           )
//         ],
//       ),
//     );