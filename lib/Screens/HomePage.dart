import 'package:buzzer_app/Screens/JoinRoomScreen.dart';
import 'package:buzzer_app/Screens/WaitingRoom.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String GenerateRoomCode() {
    Random random = Random();
    int sixDigitNumber = random.nextInt(900000) + 100000;
    return sixDigitNumber.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('BUZZER')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff50586C),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  height: 200,
                  width: 200,
                ),
              ],
            ),
            Container(
              width: 150,
              child: Column(
                children: [
                  MaterialButton(
                    height: 50.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    onPressed: () {
                      String roomCodeGenerated = GenerateRoomCode();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => WaitingScreen(
                            showStartButton: true,
                            roomCode: roomCodeGenerated,
                          ),
                        ),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Color(0xff50586C),
                        ),
                        Text(
                          'Create',
                          style: TextStyle(color: Color(0xff50586C)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    height: 50.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => JoinRoomScreen(),
                        ),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_add_alt_1,
                          color: Color(0xff50586C),
                        ),
                        Text(
                          'Join',
                          style: TextStyle(color: Color(0xff50586C)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
