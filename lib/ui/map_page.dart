import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:discover/ui/lokacija_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../backend.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    final backend = Provider.of<Backend>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Map"),
        backgroundColor:
            Theme.of(context).colorScheme.surface.withOpacity(0),
        elevation: 0,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: Container(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
            ),
          ),
        ),
      ),
      body: FlutterMap(
        options: const MapOptions(
            initialCameraFit: CameraFit.coordinates(
                maxZoom: 15, coordinates: [LatLng(43.6511245, 17.9626887)])),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          MarkerLayer(
              markers: backend.lokacije
                  .map((e) => Marker(
                      height: 50,
                      width: 50,
                      rotate: true,
                      point: LatLng(e.lat ?? 0, e.long ?? 0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LokacijaPage(lokacija: e)));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: e.slike.first,
                          ),
                        ),
                      )))
                  .toList())
        ],
      ),
    );
  }
}
