import 'package:discover/postavke.dart';
import 'package:discover/ui/home.dart';
import 'package:discover/ui/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final postavke = Provider.of<Postavke>(context);
    final jezik = postavke.jezik!;

    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset("assets/images/ikonica.png", height: 85),
              const Spacer(),
              Text(
                localizations.chooseLanguage,
                style: const TextStyle(
                  fontFamily: "Montserrat-Light",
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              DropdownMenu(
                textStyle: const TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                ),
                initialSelection: jezik,

                inputDecorationTheme: InputDecorationTheme(
                  contentPadding: const EdgeInsets.symmetric(horizontal:30, vertical: 10),
                  labelStyle: const TextStyle(color: Colors.lightBlue),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(6),
                  ),

                ),
                dropdownMenuEntries: const <DropdownMenuEntry>[
                  DropdownMenuEntry(
                    label: "Bosanski",
                    value: Jezik.bosanski,
                  ),
                  DropdownMenuEntry(
                    label: "English",
                    value: Jezik.engleski,
                  ),
                ],
                onSelected: (value) {
                  postavke.postaviJezik(value);
                },
              ),
              const Spacer(),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                  );
                  postavke.postaviPrviPut(false);
                },
                child:  Text(
                  localizations.continueButton,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              const Spacer(),
              const Text("Konjic Discover", style: TextStyle(fontFamily: "Montserrat-Light")),
            ],
          ),
        ));
  }
}
