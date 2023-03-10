import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_neumorphism/models/letter.dart';
import 'package:wordle_neumorphism/providers/game_provider.dart';
import 'package:wordle_neumorphism/screens/GameScreen/components/letter_box.dart';
import 'package:wordle_neumorphism/constraints.dart';

class Board extends StatelessWidget {
  const Board({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider = Provider.of<GameProvider>(context);
    List<List<Letter>> board = gameProvider.board;

    return Column(
      children: [
        ...List.generate(numberOfRounds, (rowIndex) {
          bool visible =
              rowIndex <= gameProvider.currentRowIndex ? true : false;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...List.generate(
                  board[rowIndex].length,
                  (letterIndex) => AnimatedOpacity(
                      opacity: visible ? 1.0 : 0.0,
                      duration: defaultDuration,
                      child: LetterBox(letter: board[rowIndex][letterIndex])))
            ],
          );
        })
      ],
    );
  }
}
