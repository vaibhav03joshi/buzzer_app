import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';

final databaseReference = FirebaseDatabase.instance.ref();

void createRoom(String roomCode) {
  databaseReference.child("Room").update(
    {
      "$roomCode": {
        "canJoin": true,
      },
    },
  );
}

Future<bool> canJoinRoom(String roomCode) async {
  final snapshot = await databaseReference.child('/Room/$roomCode').get();
  if (snapshot.exists) {
    return true;
  } else {
    return false;
  }
}

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
