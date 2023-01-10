import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_neumorphism/constraints.dart';
import 'package:wordle_neumorphism/models/keyboard_key.dart';
import 'package:wordle_neumorphism/providers/game_provider.dart';
import 'package:wordle_neumorphism/providers/keyboard_provider.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    KeyboardProvider keyboardProvider = Provider.of<KeyboardProvider>(context);
    List<List<KeyboardKey>> keys = keyboardProvider.keys;

    return Column(
      children: [
        KeyboardRow(keys: keys[0]),
        KeyboardRow(keys: keys[1]),
        KeyboardRow(keys: keys[2]),
      ],
    );
  }
}

class KeyboardRow extends StatefulWidget {
  const KeyboardRow({
    Key? key,
    required this.keys,
  }) : super(key: key);

  final List<KeyboardKey> keys;

  @override
  State<KeyboardRow> createState() => _KeyboardRowState();
}

class _KeyboardRowState extends State<KeyboardRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...buildKeyboardRow(context),
      ],
    );
  }

  List<GestureDetector> buildKeyboardRow(BuildContext context) {
    GameProvider gameProvider = Provider.of<GameProvider>(context);
    KeyboardProvider keyboardProvider = Provider.of<KeyboardProvider>(context);
    return List.generate(
      widget.keys.length,
      (index) {
        KeyboardKey key = widget.keys[index];
        return GestureDetector(
          onTap: () {
            gameProvider.handleInput(
                letter: key.letter,
                handler: keyboardProvider.setStateForLetter);
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            padding: const EdgeInsets.all(defaultPadding / 2),
            margin: const EdgeInsets.all(defaultPadding / 8),
            decoration: BoxDecoration(
              color: key.color,
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              key.letter,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        );
      },
    );
  }
}
