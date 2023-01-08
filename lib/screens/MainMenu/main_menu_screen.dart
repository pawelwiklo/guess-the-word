import 'package:flutter/material.dart';
import 'package:wordle_neumorphism/screens/MainMenu/components/neumorphism_button.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            NeumorphismButton(),
          ],
        ),
      ),
    );
  }
}
