import 'package:buzzer_app/widget/UserCardOnResult.dart';
import 'package:flutter/material.dart';

class HostScreen extends StatelessWidget {
  const HostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room Code'),
      ),
      body: Stack(
        children: [
          Align(
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
                onPressed: () {},
                icon: const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Column(
            children: [
              UserCardOnResult(
                userName: 'Anshu',
                datetime: DateTime.now(),
              ),
              UserCardOnResult(
                userName: 'Keshu',
                datetime: DateTime.now(),
              ),
              UserCardOnResult(
                userName: 'Shanu',
                datetime: DateTime.now(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
