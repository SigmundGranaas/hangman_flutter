import 'dart:math';

/// WHY IS THIS TYPED STATICALLY?
/// I did not bother creating a client for fetching words from dictionaries.
/// Typing it manually was just quicker and a lot simpler.
class Dictionary {
  String language;
  Dictionary(this.language);

  String getNewWord(int length) {
    if (language == "no") {
      switch (length) {
        case 2:
          return norwegian2[Random().nextInt(norwegian2.length)];
        case 3:
          return norwegian3[Random().nextInt(norwegian3.length)];
        case 4:
          return norwegian4[Random().nextInt(norwegian4.length)];
        case 5:
          return norwegian5[Random().nextInt(norwegian5.length)];
        case 6:
          return norwegian6[Random().nextInt(norwegian6.length)];
      }
    } else {
      switch (length) {
        case 2:
          return en2[Random().nextInt(en2.length)];
        case 3:
          return en3[Random().nextInt(en3.length)];
        case 4:
          return en3[Random().nextInt(en4.length)];
        case 5:
          return en5[Random().nextInt(en5.length)];
        case 6:
          return en6[Random().nextInt(en6.length)];
      }
    }
    return "Test";
  }

  List<String> norwegian2 = [
    "en",
    "to",
    "at",
    "do",
    "bo",
    "te",
    "ti",
    "hi",
    "el",
    "fe",
    "lo",
    "få",
    "ro"
  ];
  List<String> norwegian3 = [
    "gal",
    "het",
    "jus",
    "jul",
    "mat",
    "jeg",
    "fag",
    "oss",
    "rev",
    "tau",
    "ufo",
    "øde",
    "lam"
  ];
  List<String> norwegian4 = [
    "blod",
    "amme",
    "besk",
    "bytt",
    "duft",
    "ekte",
    "faen",
    "film",
    "gape",
    "høne",
    "jord",
    "lade",
    "purk"
  ];
  List<String> norwegian5 = [
    "alder",
    "etikk",
    "firma",
    "vaier",
    "sveis",
    "prest",
    "bifil",
    "trapp",
    "burka",
    "mafia",
    "parre",
    "satin",
    "tapas"
  ];
  List<String> norwegian6 = [
    "behov",
    "deltid",
    "kapsun",
    "absurd",
    "berget",
    "blenda",
    "blodig",
    "fagbok",
    "filter",
    "fliden",
    "koding",
    "melodi",
    "nemlig"
  ];

  List<String> en2 = [
    "of",
    "no",
    "et",
    "en",
    "al",
    "te",
    "um",
    "or",
    "re",
    "fe",
    "lo",
    "yo",
    "ut"
  ];
  List<String> en3 = [
    "act",
    "app",
    "cat",
    "god",
    "gun",
    "gin",
    "lay",
    "gym",
    "may",
    "nun",
    "pup",
    "red",
    "hat"
  ];
  List<String> en4 = [
    "able",
    "camp",
    "body",
    "beer",
    "cook",
    "code",
    "copy",
    "flow",
    "gape",
    "hero",
    "holy",
    "hurt",
    "life"
  ];
  List<String> en5 = [
    "actor",
    "apart",
    "birth",
    "audio",
    "curve",
    "dozen",
    "drive",
    "every",
    "image",
    "maybe",
    "loose",
    "prime",
    "prove"
  ];
  List<String> en6 = [
    "answer",
    "assess",
    "appeal",
    "absurd",
    "danger",
    "device",
    "format",
    "flying",
    "hidden",
    "filter",
    "league",
    "margin",
    "native"
  ];
}
