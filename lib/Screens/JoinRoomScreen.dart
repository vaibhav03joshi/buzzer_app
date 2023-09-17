import 'package:buzzer_app/Screens/WaitingRoom.dart';
import 'package:flutter/material.dart';
import '../Data/Functions.dart';
import '../Data/UserData.dart';

class JoinRoomScreen extends StatelessWidget {
  JoinRoomScreen({super.key});

  String roomCode = '';
  String userName = '';

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
                cursorColor: Colors.white,
                onChanged: (value) {
                  userName = value;
                },
                keyboardType: TextInputType.name,
                textAlign: TextAlign.center,
                maxLength: 15,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  hintText: 'Username',
                  counterText: '',
                  hintStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.white60,
                  ),
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
                cursorColor: Colors.white,
                onChanged: (value) {
                  roomCode = value;
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 6,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  hintText: 'Room Code',
                  hintStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.white60,
                  ),
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
                JoinRoom joinroom = await joinRoom(roomCode, userName);
                if (joinroom.canJoin) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => WaitingScreen(
                        showStartButton: false,
                        roomCode: roomCode,
                        username: userName,
                        userIndex: joinroom.userIndex.toString(),
                      ),
                    ),
                  );
                } else {
                  String warningMessage = joinroom.userIndex == -1
                      ? "Room Does not exist"
                      : "Room is already started";
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
