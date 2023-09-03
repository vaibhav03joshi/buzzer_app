import 'package:buzzer_app/Screens/HostScreen.dart';
import 'package:buzzer_app/widget/UserWaitingCard.dart';
import 'package:flutter/material.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({required this.showStartButton, super.key});

  final bool showStartButton;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room Code'),
      ),
      body: Stack(
        children: [
          showStartButton
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: Colors.black,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => HostScreen()),
                        );
                      },
                      icon: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : Container(),
          Column(
            children: [
              UserCard(userName: 'Anshu'),
              UserCard(userName: 'Keshu'),
              UserCard(userName: 'Shanu'),
            ],
          ),
        ],
      ),
    );
  }
}
