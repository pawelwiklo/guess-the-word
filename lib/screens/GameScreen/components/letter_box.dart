import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:wordle_neumorphism/constraints.dart';
import 'package:wordle_neumorphism/models/letter.dart';

class LetterBox extends StatelessWidget {
  LetterBox({Key? key, required this.letter}) : super(key: key);

  final Letter letter;

  bool isPressed = true;

  double boxWidth = 50;
  double boxHeight = 50;

  double offsetX = -2;
  double offsetY = -2;
  double maxOffset = 5;

  @override
  Widget build(BuildContext context) {
    isPressed = letter.state == LetterState.idle;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    Offset distance = Offset(offsetX, offsetY);
    double blur = isPressed ? 1.0 : 5;

    return AnimatedContainer(
      margin: const EdgeInsets.all(defaultPadding / 2),
      height: boxHeight,
      width: boxWidth,
      duration: const Duration(milliseconds: 1000),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
              blurRadius: blur,
              offset: const Offset(0, 0),
              color: letter.getColor(),
              inset: isPressed),
          BoxShadow(
            blurRadius: blur,
            offset: -distance,
            color: isPressed ? Colors.black87 : Colors.black38,
            inset: true,
          )
        ],
      ),
      child: SizedBox(
        child: Center(
          child: Text(
            letter.value,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
