import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hangman/hangman_base.dart';
import 'package:system_settings/system_settings.dart';

typedef void tripleCallBack(
    String? language, String? wordLength, String? attempts);
typedef void singleInputCallback(String language);

class NewGame extends StatefulWidget {
  final PageController controller;
  final VoidCallback createNewGame;
  final tripleCallBack createNewGameWithConfig;
  final String? value;
  final String? wordLength;
  final String? attempts;
  final singleInputCallback setLocale;
  const NewGame({
    Key? key,
    required this.controller,
    required this.createNewGame,
    required this.createNewGameWithConfig,
    required this.value,
    required this.attempts,
    required this.wordLength,
    required this.setLocale,
  }) : super(key: key);

  @override
  _NewGameState createState() => _NewGameState();
}

class _NewGameState extends State<NewGame> {
  _NewGameState();

  String? _value;
  String? _wordLength;
  String? _attempts;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
    _wordLength = widget.wordLength;
    _attempts = widget.attempts;
  }

  goToNewGame() {
    widget.controller.animateToPage(2,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
    widget.createNewGame();
  }

  createNewGame() {
    widget.controller.animateToPage(2,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
    widget.createNewGameWithConfig(_value, _wordLength, _attempts);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildTitleSection(),
        buildDropdownSection(),
        buildAttemptDropdown(),
        buildWordLengthDropdown(),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: ElevatedButton(
            onPressed: createNewGame,
            child: Text(AppLocalizations.of(context)!.newGameButton),
          ),
        ),
      ],
    );
  }

  List<String> createLanguages() {
    return ["Use System Language", "English", "Norwegian"];
  }

  List<String> wordLengthList() {
    return ["Random", '2', '3', '4', '5', '6'];
  }

  final attemptsList = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(item),
    );
  }

  Widget buildDropdownSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Center(
        child: Row(
          children: [
            Text(AppLocalizations.of(context)!.languageSelector),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: DropdownButton<String>(
                  value: _value,
                  items: createLanguages().map(buildMenuItem).toList(),
                  onChanged: (language) => setLocale(language!)),
            ),
            const IconButton(
                onPressed: SystemSettings.locale, icon: Icon(Icons.settings))
          ],
        ),
      ),
    );
  }

  setLocale(String locale) {
    if (locale == "Norwegian" || locale == "Norsk") {
      widget.setLocale("no");
    } else if (locale == "English" || locale == "Engelsk") {
      widget.setLocale("en");
    } else {
      widget.setLocale(Platform.localeName);
    }
    setState(
      () => _value = locale,
    );
  }

  Widget buildWordLengthDropdown() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Center(
        child: Row(
          children: [
            Text(AppLocalizations.of(context)!.wordLengthSelector),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: DropdownButton<String>(
                value: _wordLength,
                items: wordLengthList().map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => _wordLength = value),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAttemptDropdown() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Center(
        child: Row(
          children: [
            Text(AppLocalizations.of(context)!.attemptsSelector),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: DropdownButton<String>(
                value: _attempts,
                items: attemptsList.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => _attempts = value),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNewGameColumn() {
    return Row(
      children: [
        Expanded(
          child: buildTitleSection(),
        ),
        //Expanded(child: child)
      ],
    );
  }

  Widget buildTitleSection() {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: RichText(
            text: TextSpan(
          text: AppLocalizations.of(context)!.newGameTitle,
          style: const TextStyle(
              fontSize: 36.0, fontStyle: FontStyle.italic, color: Colors.black),
        )),
      ),
    );
  }
}
