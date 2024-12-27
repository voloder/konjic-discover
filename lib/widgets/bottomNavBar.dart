import 'package:discover/provider/myBottomNavBarProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bottomnavbar extends StatelessWidget {
  @override
  const Bottomnavbar({
    super.key,
    required this.onTapped,
    required this.localizations,
    
  });
  final dynamic onTapped;
  final dynamic localizations;
  @override
  Widget build(BuildContext context) {
    // final localizations = Provider.of<AppLocalizations>(context);
    // final localizations = AppLocalizations.;
    return BottomNavigationBar(
      showUnselectedLabels: false,
      elevation: 0,
      enableFeedback: false,
      selectedIconTheme: const IconThemeData(size: 29),
      fixedColor: Theme.of(context).colorScheme.inverseSurface,
      backgroundColor: Theme.of(context).colorScheme.surface,
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
      onTap: onTapped,
      
      currentIndex:
          Provider.of<Mybottomnavbarprovider>(context).currentIndex,
    );
  }
}
