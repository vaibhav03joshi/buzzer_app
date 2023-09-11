import 'package:buzzer_app/Screens/WaitingRoom.dart';
import 'package:flutter/material.dart';

import '../Data/Functions.dart';

class JoinRoomScreen extends StatelessWidget {
  JoinRoomScreen({super.key});

  String roomCode = '';

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
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30.0),
              ),
              height: 50,
              width: 200,
              child: TextField(
                onChanged: (value) {
                  roomCode = value;
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 6,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  hintText: 'Enter Room Code',
                  counterText: '',
                ),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30.0),
              ),
              height: 50,
              width: 200,
              child: TextField(
                onChanged: (value) {
                  roomCode = value;
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 6,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  hintText: 'Enter Room Code',
                  counterText: '',
                ),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              height: 50.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              onPressed: () async {
                bool canJoinRoomCode = await canJoinRoom(roomCode);
                if (canJoinRoomCode) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => WaitingScreen(
                        showStartButton: false,
                        roomCode: roomCode,
                      ),
                    ),
                  );
                }
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_add_alt_1),
                  Text(
                    'Join',
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
