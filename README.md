# hangman

Dette er HangMan skrevet i flutter av Sigmund Granaas. Det støtter ord mellom 2 og seks bokstaver. Den er oversatt til både Engelsk og Norsk. Appen er utviklet på en virtuell Pixel 2 med API 30.

## Hvordan kjøre appen

Hvis du bruker Visual studio Code kan du kjøre appen i en Android emulator så lenge du har Dart og Flutter plugin installert. Da kan du kjøre og konfigurere en android emulator ved å trykke på teksten nede i høyre hjørne der det står "Chrome(web-javascript)" og så velge en eksisterende android emulator eller å konfigurere en ny en. Deretter trenger du bare skrive `flutter run` for å starte appen.

Hvis du bruker IntelliJ bør du også installere plugins for både Flutter og Dart. Da skal IntelliJ kunne gjenkjenne at dette er et flutterprosjekt, og vil la det starte main.dart, med en en android emulator som du selv velger. Hvis du da velger på `Run 'main.dart'` skal appen starte.

## Notes

Appen fungerer bare på Android og Ios. Flutter har fortsatt bugs når det kommer til internationalisering, har måtte splitte kombonentene i appen litt unaturlig for å jobbe rundt denne buggen -> https://github.com/flutter/flutter/issues/26365 Issuen er closed, men det er ikke funnet noen offisiell fiks enda. Dropdownen du bruker for å bytte språk er ikke oversatt, dette har skapt mye problemer i appen å implementere.
