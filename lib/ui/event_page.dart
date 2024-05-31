import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:discover/entities/dogadjaj.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class EventPage extends StatefulWidget {
  final Dogadjaj event;

  const EventPage({super.key, required this.event});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  late final localizations = AppLocalizations.of(context)!;
  late final scrollController = ScrollController();
  late final event = widget.event;
  double offset = 0;
  final double _imageHeight = 300;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      setState(() {
        offset = scrollController.offset;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        child: Stack(
          children: [
            if (offset < _imageHeight)
              Transform.translate(
                  offset: Offset(0, offset),
                  child: Container(
                    foregroundDecoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface.withOpacity(
                          min(offset / _imageHeight * 1.2, 1.0))
                    ),
                    child: Stack(
                      children: [
                        Container(
                          foregroundDecoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0.5, 0.8],
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.4),
                              ],
                            ),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: event.slike.first,
                            height: _imageHeight - offset,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                        SafeArea(
                          child: GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                shadows: [
                                  Shadow(
                                      color: Colors.black.withOpacity(0.3),
                                      offset: Offset(0, 0),
                                      blurRadius: 10)
                                ],
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(event.naziv,
                                  style: const TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  DateFormat("EEEE, d.M.y").format(event.vrijeme) ,

                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Montserrat-Light",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))
                            ],
                          ),
                        ),

                      ],
                    ),
                  )),
            Container(
              margin: const EdgeInsets.only(top: 300),
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [Center(child: Text(event.opis))],
              ),
            ),
            Transform.translate(
              offset: Offset(0, offset),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 100),
                opacity: offset > (_imageHeight / 1.2) ? 1.0 : 0.0,
                child: AppBar(
                  title: Text(event.naziv),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
