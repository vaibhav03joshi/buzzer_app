import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../Data/Functions.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({
    required this.username,
    required this.roomCode,
    super.key,
  });

  final String username;
  final String roomCode;

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  final player = AudioPlayer();
  bool isBuzzerActive = true;

  @override
  void initState() {
    super.initState();
    databaseReference
        .child("/Room/${widget.roomCode}/startGame")
        .onChildRemoved
        .listen((event) {
      setState(() {
        isBuzzerActive = true;
      });
    });
  }

  @override
  void dispose() async {
    await player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: MaterialButton(
              color: Colors.red,
              onPressed: isBuzzerActive
                  ? () {
                      player.play(
                        AssetSource("buzzer.mp3"),
                      );
                      setState(() {
                        isBuzzerActive = false;
                      });
                      passBuzzerData(widget.roomCode, widget.username,
                          DateTime.now().toString());
                    }
                  : () {},
              child: const Text(
                "BUZZER",
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xffD7D7D7),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
