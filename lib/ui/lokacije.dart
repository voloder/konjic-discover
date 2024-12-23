import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:discover/entities/kategorija.dart';
import 'package:discover/postavke.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'lokacija_page.dart';

class LokacijePage extends StatefulWidget {
  final Kategorija kategorija;

  const LokacijePage({super.key, required this.kategorija});

  @override
  State<LokacijePage> createState() => _LokacijePageState();
}

class _LokacijePageState extends State<LokacijePage> {
  @override
  Widget build(BuildContext context) {
    final postavke = Provider.of<Postavke>(context);
    Jezik jezik = postavke.jezik!;
    int i = 0;
    final lokacije = widget.kategorija.lokacije;
    return Scaffold(
      // title: Text(jezik == Jezik.bosanski ? kategorija.naziv : kategorija.naziv_en),

      body: CustomScrollView(slivers: [
        SliverAppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          collapsedHeight: 180,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35)),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CachedNetworkImage(
                          // color: Colors.black.withOpacity(0.2),
                          // colorBlendMode: BlendMode.darken,
                          // fadeInDuration: Duration.zero,
                          filterQuality: FilterQuality.high,
                          imageUrl: widget.kategorija.slika!,
                          height: 220,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover),
                      Text(
                        (jezik == Jezik.bosanski
                                ? widget.kategorija.naziv
                                : widget.kategorija.naziv_en)
                            .toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              // Stack(
              //   alignment: Alignment.center,
              //   children: [
              //     Container(
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           boxShadow: [
              //             BoxShadow(
              //               color: Colors.black.withOpacity(0.2),
              //               spreadRadius: 0,
              //               blurRadius: 4,
              //               offset: const Offset(
              //                   0, 2), // changes position of shadow
              //             )
              //           ]),
              //       child: ClipRRect(
              //         borderRadius: const BorderRadius.only(
              //             bottomLeft: Radius.circular(35),
              //             bottomRight: Radius.circular(35)),
              //         child: CachedNetworkImage(
              //             color: Colors.black.withOpacity(0.2),
              //             colorBlendMode: BlendMode.darken,
              //             fadeInDuration: Duration.zero,
              //             imageUrl: kategorija.slika!,
              //             height: 215,
              //             width: double.infinity,
              //             fit: BoxFit.cover),
              //       ),
              //     ),
              //     Text(
              //       (jezik == Jezik.bosanski
              //               ? kategorija.naziv
              //               : kategorija.naziv_en)
              //           .toUpperCase(),
              //       textAlign: TextAlign.center,
              //       style: const TextStyle(
              //           color: Colors.white,
              //           fontSize: 24,
              //           fontWeight: FontWeight.bold),
              //     ),
              //   ],
              // ),
              ...lokacije.map((e) {
                i++;
                final opis = jezik == Jezik.bosanski ? e.opis : e.opisEn;
                final naslov = jezik == Jezik.bosanski ? e.naziv : e.nazivEn;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LokacijaPage(lokacija: e)));
                    },
                    child: FadeIn(
                      duration: Duration(milliseconds: 250 + (i * 300)),
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .surface, //ovo treba na svakom mjestu stavit, nema vise "Theme.of(context).colorScheme.background"
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: const Offset(
                                    0, 2), // changes position of shadow
                              )
                            ]),
                        child: Row(
                          children: [
                            Hero(
                              tag: e.slike.first,
                              child: CachedNetworkImage(
                                // fadeInDuration:
                                //     const Duration(milliseconds: 300),
                                // fadeOutDuration:
                                //     const Duration(milliseconds: 300),
                                filterQuality: FilterQuality.medium,
                                imageUrl: e.slike.first,

                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                                // placeholder: (context, url) =>
                                //     Shimmer.fromColors(
                                //   period: const Duration(milliseconds: 800),
                                //   baseColor: Colors.grey.shade400,
                                //   highlightColor: Colors.grey.shade300,
                                //   child: Container(
                                //     width: 100,
                                //     height: 100,
                                //     color: Colors.grey.shade400,
                                //   ),
                                // ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(naslov),
                                    if (opis.isNotEmpty)
                                      Text(
                                        opis.length > 90
                                            ? "${opis.trimLeft().substring(0, 90)}..."
                                            : opis.trimLeft(),
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ]),
    );
  }
}
