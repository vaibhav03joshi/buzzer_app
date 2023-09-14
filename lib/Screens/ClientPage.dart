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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: MaterialButton(
              color: Colors.black,
              onPressed: () {
                setState(() {
                  isBuzzerActive = false;
                });
                passBuzzerData(widget.roomCode, widget.username,
                    DateTime.now().toString());
              },
            ),
          ),
        ),
      ),
    );
  }
}
