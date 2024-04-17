import 'package:discover/backend.dart';
import 'package:discover/ui/home.dart';
import 'package:discover/postavke.dart';
import 'package:discover/ui/start_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final backend = Backend();
  try {
    await backend.initialize();
    await backend.ucitaj();
  } catch (e) {
    runApp(const Material(
        child: Center(
            child: Text(
                "Pokrenite aplikaciju sa internet konekcijom kako bi se podaci učitali."))));
  }
  final postavke = Postavke();
  await postavke.ucitaj();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: postavke),
      Provider.value(value: backend)
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final postavke = Provider.of<Postavke>(context);
    return MaterialApp(
        title: 'Flutter Demo',
        themeMode: postavke.tema == Tema.auto
            ? null
            : postavke.tema == Tema.svijetla
                ? ThemeMode.light
                : ThemeMode.dark,
        theme: ThemeData(
          fontFamily: 'Montserrat',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          fontFamily: 'Montserrat',
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
              surface: const Color(0xff1d282c)),
          useMaterial3: true,
          brightness: Brightness.dark,
        ),
        home: postavke.prviPut! ? const StartPage() : const HomePage());
  }
}
