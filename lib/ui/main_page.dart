import 'package:discover/ui/events_page.dart';
import 'package:discover/ui/home.dart';
import 'package:discover/ui/map_page.dart';
import 'package:discover/ui/postavke_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 1;
  late final _tabController = TabController(length: 3, vsync: this, initialIndex: 1);

  @override
  void initState() {
    super.initState();
    _tabController.animation?.addListener(() {
      setState(() {
        _selectedIndex = _tabController.animation!.value.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
        body: TabBarView(
          controller: _tabController,
          children: [
            const EventsPage(),
            const HomePage(),
            const PostavkePage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.event),
              label: localizations.events,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: localizations.discover,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: localizations.settings),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              _tabController.animateTo(index);
            });
          },
        ));
  }
}
