import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
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

    double screenWidth = MediaQuery.of(context).size.width;
    EdgeInsets padding =
        EdgeInsets.all(defaultPadding / getDividerValue(screenWidth));

    return List.generate(
      widget.keys.length,
      (index) {
        KeyboardKey key = widget.keys[index];
        return GestureDetector(
          onTap: () {
            gameProvider.handleInput(
                letter: key.letter, handler: keyboardProvider, ctx: context);
          },
          child: AnimatedContainer(
            duration: defaultDuration,
            padding: padding,
            margin: const EdgeInsets.all(defaultPadding / 4),
            decoration: BoxDecoration(
              color: key.color,
              // border: Border.all(),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 1,
                    offset: Offset(-1, -1),
                    color: Colors.white60,
                    inset: true),
                BoxShadow(
                  blurRadius: 1,
                  offset: Offset(1, 1),
                  color: Colors.black54,
                  inset: true,
                ),
              ],
            ),
            child: key.state == KeyState.idle
                ? Text(
                    key.letter,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  )
                : Text(
                    key.letter,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white60),
                  ),
          ),
        );
      },
    );
  }

  double getDividerValue(double screenWidth) {
    double divider = 1;
    if (screenWidth <= 500 && screenWidth > 320) {
      divider = 2;
    } else if (screenWidth <= 320) {
      divider = 4;
    }
    return divider;
  }
}
