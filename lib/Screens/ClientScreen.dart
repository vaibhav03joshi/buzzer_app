import 'package:buzzer_app/Screens/WaitingRoom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JoinRoomScreen extends StatelessWidget {
  const JoinRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join Room'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              color: Colors.black,
              height: 50.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              onPressed: () {},
              child: const Text(
                'Join',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
