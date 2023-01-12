import 'package:flutter/material.dart';
import 'package:wordle_neumorphism/constraints.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: defaultPadding, horizontal: defaultPadding),
      child: const FittedBox(
          child: Text(
        'Guess the word',
        style: TextStyle(
          fontSize: 400,
          fontWeight: FontWeight.w500,
        ),
      )),
    );
  }
}
