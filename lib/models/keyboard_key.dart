import 'package:flutter/material.dart';

List<List<String>> keyboardLetters = [
  ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
  ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
  ['DEL', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'ENTER'],
];

enum KeyState {
  idle,
  notExistingInWord,
}

class KeyboardKey {
  String letter;
  KeyState state;
  // var color = Colors.transparent;
  var color = Color(0xFF303030);

  KeyboardKey({required this.letter, this.state = KeyState.idle});

  void setKeyState(KeyState keyState) {
    state = keyState;
    color = pickColor();
  }

  pickColor() {
    if (state == KeyState.idle) {
      return const Color(0xFF303030);
    } else if (state == KeyState.notExistingInWord) {
      return Colors.black45;
    }
  }
}
