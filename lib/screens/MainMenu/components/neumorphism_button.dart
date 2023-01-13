import 'dart:async';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:wordle_neumorphism/constraints.dart';
import 'package:wordle_neumorphism/screens/GameScreen/game_screen.dart';

class NeumorphismButton extends StatefulWidget {
  const NeumorphismButton({Key? key}) : super(key: key);

  @override
  State<NeumorphismButton> createState() => _NeumorphismButtonState();
}

class _NeumorphismButtonState extends State<NeumorphismButton> {
  bool isPressed = false;
  bool isDarkMode = true;

  double boxWidth = 200;
  double boxHeight = 200;

  double offsetX = -20;
  double offsetY = -20;
  double maxOffset = 20;

  Color shadowColor = Colors.amber;

  @override
  void initState() {
    super.initState();
    startShadowMovementAnimation();
  }

  void startShadowMovementAnimation() {
    Timer.periodic(const Duration(milliseconds: 10), (Timer t) {
      setState(() {
        if (offsetX < maxOffset && offsetY <= -maxOffset) {
          //go right
          offsetX += 1;
          shadowColor = Colors.amber;
        } else if (offsetX > 0 && offsetY < maxOffset) {
          //go down
          offsetY += 1;
          shadowColor = Colors.green;
        } else if (offsetX > -maxOffset && offsetY > 0) {
          //go left
          offsetX -= 1;
          shadowColor = Colors.cyan;
        } else if (offsetX < 0 && offsetY > -maxOffset) {
          //go up
          offsetY -= 1;
          shadowColor = Colors.orange;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isDarkMode
        ? Theme.of(context).scaffoldBackgroundColor
        : const Color(0xFFE7ECEF);

    Offset distance = Offset(offsetX, offsetY);
    double blur = isPressed ? 5.0 : 30;

    return GestureDetector(
      onTap: () {
        setState(() {
          isPressed = !isPressed;
          if (isPressed) {
            setState(() {
              boxWidth = MediaQuery.of(context).size.width;
              boxHeight = MediaQuery.of(context).size.height;
            });
            Future.delayed(
              const Duration(milliseconds: 400),
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GameScreen()),
                );
              },
            );
          }
        });
      },
      child: AnimatedContainer(
        height: boxHeight,
        width: boxWidth,
        duration: defaultDuration,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
                blurRadius: blur,
                offset: distance,
                color: Colors.blueGrey,
                inset: isPressed),
            BoxShadow(
              blurRadius: blur,
              offset: distance,
              color: shadowColor,
              inset: isPressed,
            )
          ],
        ),
        child: SizedBox(
          child: Center(
            child: Text(
              isPressed ? '' : 'New Game',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}
