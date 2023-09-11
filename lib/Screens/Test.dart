import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Test extends StatelessWidget {
  Test({super.key});

  final databaseReference = FirebaseDatabase.instance.ref();

  void writeData() {
    databaseReference.child('485764').set(
      {
        "username": "Anshu",
        "Time": {
          "seconds": 2,
          "miliSeconds": 42,
        },
      },
    );
  }

  void readData() async {
    final snapshot = await databaseReference.child('/RoomCode').get();
    if (snapshot.exists) {
      Map<String, dynamic> data =
          jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
      print(data);
      print(data["username"]);
    } else {
      print('No data available.');
    }
  }

  final String username = 'RoomCode';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Room'),
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
              child: Center(
                child: Text(
                  username,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
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
              onPressed: () {
                writeData();
                readData();
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
