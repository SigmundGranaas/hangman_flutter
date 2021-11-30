import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hangman/hangman.dart';

class HangManGame extends StatefulWidget {
  final PageController controller;
  final HangMan game;
  final VoidCallback createNewGame;
  const HangManGame(
      {Key? key,
      required this.controller,
      required this.game,
      required this.createNewGame})
      : super(key: key);

  @override
  State<HangManGame> createState() => _HangManGameState();
}

class _HangManGameState extends State<HangManGame> {
  get goToNewGame => null;
  final myController = TextEditingController();
  var _attemptsLeft = 0;
  var _totalGuesses = 0;
  var lastGuess = "";
  late HashMap<String, int> rightGuesses;
  late HashMap<String, int> _guesses;
  String? _inputErrorText = null;

  @override
  void initState() {
    super.initState();
    _attemptsLeft = widget.game.attempts;
    _totalGuesses = widget.game.attempts;
    _guesses = widget.game.guessedLetters;
    rightGuesses = widget.game.correctlyGuessedLetters;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildHangManScene(_attemptsLeft, _totalGuesses),
        showGuessedCharacters(rightGuesses),
        createAttemptsRow(_attemptsLeft, _guesses),
        createGuessedCharacterInput(_inputErrorText),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: ElevatedButton(
            onPressed: widget.createNewGame,
            child: Text(AppLocalizations.of(context)!.restartButton),
          ),
        ),
      ],
    );
  }

  Widget buildHangManScene(int guessesLeft, int totalGuesses) {
    return Center(
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          height: 150,
          child: renderHangMan(guessesLeft, totalGuesses)),
    );
  }

  Widget showGuessedCharacters(HashMap<String, int> rightGuesses) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: createRightGuessedCharacters(rightGuesses),
      ),
    );
  }

  List<Widget> createRightGuessedCharacters(HashMap<String, int> rightGuesses) {
    List<Widget> letters = [];
    for (int i = 0; i < widget.game.word.length; i++) {
      var char = widget.game.word[i];
      var guessed = rightGuesses[char];
      if (guessed == 1) {
        letters.add(createRightGuessedCharacter(char));
      } else {
        letters.add(createEmptyGuessedCharacter());
      }
    }
    return letters;
  }

  List<Widget> createGuessedCharactersList(HashMap<String, int> rightGuesses) {
    List<Widget> letters = [];
    for (int i = 0; i < _guesses.length; i++) {
      var guessed = rightGuesses.entries.toList()[i].key;
      letters.add(createGuessedCharacter(guessed));
    }
    return letters;
  }

  Widget createGuessedCharacterInput(String? _inputErrorText) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          controller: myController,
          textInputAction: TextInputAction.send,
          onFieldSubmitted: guessInput,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                guessInput(myController.text);
              },
              icon: const Icon(Icons.send),
            ),
            //border: const OutlineInputBorder(),
            hintText: AppLocalizations.of(context)!.makeaNewGuess,
            labelText: AppLocalizations.of(context)!.makeaNewGuess,
            errorText: _inputErrorText,
          ),
        ),
      ),
    );
  }

  void guessInput(String guess) {
    _inputErrorText = null;
    if (myController.text == "" || myController.text == " ") {
      myController.text = "";
      return;
    }

    lastGuess = myController.text;

    var gameState = widget.game.perfomGuess(myController.text);

    setState(() {
      rightGuesses = widget.game.correctlyGuessedLetters;
      _attemptsLeft = widget.game.attempts;
    });

    if (gameState == HangmanGameStatus.victory) {
      createWinningDialog();
    } else if (gameState == HangmanGameStatus.defeat) {
      createDefeatDialog();
    } else if (gameState == HangmanGameStatus.illegalInput) {
      setState(() {
        _inputErrorText = AppLocalizations.of(context)!.illegalInput;
      });
    } else if (gameState == HangmanGameStatus.alreadyGuessedLetter) {
      setState(() {
        _inputErrorText = AppLocalizations.of(context)!.alreadyGuessed;
      });
    } else if (gameState == HangmanGameStatus.onging) {
      myController.text = "";
    }
  }

  void createDefeatDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.defeat),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    goToGameConfiguration();
                  },
                  child: Text(AppLocalizations.of(context)!.configure)),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.createNewGame();
                  },
                  child: Text(AppLocalizations.of(context)!.newGameTitle)),
            ],
            content:
                Text(AppLocalizations.of(context)!.youLost + widget.game.word),
          );
        });
  }

  void createWinningDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.victory),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    goToGameConfiguration();
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context)!.configure)),
              ElevatedButton(
                  onPressed: () {
                    widget.createNewGame();
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context)!.newGameTitle)),
            ],
            content: Text(AppLocalizations.of(context)!.youGuessedRight),
          );
        });
  }

  void goToGameConfiguration() {
    widget.controller.animateToPage(1,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
    widget.createNewGame();
  }

  Widget createRightGuessedCharacter(String char) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      elevation: 2,
      child: Text(
        "  " + char.toUpperCase() + "  ",
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  Widget createGuessedCharacter(String char) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
      elevation: 2,
      child: Text(
        " " + char.toUpperCase() + " ",
        style: const TextStyle(fontSize: 10),
      ),
    );
  }

  Widget createAttemptsRow(int attemptsLeft, HashMap<String, int> guesses) {
    return Center(
      child: Row(
        children: [
          createAttemptsLeft(_attemptsLeft),
          Row(
            children: createGuessedCharactersList(guesses),
          )
        ],
      ),
    );
  }

  Widget createEmptyGuessedCharacter() {
    return const Card(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      elevation: 2,
      child: Text(
        "     ",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget createAttemptsLeft(int attemptsLeft) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Text(
          AppLocalizations.of(context)!.attemptsLeft + attemptsLeft.toString()),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _attemptsLeft = 0;
    lastGuess = "";
    rightGuesses = HashMap();
    _inputErrorText = null;
    myController.dispose();
    super.dispose();
  }

  renderHangMan(int guessesLeft, int totalguesses) {
    const String hangBase = 'assets/hang_base.svg';
    const String head = 'assets/head.svg';
    const String body = 'assets/body.svg';
    const String rightArm = 'assets/right_arm.svg';
    const String leftArm = 'assets/left_arm.svg';
    const String leftFoot = 'assets/left_foot.svg';
    const String rightFoot = 'assets/right_foot.svg';
    const String mouth = 'assets/mouth.svg';
    const String leftEye = 'assets/left_eye.svg';
    const String rightEye = 'assets/right_eye.svg';
    const String deadEyes = 'assets/dead_eyes.svg';
    List<Widget> hangManList = [
      SvgPicture.asset(hangBase, semanticsLabel: 'HangBase'),
    ];
    List<Widget> possibleStates = [
      SvgPicture.asset(head, semanticsLabel: 'HangBase'),
      SvgPicture.asset(body, semanticsLabel: 'HangBase'),
      SvgPicture.asset(rightFoot, semanticsLabel: 'HangBase'),
      SvgPicture.asset(leftFoot, semanticsLabel: 'HangBase'),
      SvgPicture.asset(rightArm, semanticsLabel: 'HangBase'),
      SvgPicture.asset(leftArm, semanticsLabel: 'HangBase'),
      SvgPicture.asset(mouth, semanticsLabel: 'HangBase'),
      SvgPicture.asset(rightEye, semanticsLabel: 'HangBase'),
      SvgPicture.asset(leftEye, semanticsLabel: 'HangBase'),
      SvgPicture.asset(deadEyes, semanticsLabel: 'HangBase'),
    ];
    int index;
    try {
      index = 10 - (guessesLeft / totalguesses * 10).toInt();
    } catch (e) {
      index = 10 - guessesLeft;
    }

    if (guessesLeft == 0) {
      hangManList.addAll(possibleStates);
    } else if (index != 0) {
      hangManList.addAll(possibleStates.getRange(0, index - 1));
    }

    return Stack(
      children: hangManList,
    );
  }
}
