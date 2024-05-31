import 'package:cached_network_image/cached_network_image.dart';
import 'package:discover/backend.dart';
import 'package:discover/ui/event_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final dogadjaji = Provider.of<Backend>(context).dogadjaji;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Events"),
      ),
      body: ListView.builder(
          itemCount: dogadjaji.length,
          itemBuilder: (context, index) {
            final dogadjaj = dogadjaji[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventPage(event: dogadjaj)));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                          height: 250,
                          imageUrl: dogadjaj.slike.first,
                          fit: BoxFit.cover),
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
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
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(dogadjaj.naziv,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            Text(DateFormat("EEEE, d.M.y").format(dogadjaj.vrijeme),
                                style:  TextStyle(
                                    color: Colors.white.withOpacity(0.7), fontSize: 15, fontFamily: "Montserrat-Light"))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
