import 'package:discover/ui/events_page.dart';
import 'package:discover/ui/home.dart';
import 'package:discover/ui/postavke_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List list = const [
    // Scaffold(backgroundColor: Colors.yellow)
    // Scaffold(backgroundColor: Colors.black),
    // Scaffold(backgroundColor: Colors.red),
    EventsPage(),
    HomePage(),
    PostavkePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: PageView.builder(
        itemCount: list.length,
        controller: _pageController,
        pageSnapping: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return list[index];
        },
        onPageChanged: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        elevation: 0,
        enableFeedback: false,
        selectedIconTheme: const IconThemeData(size: 29),
        fixedColor: Theme.of(context).colorScheme.inverseSurface,
        backgroundColor: Theme.of(context).colorScheme.surface,
        currentIndex: currentIndex,
        unselectedItemColor:
            Theme.of(context).colorScheme.inverseSurface.withOpacity(0.4),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.event,
            ),
            label: localizations.events,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: localizations.discover,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: localizations.settings,
          ),
        ],
        onTap: (index) {
          currentIndex = index;

          setState(() {
            _pageController.animateToPage(currentIndex,
                duration: const Duration(milliseconds: 400),
                curve: Curves.ease);
          });
        },
      )
    );
  }
}
