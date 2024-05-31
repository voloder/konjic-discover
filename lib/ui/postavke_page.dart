import 'package:discover/main.dart';
import 'package:discover/postavke.dart';
import 'package:discover/ui/privacy_policy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PostavkePage extends StatefulWidget {
  const PostavkePage({super.key});

  @override
  State<PostavkePage> createState() => _PostavkePageState();
}

class _PostavkePageState extends State<PostavkePage> {


  Map<Jezik, String> jezici = {
    Jezik.bosanski: "Bosanski",
    Jezik.engleski: "English",
  };

  @override
  Widget build(BuildContext context) {
    final postavke = Provider.of<Postavke>(context);
    final localizations = AppLocalizations.of(context)!;
    
    Map<Tema, String> teme = {
      Tema.svijetla: localizations.light,
      Tema.tamna: localizations.dark,
      Tema.auto: localizations.auto
    };

    return Scaffold(
        appBar: AppBar(
          title: Text(localizations.settings),
        ),
        body: Column(
          children: [
            Text(localizations.language),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                collapsedShape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.onSurface),
                    borderRadius: BorderRadius.circular(10)),
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.onSurface),
                    borderRadius: BorderRadius.circular(10)),
                title: Text(jezici[postavke.jezik]!),
                children: jezici.entries
                    .map((e) => ListTile(
                  title: Text(e.value),
                  onTap: () {
                    setState(() {
                      postavke.postaviJezik(e.key);
                    });
                  },
                ))
                    .toList(),
              ),
            ),
            Text(localizations.theme),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                collapsedShape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.onSurface),
                    borderRadius: BorderRadius.circular(10)),
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.onSurface),
                    borderRadius: BorderRadius.circular(10)),
                title: Text(teme[postavke.tema]!),
                children: teme.entries
                    .map((e) => ListTile(
                  title: Text(e.value),
                  onTap: () {
                    setState(() {
                      postavke.postaviTemu(e.key);
                    });
                  },
                ))
                    .toList(),
              ),
            ),
            Spacer(),
            GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(localizations.privacy),
                ),
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: "Konjic Discover",
                    applicationVersion: "Made with ❤️ by students of Srednja škola Konjic",
                    applicationIcon:
                    Center(child: Image.asset("assets/images/ikonica.png", height: 60)),
                    children: [PrivacyPolicy()],
                  );
                })
          ],
        ));
  }
}
