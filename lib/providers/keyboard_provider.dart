import 'package:flutter/material.dart';
import 'package:wordle_neumorphism/models/keyboard_key.dart';

class KeyboardProvider extends ChangeNotifier {
  List<List<KeyboardKey>> _keys = initKeyboard();
  List<List<KeyboardKey>> get keys => _keys;

  void setStateForLetter(String letter) {
    KeyboardKey kk =
        keys.expand((i) => i).toList().where((e) => e.letter == letter).first;
    kk.setKeyState(KeyState.notExistingInWord);
  }
}

List<List<KeyboardKey>> initKeyboard() {
  return List<List<KeyboardKey>>.generate(
    keyboardLetters.length,
    (rowIndex) => List.generate(
      keyboardLetters[rowIndex].length,
      (letterIndex) => KeyboardKey(
        letter: keyboardLetters[rowIndex][letterIndex],
      ),
    ),
  );
}
