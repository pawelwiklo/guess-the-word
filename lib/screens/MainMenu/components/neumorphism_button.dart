import 'dart:async';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
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

  Color color = Colors.amber;
  late Timer _periodicTimer;

  @override
  void initState() {
    super.initState();
    Timer _periodicTimer =
        Timer.periodic(Duration(milliseconds: 10), (Timer t) {
      setState(() {
        // offsetFirstValue += 1;

        if (offsetX < maxOffset && offsetY <= -maxOffset) {
          //go right
          offsetX += 1;
          color = Colors.amber;
        } else if (offsetX > 0 && offsetY < maxOffset) {
          //go down
          offsetY += 1;
          color = Colors.green;
        } else if (offsetX > -maxOffset && offsetY > 0) {
          //go left
          offsetX -= 1;
          color = Colors.cyan;
        } else if (offsetX < 0 && offsetY > -maxOffset) {
          //go up
          offsetY -= 1;
          color = Colors.orange;
        }
      });
    });
  }

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
              Duration(milliseconds: 400),
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen()),
                );
              },
            );
          }
        });
      },
      child: AnimatedContainer(
        height: boxHeight,
        width: boxWidth,
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
                blurRadius: blur,
                offset: distance,
                color: isDarkMode ? Color(0xFF35393F) : Colors.white,
                inset: isPressed),
            BoxShadow(
              blurRadius: blur,
              offset: distance,
              // color: isDarkMode ? Color(0xFF23262A) : Color(0xFFA7A9AF),
              color: isDarkMode ? color : Color(0xFFA7A9AF),
              inset: isPressed,
            )
          ],
        ),
        child: SizedBox(
          child: Center(
            child: Text(
              isPressed ? '' : 'New Game',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}