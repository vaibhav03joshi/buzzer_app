import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../Data/Functions.dart';
import '../Data/UserData.dart';
import '../widget/UserCardOnResult.dart';

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
  DateTime initialDateTime = DateTime.now();
  List<Results> resultsList = [];
  var sub1, sub2;

  void getResultData() async {
    List<Results> tempResultList = [];
    tempResultList = await returnResultUsers(widget.roomCode);
    setState(() {
      resultsList = tempResultList;
    });
  }

  @override
  void initState() {
    super.initState();
    databaseReference
        .child("/Room/${widget.roomCode}/startGame")
        .onChildRemoved
        .listen((event) {
      setState(() {
        isBuzzerActive = true;
        initialDateTime = DateTime.now();
      });
    });
    sub1 = databaseReference
        .child("/Room/${widget.roomCode}/startGame/Results")
        .onChildAdded
        .listen((event) {
      getResultData();
    });
    sub2 = databaseReference
        .child("/Room/${widget.roomCode}/startGame/Results")
        .onChildRemoved
        .listen((event) {
      getResultData();
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
      body: Stack(
        children: [
          Container(
            height: 50.0,
            width: double.infinity,
            color: const Color(0xff50586C),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: ListView.builder(
              itemCount: resultsList.length,
              itemBuilder: (ctx, index) => UserCardOnResult(
                userName: resultsList[index].name,
                datetime: resultsList[index].dateTime,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 200,
              width: 200,
              margin: const EdgeInsets.all(50),
              child: MaterialButton(
                shape: const CircleBorder(),
                color: const Color(0xff50586C),
                onPressed: isBuzzerActive
                    ? () {
                        player.play(
                          AssetSource("buzzer.mp3"),
                        );
                        setState(() {
                          isBuzzerActive = false;
                        });
                        Duration timeDifference =
                            DateTime.now().difference(initialDateTime);
                        passBuzzerData(widget.roomCode, widget.username,
                            "${timeDifference.inSeconds}.${timeDifference.inMilliseconds % 1000}");
                      }
                    : () {},
                child: const Text(
                  "BUZZER",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffD7D7D7),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
