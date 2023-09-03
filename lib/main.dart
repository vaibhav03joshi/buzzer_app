import 'package:buzzer_app/Screens/HomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      appBarTheme: AppBarTheme(
        color: Colors.black,
      ),
    ),
    home: HomeScreen(),
  ));
}
