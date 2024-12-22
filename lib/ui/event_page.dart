import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:discover/entities/dogadjaj.dart';
import 'package:discover/postavke.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
    final postavke = Provider.of<Postavke>(context);

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
                        color: Theme.of(context)
                            .colorScheme
                            .surface
                            .withOpacity(
                                min(offset / _imageHeight * 1.2, 1.0))),
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
                        Positioned(
                          bottom: 10,
                          left: 10,
                          right: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(postavke.jezik == Jezik.bosanski ? event.naziv : event.naziv_en,
                                  style: const TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              if (event.vrijeme != null)
                                Text(
                                    DateFormat("EEEE, d.M.y", localizations.localeName)
                                        .format(event.vrijeme!).replaceFirstMapped(
                                            RegExp(r"(\w+)"),
                                            (match) => match.group(0)!.substring(0, 1).toUpperCase() + match.group(0)!.substring(1)),
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Montserrat-Light",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white))
                            ],
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
                                      offset: const Offset(0, 0),
                                      blurRadius: 10)
                                ],
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),

            Container(
              margin: const EdgeInsets.only(top: 300),
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Center(
                      child: MarkdownBody(

                          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                            textAlign: WrapAlignment.spaceEvenly,
                            blockquoteDecoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                          ),
                          data: postavke.jezik == Jezik.bosanski ? event.opis : event.opis_en))
                ],
              ),
            ),
            Transform.translate(
              offset: Offset(0, offset),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 100),
                opacity: offset > (_imageHeight / 1.3) ? 1.0 : 0.0,
                child: AppBar(
                  title: Text(postavke.jezik == Jezik.bosanski ? event.naziv : event.naziv_en),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
