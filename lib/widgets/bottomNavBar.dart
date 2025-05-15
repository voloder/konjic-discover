import 'package:discover/provider/myBottomNavBarProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bottomnavbar extends StatefulWidget {
  @override
  const Bottomnavbar({
    super.key,
    required this.onTapped,
    required this.localizations,
  });
  final dynamic onTapped;
  final dynamic localizations;

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int fullscreen = 0;
  late Color backgroundColor;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
   backgroundColor = Theme.of(context).colorScheme.surface;
  }

  @override
  Widget build(BuildContext context) {
    // final localizations = Provider.of<AppLocalizations>(context);
    // final localizations = AppLocalizations.;
    if (Provider.of<Mybottomnavbarprovider>(context).currentIndex == 0) {
      backgroundColor = Colors.transparent;
      setState(() {
        
      });
    }
    return BottomNavigationBar(
      
      showUnselectedLabels: false,
      elevation: 0,
      enableFeedback: false,
      selectedIconTheme: const IconThemeData(size: 29),
      fixedColor: Theme.of(context).colorScheme.inverseSurface,
      backgroundColor: backgroundColor,
      unselectedItemColor:
          Theme.of(context).colorScheme.inverseSurface.withValues(alpha: 0.4),
      items: [
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.map,
          ),
          label: widget.localizations.events,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: widget.localizations.discover,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: widget.localizations.settings,
        ),
      ],
      onTap: widget.onTapped,
      currentIndex: Provider.of<Mybottomnavbarprovider>(context).currentIndex,
    );
  }
}
