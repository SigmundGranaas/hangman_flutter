import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hangman/home.dart';

class HangManBase extends StatefulWidget {
  const HangManBase({Key? key}) : super(key: key);
  @override
  State<HangManBase> createState() => _HangManBaseState();
}

class _HangManBaseState extends State<HangManBase> {
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _locale = Locale(Platform.localeName);
  }

  void setLocale(String locale) {
    setState(() {
      _locale = Locale(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: Colors.amber,
        title: "HangMan",
        theme: ThemeData(
          // Define the default brightness and colors.
          //brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],

          // Define the default font family.

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
              //headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              //headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              //bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
              ),
        ),
        supportedLocales: const [
          Locale('en', ''), // English, no country code
          Locale('no', 'NO'), // Norwegian, no country code
        ],
        locale: _locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: Home(
          setLocale: setLocale,
        ));
  }
}
