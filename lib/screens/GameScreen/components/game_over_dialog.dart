import 'package:flutter/material.dart';
import 'package:wordle_neumorphism/constraints.dart';
import 'package:wordle_neumorphism/providers/game_provider.dart';

Future gameOverDialog(
    {required BuildContext ctx,
    required GameState gameState,
    required String word,
    required Function resetGameHandler}) {
  return showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
          ),
          scrollable: true,
          title: const Text('Guess the word'),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                children: [
                  Text(gameState == GameState.win
                      ? 'Congratulation, you won!'
                      : 'Game Over'),
                  if (gameState == GameState.lost) Text('The word was $word'),
                ],
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                resetGameHandler();
                Navigator.pop(context);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                margin: const EdgeInsets.all(defaultPadding / 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 5,
                      offset: Offset(0, 0),
                      color: Colors.cyan,
                    ),
                    BoxShadow(
                      blurRadius: 5,
                      offset: Offset(2, 2),
                      color: Colors.black87,
                    ),
                  ],
                ),
                child: const SizedBox(
                  child: Center(
                    child: Text(
                      "Restart",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      });
}
