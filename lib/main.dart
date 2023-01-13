import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordle_neumorphism/screens/GameScreen/game_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wordle Neumorphism',
      theme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
      ),
      // home: MainMenuScreen(),
      home: const GameScreen(),
    );
  }
}
