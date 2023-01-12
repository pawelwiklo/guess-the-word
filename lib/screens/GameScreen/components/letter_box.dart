import 'dart:async';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:wordle_neumorphism/constraints.dart';
import 'package:wordle_neumorphism/models/letter.dart';

class LetterBox extends StatefulWidget {
  LetterBox({Key? key, required this.letter}) : super(key: key);

  final Letter letter;

  @override
  State<LetterBox> createState() => _LetterBoxState();
}

class _LetterBoxState extends State<LetterBox> {
  bool isPressed = true;
  double boxWidth = 50;
  double boxHeight = 50;
  double offsetX = -2;
  double offsetY = -2;
  double maxOffset = 5;

  @override
  void initState() {
    // startShadowMovementAnimation();
    super.initState();
  }

  void startShadowMovementAnimation() {
    if (!widget.letter.isAnimationRunning) {
      Timer.periodic(const Duration(milliseconds: 50), (Timer t) {
        setState(() {
          widget.letter.isAnimationRunning = true;
          if (offsetX < maxOffset && offsetY <= -maxOffset) {
            //go right
            offsetX += 1;
          } else if (offsetX > 0 && offsetY < maxOffset) {
            //go down
            offsetY += 1;
          } else if (offsetX > -maxOffset && offsetY > 0) {
            //go left
            offsetX -= 1;
          } else if (offsetX < 0 && offsetY > -maxOffset) {
            //go up
            offsetY -= 1;
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    isPressed = widget.letter.state == LetterState.idle;
    if (!isPressed) {
      startShadowMovementAnimation();
    }
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    Offset distance = Offset(offsetX, offsetY);
    double blur = isPressed ? 1.0 : 5.0;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          if (!isPressed)
            BoxShadow(
                spreadRadius: -12,
                blurRadius: blur,
                offset: distance,
                color: widget.letter.getColor()[400],
                inset: false),
        ],
      ),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        margin: const EdgeInsets.all(defaultPadding / 2),
        height: boxHeight,
        width: boxWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
                blurRadius: blur,
                offset: const Offset(0, 0),
                color: widget.letter.getColor(),
                inset: isPressed),
            BoxShadow(
              blurRadius: blur,
              offset: const Offset(2, 2),
              color: isPressed ? Colors.black87 : Colors.black38,
              inset: true,
            ),
          ],
        ),
        child: SizedBox(
          child: Center(
            child: Text(
              widget.letter.value,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}
