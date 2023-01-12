import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_neumorphism/providers/game_provider.dart';
import 'package:wordle_neumorphism/providers/keyboard_provider.dart';
import 'package:wordle_neumorphism/screens/GameScreen/components/board.dart';
import 'package:wordle_neumorphism/screens/GameScreen/components/header_text.dart';
import 'package:wordle_neumorphism/screens/GameScreen/components/keyboard.dart';
import 'package:wordle_neumorphism/screens/GameScreen/components/round_counter.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GameProvider()),
        ChangeNotifierProvider(create: (context) => KeyboardProvider()),
      ],
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              children: [
                HeaderText(),
                RoundCounter(),
                Board(),
                Spacer(),
                Keyboard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
