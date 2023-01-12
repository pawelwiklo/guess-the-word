import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_neumorphism/constraints.dart';
import 'package:wordle_neumorphism/providers/game_provider.dart';

class RoundCounter extends StatelessWidget {
  const RoundCounter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider = Provider.of<GameProvider>(context);
    int currentRound = gameProvider.currentRowIndex;
    int maxRounds = numberOfRounds;
    return Container(
      padding: const EdgeInsets.only(bottom: defaultPadding),
      child: Text(
        'Round ${currentRound + 1} of $maxRounds',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 25),
      ),
    );
  }
}
