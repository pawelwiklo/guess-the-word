import 'package:flutter/material.dart';
import 'package:wordle_neumorphism/constraints.dart';

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
  bool isAnimationRunning;

  Letter(
      {required this.value,
      this.state = LetterState.idle,
      this.color = Colors.grey,
      this.isAnimationRunning = false});

  getColor() {
    if (state == LetterState.correct) {
      return correctBoxColor;
    } else if (state == LetterState.inWord) {
      return wrongLetterPositionColor;
    } else if (state == LetterState.incorrect) {
      return incorrectBoxColor;
    }
    return defaultBoxBgColor;
  }
}
