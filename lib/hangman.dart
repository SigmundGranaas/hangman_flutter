import 'dart:collection';

enum HangmanGameStatus {
  onging,
  victory,
  defeat,
  rightGuess,
  alreadyGuessedLetter,
  wrongGuess,
  illegalInput,
}

class HangMan {
  String word;
  int attempts;
  HangmanGameStatus status = HangmanGameStatus.onging;
  HashMap<String, int> guessedLetters = HashMap();
  late HashMap<String, int> correctlyGuessedLetters = HashMap();

  HangMan(this.word, this.attempts) {
    for (int i = 0; i < word.length; i++) {
      var char = word[i];
      correctlyGuessedLetters[char] = 0;
    }
  }

  HangmanGameStatus perfomGuess(String rawGuess) {
    String guess = rawGuess.toLowerCase();
    RegExp regexp =
        RegExp(r"[-_!$%^&*()+|~=`{}#@\[\]:;'’<>?,.\/?123456789" '"”' "]");
    if (regexp.hasMatch(guess)) {
      return HangmanGameStatus.illegalInput;
    }

    if (attempts == 0) {
      return HangmanGameStatus.defeat;
    } else if (isWinningGuess()) {
      return HangmanGameStatus.victory;
    } else if (guess.length == 1 && guessedLetters.containsKey(guess)) {
      return HangmanGameStatus.alreadyGuessedLetter;
    }

    for (int i = 0; i < guess.length; i++) {
      var char = guess[i];

      if (isRightGuess(char)) {
        guessedLetters[char] = 1;
        correctlyGuessedLetters[char] = 1;
        if (isWinningGuess()) {
          return HangmanGameStatus.victory;
        }
      } else {
        if (!guessedLetters.containsKey(char)) {
          attempts -= 1;
          guessedLetters[char] = 1;
        }

        if (attempts == 0) {
          return HangmanGameStatus.defeat;
        }
      }
    }
    return HangmanGameStatus.onging;
  }

  bool isWinningGuess() {
    bool isWin = true;
    for (int i = 0; i < word.length; i++) {
      var char = word[i];
      if (correctlyGuessedLetters[char] == 0) {
        isWin = false;
      }
    }
    return isWin;
  }

  bool isRightGuess(String guess) {
    if (word.contains(guess)) {
      return true;
    } else {
      return false;
    }
  }

  String getWord() {
    return word;
  }

  int getAttempts() {
    return attempts;
  }
}
