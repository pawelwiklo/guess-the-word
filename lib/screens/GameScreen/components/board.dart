import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_neumorphism/models/letter.dart';
import 'package:wordle_neumorphism/providers/game_provider.dart';
import 'package:wordle_neumorphism/screens/GameScreen/components/letter_box.dart';

class Board extends StatelessWidget {
  const Board({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider = Provider.of<GameProvider>(context);
    List<List<Letter>> board = gameProvider.board;

    return Column(
      children: [
        ...List.generate(
            gameProvider.currentRowIndex + 1,
            (rowIndex) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                        board[rowIndex].length,
                        (letterIndex) => LetterBox(
                              letter: board[rowIndex][letterIndex],
                            ))
                  ],
                ))
      ],
    );
  }
}
