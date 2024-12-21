import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:discover/postavke.dart';
import 'package:discover/ui/zoomed_pictures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';
import '../entities/lokacija.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LokacijaPage extends StatefulWidget {
  final Lokacija lokacija;

  const LokacijaPage({super.key, required this.lokacija});

  @override
  State<LokacijaPage> createState() => _LokacijaPageState();
}

class _LokacijaPageState extends State<LokacijaPage> {
  late final localizations = AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    final postavke = Provider.of<Postavke>(context);
    final jezik = postavke.jezik!;
    final opis =
        Jezik.bosanski == jezik ? widget.lokacija.opis : widget.lokacija.opisEn;

    final naziv = Jezik.bosanski == jezik
        ? widget.lokacija.naziv
        : widget.lokacija.nazivEn;

    return Scaffold(
      appBar: AppBar(
        title: Text(naziv),
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              if (widget.lokacija.slike.isNotEmpty)
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
                        items: widget.lokacija.slike
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Hero(
                                      tag: e,
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
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    Center(
                      child: jezik ==
                              Jezik
                                  .bosanski //Ovo se obatali ako se doda jos jedan jezik :D (nez kako radi lokalizacija <3)
                          ? (const Text("Klikni za pregled."))
                          : (const Text("Tap to preview.")),
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
              ...widget.lokacija.detalji.entries.map((e) => ListTile(
                    title: Text(e.key.toString()),
                    subtitle: Text(e.value.toString()),
                  )),
              if (widget.lokacija.lat != null && widget.lokacija.long != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue.withOpacity(0.1),
                    ),
                    onPressed: () {
                      openMap(widget.lokacija.lat!, widget.lokacija.long!);
                    },
                    child: Text(localizations.openInMaps),
                  ),
                ),
              if (widget.lokacija.lat != null && widget.lokacija.long != null)
                Container(
                  padding: const EdgeInsets.all(5),
                  height: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FlutterMap(
                      options: MapOptions(
                          initialCameraFit: CameraFit.insideBounds(
                        maxZoom: 17,
                        minZoom: 8,
                        bounds: LatLngBounds.fromPoints([
                          LatLng(
                              43.6544405 + (43.6544405 - widget.lokacija.lat!),
                              17.9606621 +
                                  (17.9606621 - widget.lokacija.long!)),
                          LatLng(
                              widget.lokacija.lat! -
                                  (43.6544405 - widget.lokacija.lat!) * 2,
                              widget.lokacija.long! -
                                  (17.9606621 - widget.lokacija.long!) * 2)
                        ]),
                      )),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        ),
                        MarkerLayer(markers: [
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: LatLng(
                                widget.lokacija.lat!, widget.lokacija.long!),
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 50,
                            ),
                          ),
                        ])
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ]),
    );
  }

  Future<void> openMap(double latitude, double longitude) async {
    Uri googleUrl = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude');
    await launchUrl(googleUrl);
  }
}
