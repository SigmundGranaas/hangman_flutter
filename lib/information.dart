import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: [
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: RichText(
                text: TextSpan(
                  text: AppLocalizations.of(context)!.howToPlay,
                  style: const TextStyle(fontSize: 36.0, color: Colors.black),
                ),
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: RichText(
                text: TextSpan(
                  text: AppLocalizations.of(context)!.howToStartGame,
                  style: const TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: RichText(
                text: TextSpan(
                  text: AppLocalizations.of(context)!.rules,
                  style: const TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: RichText(
                text: TextSpan(
                  text: AppLocalizations.of(context)!.howToSwitchLanguage,
                  style: const TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: RichText(
                text: TextSpan(
                  text: AppLocalizations.of(context)!.howToWin,
                  style: const TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ),
            )
          ],
        ));
  }
}
