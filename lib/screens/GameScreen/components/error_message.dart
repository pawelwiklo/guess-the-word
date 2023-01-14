import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_neumorphism/constraints.dart';
import 'package:wordle_neumorphism/providers/game_provider.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider = Provider.of<GameProvider>(context);
    bool visible = gameProvider.wordNotInDictionary;
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: defaultDuration,
      child: Container(
        margin: const EdgeInsets.all(defaultPadding / 2),
        padding: const EdgeInsets.all(defaultPadding * 2),
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
              "Word not in dictionary",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}
