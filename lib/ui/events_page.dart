// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:discover/backend.dart';
// import 'package:discover/entities/dogadjaj.dart';
// import 'package:discover/postavke.dart';
// import 'package:discover/ui/event_page.dart';
// import 'package:discover/widgets/event_container.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// class EventsPage extends StatefulWidget {
//   // final int index;
//   const EventsPage({super.key});

//   @override
//   State<EventsPage> createState() => _EventsPageState();
// }

// class _EventsPageState extends State<EventsPage> {
//   late Color? textColor;
//   late Color? bgColor;
//   late final BorderRadius borderRadius = BorderRadius.circular(38);

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     textColor = Theme.of(context).colorScheme.inverseSurface;
//     bgColor = Theme.of(context).colorScheme.surface;
//     super.didChangeDependencies();
//   }

//   void openDogadjajPage(Dogadjaj dogadjaj) {
//     Navigator.push(
//         context,
//         PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) => EventPage(
//             event: dogadjaj,
//           ),
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             const begin = Offset(0.0, 1.0);
//             const end = Offset.zero;
//             const curve = Curves.linearToEaseOut;
//             var tween =
//                 Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//             return SlideTransition(
//               position: animation.drive(tween),
//               child: child,
//             );
//           },
//         ));
//     // Navigator.of(context).push(
//     //   MaterialPageRoute(builder: (context) => DetailsPage(item: item)),
//     // );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final localizations = AppLocalizations.of(context)!;
//     final dogadjaji = Provider.of<Backend>(context).dogadjaji;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: bgColor,
//         title: Text(
//           localizations.events,
//           style: TextStyle(color: textColor, fontSize: 24),
//         ),
//         elevation: 0,
//       ),
//       body: ListView.builder(
//           shrinkWrap: true,
//           physics: const ScrollPhysics(),
//           itemCount: dogadjaji.length,
//           cacheExtent: 100,
//           itemBuilder: (context, index) {
//             final dogadjaj = dogadjaji[index];
//             return EventContainer(
//                 dogadjaj: dogadjaj,
//                 localizations: localizations,
//                 postavke: Provider.of<Postavke>(context));
//           }),
//     );
//   }
// }
