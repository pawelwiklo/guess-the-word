import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordle_neumorphism/providers/keyboard_provider.dart';
import 'package:wordle_neumorphism/screens/GameScreen/game_screen.dart';
import 'screens/MainMenu/main_menu_screen.dart';

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
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
      ),
      // home: MainMenuScreen(),
      home: GameScreen(),
    );
  }
}
