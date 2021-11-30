import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dictionary.dart';
import 'hangman.dart';
import 'hangman_game.dart';
import 'information.dart';
import 'new_game.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
  final singleInputCallback setLocale;
  const Home({Key? key, required this.setLocale}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  late HangMan game;
  late Dictionary dict;
  late String? _wordLength;
  late String _language;
  String? _attempts = "5";

  var hangManGameKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _wordLength = "Random";
    _language = "Use System Language";
    dict = Dictionary(_language);
    game = HangMan(dict.getNewWord(5), 5);
  }

  String getLanguage(String lang) {
    if (lang == "Use System Language") {
      String locale = Platform.localeName;
      if (locale.toLowerCase().contains("en")) {
        return "en";
      } else {
        return "no";
      }
    }
    if (lang == "Norwegian" || lang == "norsk") {
      return "no";
    } else {
      return "en";
    }
  }

  final _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("HangMan!"),
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: buildPageView(),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          items: buildNavigationItems()),
    );
  }

  createNewGame() {
    setState(() {
      dict = Dictionary(getLanguage(_language));
      game = HangMan(
          dict.getNewWord(_wordLength == "Random"
              ? 2 + Random().nextInt(4)
              : int.parse(_wordLength!).toInt()),
          int.parse(_attempts!));
      hangManGameKey = UniqueKey();
    });
  }

  createNewGameWitgConfig(
      String? language, String? wordlength, String? attempts) {
    setState(() {
      if (language != null) {
        _language = language;
      }
      if (wordlength != null) {
        _wordLength = wordlength;
      }
      if (attempts != null) {
        _attempts = attempts;
      }
    });

    createNewGame();
  }

  List<BottomNavigationBarItem> buildNavigationItems() {
    return [
      BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        label: AppLocalizations.of(context)!.information,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.new_label),
        label: AppLocalizations.of(context)!.newGame,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.gamepad),
        label: AppLocalizations.of(context)!.hangMan,
      ),
    ];
  }

  Widget buildPageView() {
    return PageView(
      controller: _controller,
      onPageChanged: (value) {
        onPageChanged(value);
      },
      scrollDirection: Axis.horizontal,
      children: createPages(),
    );
  }

  void onPageChanged(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
      _controller.animateToPage(value,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  List<Widget> createPages() {
    return <Widget>[
      const InformationPage(),
      NewGame(
        controller: _controller,
        createNewGame: createNewGame,
        createNewGameWithConfig: createNewGameWitgConfig,
        attempts: _attempts.toString(),
        value: _language,
        wordLength: _wordLength.toString(),
        setLocale: widget.setLocale,
      ),
      HangManGame(
          controller: _controller,
          //key: hangManGameKey,
          game: game,
          key: hangManGameKey,
          createNewGame: createNewGame)
    ];
  }
}
