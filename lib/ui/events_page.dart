import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:discover/backend.dart';
import 'package:discover/entities/dogadjaj.dart';
import 'package:discover/postavke.dart';
import 'package:discover/ui/event_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventsPage extends StatefulWidget {
  final int index;
  const EventsPage({super.key, required this.index});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  late Color? textColor;
  late Color? bgColor;
  late final BorderRadius borderRadius = BorderRadius.circular(38);

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    textColor = Theme.of(context).colorScheme.inverseSurface;
    bgColor = Theme.of(context).colorScheme.surface;
    super.didChangeDependencies();
  }

  void openDogadjajPage(Dogadjaj dogadjaj) {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => EventPage(
            event: dogadjaj,
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
    final localizations = AppLocalizations.of(context)!;
    final postavke = Provider.of<Postavke>(context);
    final dogadjaji = Provider.of<Backend>(context).dogadjaji;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(
          localizations.events,
          style: TextStyle(color: textColor, fontSize: 24),
        ),
        elevation: 0,
      ),
      body: ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: dogadjaji.length,
          cacheExtent: 100,
          itemBuilder: (context, index) {
            final dogadjaj = dogadjaji[index];
            return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventPage(event: dogadjaj),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    height: 260,
                    decoration: BoxDecoration(borderRadius: borderRadius),

                    // decoration: BoxDecoration(
                    //     color: Colors.black,
                    //     borderRadius: BorderRadius.circular(30)),

                    child: Stack(
                      alignment: Alignment.center,
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: dogadjaj.slike.first,
                          fit: BoxFit.cover,
                          // filterQuality: FilterQuality.high,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(25)),
                        ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     gradient: LinearGradient(
                        //       begin: Alignment.topCenter,
                        //       end: Alignment.bottomCenter,
                        //       stops: const [0.5, 0.8],
                        //       colors: [
                        //         Colors.transparent,
                        //         Colors.black.withValues(alpha: 0.4),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          right: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  postavke.jezik == Jezik.bosanski
                                      ? dogadjaj.naziv
                                      : dogadjaj.naziv_en,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20)),
                              if (dogadjaj.vrijeme != null)
                                Text(
                                    DateFormat("EEEE, d.M.y",
                                            localizations.localeName)
                                        .format(dogadjaj.vrijeme!)
                                        .replaceFirstMapped(
                                            RegExp(r"(\w+)"),
                                            (match) =>
                                                match
                                                    .group(0)!
                                                    .substring(0, 1)
                                                    .toUpperCase() +
                                                match.group(0)!.substring(1)),
                                    style: TextStyle(
                                        color:
                                            Colors.white.withValues(alpha: 0.8),
                                        fontSize: 15,
                                        fontFamily: "Montserrat-Light",
                                        fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                // child: AspectRatio(
                //   aspectRatio: 3 / 2,
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(25),
                //     child: Stack(
                //       fit: StackFit.expand,
                //       children: [
                //         Container(
                //           color: Colors.black,
                //         ),
                //         // CachedNetworkImage(
                //         //     imageUrl: dogadjaj.slike.first, fit: BoxFit.cover),
                //         // Container(
                //         //   decoration: BoxDecoration(
                //         //     gradient: LinearGradient(
                //         //       begin: Alignment.topCenter,
                //         //       end: Alignment.bottomCenter,
                //         //       stops: const [0.5, 0.8],
                //         //       colors: [
                //         //         Colors.transparent,
                //         //         Colors.black.withValues(alpha: 0.4),
                //         //       ],
                //         //     ),
                //         //   ),
                //         // ),

                //       ],
                //     ),
                //   ),
                // ),
                );
          }),
      // body: ListView.builder(
      //     itemCount: dogadjaji.length,
      //     itemBuilder: (context, index) {
      //       final dogadjaj = dogadjaji[index];
      //       return Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: GestureDetector(
      //           onTap: () => openDogadjajPage(),
      //           child: AspectRatio(
      //             aspectRatio: 3 / 2,
      //             child: ClipRRect(
      //               borderRadius: BorderRadius.circular(25),
      //               child: Stack(
      //                 fit: StackFit.expand,
      //                 children: [
      //                   Container(
      //                     color: Colors.black,
      //                   ),
      //                   // CachedNetworkImage(
      //                   //     imageUrl: dogadjaj.slike.first, fit: BoxFit.cover),
      // Container(
      //   decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //       begin: Alignment.topCenter,
      //       end: Alignment.bottomCenter,
      //       stops: const [0.5, 0.8],
      //       colors: [
      //         Colors.transparent,
      //         Colors.black.withValues(alpha: 0.4),
      //       ],
      //     ),
      //   ),
      // ),
      //                   Positioned(
      //                     bottom: 10,
      //                     left: 10,
      //                     right: 10,
      //                     child: Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Text(
      //                             postavke.jezik == Jezik.bosanski
      //                                 ? dogadjaj.naziv
      //                                 : dogadjaj.naziv_en,
      //                             style: const TextStyle(
      //                                 color: Colors.white, fontSize: 20)),
      //                         if (dogadjaj.vrijeme != null)
      //                           Text(
      //                               DateFormat("EEEE, d.M.y",
      //                                       localizations.localeName)
      //                                   .format(dogadjaj.vrijeme!)
      //                                   .replaceFirstMapped(
      //                                       RegExp(r"(\w+)"),
      //                                       (match) =>
      //                                           match
      //                                               .group(0)!
      //                                               .substring(0, 1)
      //                                               .toUpperCase() +
      //                                           match.group(0)!.substring(1)),
      //                               style: TextStyle(
      //                                   color:
      //                                       Colors.white.withValues(alpha: 0.8),
      //                                   fontSize: 15,
      //                                   fontFamily: "Montserrat-Light",
      //                                   fontWeight: FontWeight.bold))
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ),
      //       );
      //     }),
    );
  }
}
