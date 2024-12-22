import 'package:discover/backend.dart';
import 'package:discover/postavke.dart';
import 'package:discover/ui/main_page.dart';
import 'package:discover/ui/start_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  final backend = Backend();
  try {
    await backend.initialize();
    await backend.ucitaj();
  } catch (e) {
    runApp(const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text("Please check your internet connection and try again."),
        ),
      ),
    ));
    return;
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
    //UCITAJ SVE SLIKE
    final backend = Provider.of<Backend>(context);
    final postavke = Provider.of<Postavke>(context);
    backend.precacheImagesForDogadjaj(context);
    backend.precacheImagesForKategorija(context);
    backend.precacheImagesForLokacija(context);
    return MaterialApp(
        // showPerformanceOverlay: true,
        debugShowCheckedModeBanner: false,
        title: "Konjic Discover",
        themeMode: postavke.tema == Tema.auto
            ? null
            : postavke.tema == Tema.svijetla
                ? ThemeMode.light
                : ThemeMode.dark,
        theme: ThemeData(
          fontFamily: "Montserrat",
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue, surfaceTint: Colors.white),
          useMaterial3: false,
          brightness: Brightness.light,
        ),
        locale: postavke.jezik == Jezik.bosanski
            ? const Locale("bs")
            : const Locale("en"),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates
        ],
        supportedLocales: const [
          Locale("en"),
          Locale("bs"),
        ],
        darkTheme: ThemeData(
          fontFamily: "Montserrat",
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
              surfaceTint: Colors.transparent),
          useMaterial3: false,
          brightness: Brightness.dark,
        ),
        home: postavke.prviPut! ? const StartPage() : const MainPage()
        // home: const HomePage(),
        );
  }
}
