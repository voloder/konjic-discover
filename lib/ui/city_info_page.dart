import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:discover/backend.dart';

import 'package:discover/postavke.dart';
import 'package:discover/ui/zoomed_pictures.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

class CityInfoPage extends StatefulWidget {
  const CityInfoPage({super.key});

  @override
  State<CityInfoPage> createState() => _CityInfoPageState();
}

class _CityInfoPageState extends State<CityInfoPage> {
  late final localizations = AppLocalizations.of(context)!;
  @override
  Widget build(BuildContext context) {
    Postavke postavke = Provider.of<Postavke>(context);
    Backend backend = Provider.of<Backend>(context);
  // final KonjicInfo konjicInfo = backend.konjicInfo[0];
  // final naziv = konjicInfo.getLocalizedNaziv(postavke.jezik!);
    final lokacija = backend.konjicInfo[0];
    final naziv = backend.konjicInfo[0].getLocalizedNaziv(postavke.jezik!);
    final opis = backend.konjicInfo[0].getLocalizedOpis(postavke.jezik!);

return Scaffold(
      appBar: AppBar(
        title: Text(naziv),
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              if (lokacija.slike.isNotEmpty)
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 260,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          enableInfiniteScroll: false,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                          enlargeFactor: 0.4,
                        ),
                        items: lokacija.slike
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    // child: Hero(
                                    //   tag: e,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ZoomedPictures(url: e)));
                                        Hero(
                                          tag: "testing",
                                          child: ZoomedPictures(
                                            url: e,
                                          ),
                                        );
                                      },
                                      child: CachedNetworkImage(
                                        height: 270,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        imageUrl: e,
                                        fadeOutDuration:
                                            const Duration(milliseconds: 300),
                                      ),
                                    ),
                                    // ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    Center(
                      child: Text(localizations.tapToZoom,
                          style: const TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              if (opis.isNotEmpty)
                ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        localizations.description,
                        style: const TextStyle(
                            fontSize: 21, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                  subtitle: Text(
                    opis,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              
              
              
            ],
          ),
        ),
      ]),
    );



    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(naziv),
    //     centerTitle: true,
    //   ),
    //   body: Center(
    //       child: Stack(children: [CachedNetworkImage(imageUrl: backend.konjicInfo[0].slike[0]),Text(opis)],)),
    // );
    // // Simulating fetching a single location from the backend

    // return LokacijaPage(lokacija: lokacija);
  }
}
//
