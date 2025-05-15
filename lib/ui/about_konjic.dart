import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:discover/backend.dart';
import 'package:discover/entities/konjic_info.dart';
import 'package:discover/entities/sekcija.dart';
import 'package:discover/ui/city_info_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutKonjic extends StatefulWidget {
  const AboutKonjic({super.key});

  @override
  State<AboutKonjic> createState() => _AboutKonjicState();
}

class _AboutKonjicState extends State<AboutKonjic> {
  // final List<String> titleImages = [
  //   "assets/images/title1.jpg",
  //   "assets/images/title2.jpg",
  //   "assets/images/title3.jpg",
  // ];
  // final List<String> titleImages2 = [
  //   "https://th.bing.com/th/id/R.1475c659419aff7b0e6e15482825b536?rik=gIJW4o%2favPWwzA&riu=http%3a%2f%2fmondesetmerveilles.m.o.pic.centerblog.net%2fo%2felephant-animal-hd-wallpaper-free-download.jpg&ehk=ve4I2pxW09bSo%2b963oef40YFHaqZ5ixZkx8y%2fHWEDxA%3d&risl=&pid=ImgRaw&r=0",
  //   "https://th.bing.com/th/id/OIP.WbeIkHpkJGwAkiRD6rPpeAHaE8?rs=1&pid=ImgDetMain",
  // ];

  // late String naslovImage = titleImages[0];
  late String naslovImage2;
  late final List<String> titleImages2;
  int countingIndex = 0;
  late final Backend backend;

  late double opacity;
  // late final Postavke postavke;
  late final List<Sekcija> sekcije;
  // late final naslovImage =  "assets/images/konjic.jpg";

  @override
  void initState() {
    super.initState();

    // postavke = Provider.of<Postavke>(context, listen: false);
    backend = Provider.of<Backend>(context, listen: false);
    sekcije = backend.sekcije;
    startImageSwitchTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    titleImages2 = backend.konjicInfo.first.slike;
  
    opacity = Theme.of(context).brightness == Brightness.dark ? 0.6 : 1;
  }

  late Timer _timer;

  void startImageSwitchTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        countingIndex = (countingIndex + 1) % titleImages2.length;
        naslovImage2 = titleImages2[countingIndex];
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CityInfoPage()),
        );
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        child: SizedBox(
          height: 190,
          width: double.infinity,
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: titleImages2[countingIndex],
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                width: double.infinity,
                height: 190,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                    backgroundColor: Colors.black,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.5),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "KONJIC",
                      style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      "Tap to see more",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const CityInfoPage()),
//                 );
//               },
//               child: Container(
//                 height: 190,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                     borderRadius: const BorderRadius.only(
//                         bottomLeft: Radius.circular(25),
//                         bottomRight: Radius.circular(25)),
//                     image: DecorationImage(
//                       opacity: opacity,
//                       image: AssetImage(naslovImage),
//                       fit: BoxFit.cover,
//                       filterQuality: FilterQuality.high,
//                     )),
//                 child: const Center(
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "KONJIC",
//                           style: TextStyle(
//                               fontSize: 34,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white),
//                         ),
//                         Text(
//                           "Tap to see more",
//                           style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white),
//                         ),
//                       ]),
//                 ),
//               ),
//             );
    
