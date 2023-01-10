import 'package:flutter/material.dart';

enum LetterState {
  idle,
  correct,
  inWord,
  incorrect,
}

class Letter {
  String value;
  LetterState state;
  MaterialColor color;

  Letter(
      {required this.value,
      this.state = LetterState.idle,
      this.color = Colors.grey});

  getColor() {
    if (state == LetterState.correct) {
      return Colors.green;
    } else if (state == LetterState.inWord) {
      return Colors.yellow;
    } else if (state == LetterState.incorrect) {
      return Colors.red;
    }
    return Colors.grey;
  }
}