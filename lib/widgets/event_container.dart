// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:discover/entities/dogadjaj.dart';
// import 'package:discover/postavke.dart';
// import 'package:discover/ui/event_page.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:provider/provider.dart';

// class EventContainer extends StatefulWidget {
//   final Dogadjaj dogadjaj;
//   final AppLocalizations localizations;
//   final Postavke postavke;
//   const EventContainer({
//     required this.dogadjaj,
//     required this.localizations,
//     required this.postavke,
//     super.key,
//   });

//   @override
//   State<EventContainer> createState() => _EventContainerState();
// }

// class _EventContainerState extends State<EventContainer> {
//   @override
//   Widget build(BuildContext context) {
//     final dogadjaj = widget.dogadjaj;
//     final borderRadius = BorderRadius.circular(20);
//     final Color color = Colors.white.withValues(alpha: 0.8);
//     final localizations = AppLocalizations.of(context)!;
//     final postavke = Provider.of<Postavke>(context);

//     return GestureDetector(
//         onTap: () => Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => EventPage(event: dogadjaj),
//             )),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             clipBehavior: Clip.hardEdge,
//             height: 260,
//             decoration: BoxDecoration(borderRadius: borderRadius),

//             // decoration: BoxDecoration(
//             //     color: Colors.black,
//             //     borderRadius: BorderRadius.circular(30)),

//             child: Stack(
//               alignment: Alignment.center,
//               fit: StackFit.expand,
//               children: [
//                 CachedNetworkImage(
//                   imageUrl: dogadjaj.slike.first,
//                   fit: BoxFit.cover,
//                   // filterQuality: FilterQuality.high,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                       color: Colors.black.withValues(alpha: 0.2),
//                       borderRadius: borderRadius),
//                 ),
//                 // Container(
//                 //   decoration: BoxDecoration(
//                 //     gradient: LinearGradient(
//                 //       begin: Alignment.topCenter,
//                 //       end: Alignment.bottomCenter,
//                 //       stops: const [0.5, 0.8],
//                 //       colors: [
//                 //         Colors.transparent,
//                 //         Colors.black.withValues(alpha: 0.4),
//                 //       ],
//                 //     ),
//                 //   ),
//                 // ),
//                 Positioned(
//                   bottom: 10,
//                   left: 10,
//                   right: 10,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                           postavke.jezik == Jezik.bosanski
//                               ? dogadjaj.naziv
//                               : dogadjaj.naziv_en,
//                           style: const TextStyle(
//                               color: Colors.white, fontSize: 20)),
//                       if (dogadjaj.vrijeme != null)
//                         Text(
//                             DateFormat("EEEE, d.M.y", localizations.localeName)
//                                 .format(dogadjaj.vrijeme!)
//                                 .replaceFirstMapped(
//                                     RegExp(r"(\w+)"),
//                                     (match) =>
//                                         match
//                                             .group(0)!
//                                             .substring(0, 1)
//                                             .toUpperCase() +
//                                         match.group(0)!.substring(1)),
//                             style: TextStyle(
//                                 color: color,
//                                 fontSize: 15,
//                                 fontFamily: "Montserrat-Light",
//                                 fontWeight: FontWeight.bold))
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }
