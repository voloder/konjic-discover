import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:discover/postavke.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';
import '../entities/lokacija.dart';

class LokacijaPage extends StatefulWidget {
  final Lokacija lokacija;

  const LokacijaPage({super.key, required this.lokacija});

  @override
  State<LokacijaPage> createState() => _LokacijaPageState();
}

class _LokacijaPageState extends State<LokacijaPage> {
  @override
  Widget build(BuildContext context) {
    final postavke = Provider.of<Postavke>(context);
    final jezik = postavke.jezik!;
    String prikaziNaMapi = jezik == Jezik.engleski
        ? "Open in Google Maps"
        : "Otvori u Google Maps";
    final opis = Jezik.bosanski == jezik
        ? widget.lokacija.opis
        : widget.lokacija.opisEn;

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
                CarouselSlider(
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                    enlargeFactor: 0.4,
                  ),
                  items: widget.lokacija.slike
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Hero(
                                tag: e,
                                child: CachedNetworkImage(
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  imageUrl: e,
                                  fadeInDuration: Duration(milliseconds: 300),
                                  fadeOutDuration: Duration(milliseconds: 300),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              if (opis.isNotEmpty)
                ListTile(
                  title: Text(jezik == Jezik.bosanski ? "Opis" : "Description"),
                  subtitle: Text(opis,
                      textAlign: TextAlign.justify),
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
                    child: Text(prikaziNaMapi),
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
                          LatLng( 43.6544405 + (43.6544405 - widget.lokacija.lat!) , 17.9606621 + (17.9606621 - widget.lokacija.long!)),
                          LatLng(widget.lokacija.lat! - (43.6544405 - widget.lokacija.lat!) * 2,
                              widget.lokacija.long! - (17.9606621 - widget.lokacija.long!) * 2)
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
                            child: Icon(
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
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
    await launchUrl(googleUrl);
  }
}
