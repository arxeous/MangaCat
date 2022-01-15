import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manga_cat/screens/HomeScreen.dart';

// Main entry point for the app. Obviously
// We want to start with our home screen so we start the app loading up at HomeScreen.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MangaCat',
      theme: ThemeData.light().copyWith(
        textTheme: GoogleFonts.reemKufiTextTheme(
          Theme.of(context).textTheme,
        )
      ),
      home: HomeScreen(),
    );
  }
}

