import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:discover/entities/kategorija.dart';
import 'package:discover/postavke.dart';
import 'package:discover/ui/lokacije.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationWidget extends StatefulWidget {
  Kategorija kategorija;
  LocationWidget({super.key, required this.kategorija});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  void openLokacijePage(Kategorija kategorija) {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => LokacijePage(
            kategorija: kategorija,
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
    final postavke = Provider.of<Postavke>(context);

    Jezik jezik = postavke.jezik!;

    return GestureDetector(
      onTap: () => openLokacijePage(widget.kategorija),
      child: Row(
        children: [
          SizedBox(
              width: 200,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    // fadeInDuration:
                    //     const Duration(milliseconds: 300),
                    // fadeOutDuration:
                    //     const Duration(milliseconds: 300),
                    // filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                    imageUrl: widget.kategorija.slika!,
                    // memCacheWidth: 700,
                    // memCacheHeight:700,

                    // placeholder: (context, ulr) =>
                    //     Shimmer.fromColors(
                    //   period:
                    //       const Duration(milliseconds: 800),
                    //   baseColor: Colors.grey.shade400,
                    //   highlightColor: Colors.grey.shade300,
                    //   child: Container(
                    //     width: 120,
                    //     height: 170,
                    //     color: Colors.grey.shade400,
                    //   ),
                    // ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  Center(
                      child: AutoSizeText(
                    minFontSize: 20,
                    softWrap: true,
                    wrapWords: false,
                    jezik == Jezik.bosanski
                        ? widget.kategorija.naziv.toUpperCase()
                        : widget.kategorija.naziv_en.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  )),
                ],
              )),
          const SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }
}
