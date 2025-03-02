import 'package:discover/provider/myBottomNavBarProvider.dart';
import 'package:discover/ui/events_page.dart';
import 'package:discover/ui/home.dart';
import 'package:discover/ui/postavke_page.dart';
import 'package:discover/widgets/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 1;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1, viewportFraction: 1);
    // _pageController.addListener(() {
    //   // print("test");
    //   // setState(() {
    //   //   currentIndex = _pageController.page!.round();
    //   // });
    // }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onTap(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }
  // void onTap(int index) {
  //   setState(() {
  //     currentIndex = index;
  //     _pageController.animateToPage(currentIndex,
  //         duration: const Duration(milliseconds: 400), curve: Curves.ease);
  //   });
  // }

  // final List<dynamic> list = const [
  //   // Scaffold(backgroundColor: Colors.yellow)
  //   // Scaffold(backgroundColor: Colors.black),
  //   // Scaffold(backgroundColor: Colors.red),
  //   EventsPage(),
  //   HomePage(),
  //   PostavkePage(),
  // ];

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: PageView.builder(
        itemCount: 3,
        controller: _pageController,
        // pageSnapping: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          switch (index) {
            case 1:
              return const HomePage();
            case 0:
              return const EventsPage();
            case 2:
              return const PostavkePage();
          }
          ;
          return null;
        },
        onPageChanged: (value) =>
            Provider.of<Mybottomnavbarprovider>(context, listen: false)
                .setvalue(value),
      ),
      bottomNavigationBar:
          Bottomnavbar(onTapped: onTap, localizations: localizations),
    );
  }
}




// BottomNavigationBar(
//           showUnselectedLabels: false,
//           elevation: 0,
//           enableFeedback: false,
//           selectedIconTheme: const IconThemeData(size: 29),
//           fixedColor: Theme.of(context).colorScheme.inverseSurface,
//           backgroundColor: Theme.of(context).colorScheme.surface,
//           currentIndex: currentIndex,
//           unselectedItemColor:
//               Theme.of(context).colorScheme.inverseSurface.withOpacity(0.4),
//           items: [
//             BottomNavigationBarItem(
//               icon: const Icon(
//                 Icons.event,
//               ),
//               label: localizations.events,
//             ),
//             BottomNavigationBarItem(
//               icon: const Icon(Icons.home),
//               label: localizations.discover,
//             ),
//             BottomNavigationBarItem(
//               icon: const Icon(Icons.settings),
//               label: localizations.settings,
//             ),
//           ],
//           onTap: onTap,
//         ));