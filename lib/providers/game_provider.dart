import 'package:flutter/material.dart';
import 'package:wordle_neumorphism/models/letter.dart';

const int numberOfRounds = 5;
const int wordLength = 5;

class GameProvider extends ChangeNotifier {
  String TEST_WORD = 'APPLE';

  List<List<Letter>> _board = initBoard();
  List<List<Letter>> get board => _board;

  int _currentRowIndex = 0;
  int get currentRowIndex => _currentRowIndex;

  void handleInput({required String letter, required Function handler}) {
    if (letter == 'DEL') {
      removeLastLetter();
      notifyListeners();
      return;
    }
    if (letter == 'ENTER') {
      if (canAddLetter()) return;
      submitWord(handler: handler);
      addNextRow();
      return;
    }
    if (canAddLetter()) {
      addLetter(letter);
      notifyListeners();
    }
    notifyListeners();
  }

  bool canAddLetter() {
    return board[_currentRowIndex].last.value == '';
  }

  void addLetter(String letter) {
    for (var i = 0; i < board[_currentRowIndex].length; i++) {
      if (board[_currentRowIndex][i].value == '') {
        board[_currentRowIndex][i].value = letter;
        break;
      }
    }
  }

  void removeLastLetter() {
    for (var i = (wordLength - 1); i >= 0; i--) {
      bool boxHasLetter = board[_currentRowIndex][i].value != '';
      if (boxHasLetter) {
        board[_currentRowIndex][i].value = '';
        break;
      }
    }
  }

  void submitWord({required Function handler}) {
    for (var i = 0; i < board[_currentRowIndex].length; i++) {
      Letter letter = board[_currentRowIndex][i];
      if (isCorrect(i, letter.value)) {
        letter.state = LetterState.correct;
      } else if (isInWrongPosition(letter.value)) {
        letter.state = LetterState.inWord;
      } else {
        letter.state = LetterState.incorrect;
        handler(letter.value);
      }
    }
  }

  void addNextRow() {
    bool canAddNextRow = _currentRowIndex != (numberOfRounds - 1);
    if (canAddNextRow) {
      _currentRowIndex++;
    }
    notifyListeners();
  }

  bool isCorrect(int index, String letter) {
    return TEST_WORD[index] == letter;
  }

  bool isInWrongPosition(String letter) {
    return TEST_WORD.contains(letter);
  }
}

List<List<Letter>> initBoard() {
  return List<List<Letter>>.generate(
    numberOfRounds,
    (rowIndex) => List.generate(
      wordLength,
      (letterIndex) => Letter(value: ''),
    ),
  );
}
