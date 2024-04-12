import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'entities/lokacija.dart';

class LokacijaPage extends StatefulWidget {
  final Lokacija lokacija;
  const LokacijaPage({super.key, required this.lokacija});

  @override
  State<LokacijaPage> createState() => _LokacijaPageState();
}

class _LokacijaPageState extends State<LokacijaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lokacija.naslov),
      ),
      body: ListView(
        children: [
          if(widget.lokacija.slike.isNotEmpty) CarouselSlider(
            options: CarouselOptions(height: 400.0),
            items: widget.lokacija.slike.map((e) => Image.network(e)).toList(),
          ),

          if(widget.lokacija.deskripcija.isNotEmpty) ListTile(
            title: Text("Opis"),
            subtitle: Text(widget.lokacija.deskripcija),
          ),
          ...widget.lokacija.detalji.entries.map((e) => ListTile(
                title: Text(e.key),
                subtitle: Text(e.value),
              )),
          Text(widget.lokacija.lokacija),
        ],
      ),
    );
  }
}
