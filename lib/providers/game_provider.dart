import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wordle_neumorphism/models/letter.dart';
import 'package:wordle_neumorphism/models/words.dart';
import 'package:wordle_neumorphism/providers/keyboard_provider.dart';
import 'package:wordle_neumorphism/screens/GameScreen/components/game_over_dialog.dart';

const int numberOfRounds = 5;
const int wordLength = 5;

enum GameState {
  Running,
  Win,
  Lost,
}

class GameProvider extends ChangeNotifier {
  String word = words[Random().nextInt(words.length)].toUpperCase();

  List<List<Letter>> _board = initBoard();
  List<List<Letter>> get board => _board;

  int _currentRowIndex = 0;
  int get currentRowIndex => _currentRowIndex;
  GameState gameState = GameState.Running;

  void handleInput(
      {required String letter,
      required KeyboardProvider handler,
      required BuildContext ctx}) {
    if (letter == 'DEL') {
      removeLastLetter();
      notifyListeners();
      return;
    }
    if (letter == 'ENTER') {
      if (canAddLetter()) return;
      submitWord(handler: handler.setStateForLetter);
      checkWin();
      if (gameState == GameState.Running) {
        addNextRow(ctx);
      }
      if (gameState != GameState.Running) {
        handler.resetKeyboard();
        gameOverDialog(
            ctx: ctx,
            gameState: gameState,
            word: word,
            resetGameHandler: resetGame);
      }
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

  void addNextRow(BuildContext ctx) {
    bool canAddNextRow = _currentRowIndex != (numberOfRounds - 1);
    if (canAddNextRow) {
      _currentRowIndex++;
    } else {
      gameState = GameState.Lost;
    }
    notifyListeners();
  }

  bool isCorrect(int index, String letter) {
    return word[index] == letter;
  }

  bool isInWrongPosition(String letter) {
    return word.contains(letter);
  }

  void checkWin() {
    if (word == board[currentRowIndex].map((e) => e.value).toList().join()) {
      gameState = GameState.Win;
    }
  }

  void resetGame() {
    _board = initBoard();
    _currentRowIndex = 0;
    gameState = GameState.Running;
    word = words[Random().nextInt(words.length)].toUpperCase();
    notifyListeners();
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
