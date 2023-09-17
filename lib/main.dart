import 'package:buzzer_app/Screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffDCE2F0),
        appBarTheme: const AppBarTheme(
          color: Color(0xff50586C),
        ),
      ),
      home: const HomeScreen(),
    ),
  );
}
