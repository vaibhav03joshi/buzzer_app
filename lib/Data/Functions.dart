import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

import 'UserData.dart';

final databaseReference = FirebaseDatabase.instance.ref();

void waitingRoomFunction(String roomCode, bool canJoin, bool startGame) {
  databaseReference.child("Room/$roomCode").update(
    {
      "canJoin": canJoin,
      "startGame": {
        "canAnswer": startGame,
      },
    },
  );
}

Future<JoinRoom> joinRoom(String roomCode, String username) async {
  JoinRoom joinRoom = JoinRoom(-1, false);
  final snapshot = await databaseReference.child('/Room/$roomCode').get();
  if (snapshot.exists) {
    joinRoom.userIndex = 0;
    Map<String, dynamic> data =
        jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
    bool canJoin = data["canJoin"];
    if (canJoin) {
      int currentUsers = data["currentUsers"] ?? 0;
      int users = currentUsers + 1;
      joinRoom.canJoin = canJoin;
      joinRoom.userIndex = users;
      databaseReference.child('/Room/$roomCode').update(
        {
          "currentUsers": users,
        },
      );
      databaseReference.child("/Room/$roomCode/Users").update(
        {
          "$users": username,
        },
      );
    }
    return joinRoom;
  }
  return joinRoom;
}

Future<List<String>> returnWaitingUsers(String roomCode) async {
  List<String> waitingUsers = [];
  final snapshot = await databaseReference.child("/Room/$roomCode/Users").get();
  if (snapshot.exists) {
    List<dynamic> list = jsonDecode(jsonEncode(snapshot.value));
    list = list.where((element) => element != null).toList();
    waitingUsers = list.cast<String>();
  }
  return waitingUsers;
}

void removeUsersData(String path) async {
  databaseReference.child(path).remove();
}

void passBuzzerData(String roomData, String username, String dateTime) {
  databaseReference.child("/Room/$roomData/startGame/Results").update({
    username: dateTime,
  });
}

Future<List<Results>> returnResultUsers(String roomCode) async {
  List<Results> resultData = [];
  final snapshot =
      await databaseReference.child("/Room/$roomCode/startGame/Results").get();
  if (snapshot.exists) {
    Map<String, dynamic> data =
        jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
    data.forEach((key, value) {
      String dateTimeData = value;
      DateTime dateTime = DateTime.parse(dateTimeData);
      Results results = Results(key, dateTime);
      resultData.add(results);
    });
    resultData.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }
  return resultData;
}

void writeData() {
  databaseReference.child('485764').set(
    {
      "username": "Anshu",
      "Time": {
        "seconds": 2,
        "miniSeconds": 42,
      },
    },
  );
}

void readData() async {
  final snapshot = await databaseReference.child('/Room/456342').get();
  print(snapshot.exists);
  if (snapshot.exists) {
    Map<String, dynamic> data =
        jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
    print(data);
    print(data["username"]);
  } else {
    print('No data available.');
  }
}

void removeData(String path) {
  databaseReference.child(path).remove();
}
