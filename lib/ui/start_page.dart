import 'package:discover/postavke.dart';
import 'package:discover/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    final postavke = Provider.of<Postavke>(context);
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Image.asset("assets/images/ikonica.png", height: 85),
          Spacer(),
          Text(
            "CHOOSE YOUR LANGUAGE",
            style: TextStyle(
              fontFamily: "Montserrat-Light",
              fontSize: 22,
            ),
            textAlign: TextAlign.center,
          ),
          Spacer(),
          DropdownMenu(
            textStyle: TextStyle(
              color: Colors.blue,
              fontSize: 15,
            ),
            initialSelection: Jezik.engleski,

            inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.symmetric(horizontal:30, vertical: 10),
              labelStyle: TextStyle(color: Colors.lightBlue),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(6),
              ),

            ),
            dropdownMenuEntries: <DropdownMenuEntry>[
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
          Spacer(),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
              postavke.postaviPrviPut(false);
            },
            child: const Text(
              "CONTINUE",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Spacer(),
          Text("Konjic Discover", style: TextStyle(fontFamily: "Montserrat-Light")),
        ],
      ),
    ));
  }
}
