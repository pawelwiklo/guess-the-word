import 'package:flutter/material.dart';
import 'package:wordle_neumorphism/constraints.dart';
import 'package:wordle_neumorphism/models/letter.dart';
import 'package:wordle_neumorphism/providers/game_provider.dart';
import 'package:wordle_neumorphism/screens/GameScreen/components/letter_box.dart';
import 'package:wordle_neumorphism/screens/MainMenu/components/neumorphism_button.dart';

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
          title: Text('Guess the word'),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                children: [
                  Text(gameState == GameState.Win
                      ? 'Congratulation, you won!'
                      : 'Game Over'),
                  if (gameState == GameState.Lost) Text('The word was $word'),
                ],
              ),
            ),
          ),
          actions: [
            // MaterialButton(
            //     child: Text("Restart"),
            //     onPressed: () {
            //       resetGameHandler();
            //       Navigator.pop(context);
            //     }),
            GestureDetector(
              onTap: () {
                resetGameHandler();
                Navigator.pop(context);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 400),
                margin: const EdgeInsets.all(defaultPadding / 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      offset: const Offset(0, 0),
                      color: Colors.cyan,
                    ),
                    BoxShadow(
                      blurRadius: 5,
                      offset: const Offset(2, 2),
                      color: Colors.black87,
                    ),
                  ],
                ),
                child: SizedBox(
                  child: Center(
                    child: Text(
                      "Restart",
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      });
}
