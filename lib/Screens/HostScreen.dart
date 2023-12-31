import 'package:buzzer_app/Data/Functions.dart';
import 'package:buzzer_app/widget/UserCardOnResult.dart';
import '../Data/UserData.dart';
import 'package:flutter/material.dart';

class HostScreen extends StatefulWidget {
  const HostScreen({required this.roomCode, super.key});
  final String roomCode;

  @override
  State<HostScreen> createState() => _HostScreenState();
}

class _HostScreenState extends State<HostScreen> with WidgetsBindingObserver {
  List<Results> resultsList = [];

  var sub1;
  var sub2;

  void getResultData() async {
    List<Results> tempResultList = [];
    tempResultList = await returnResultUsers(widget.roomCode);
    setState(() {
      resultsList = tempResultList;
    });
  }

  void deleteDataFromRoom() {
    removeUsersData("/Room/${widget.roomCode}");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      deleteDataFromRoom();
    }
    if (state == AppLifecycleState.resumed) {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
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
  void dispose() {
    deleteDataFromRoom();
    sub1?.cancel;
    sub2?.cancel;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomCode),
      ),
      body: Stack(
        children: [
          resultsList.isEmpty
              ? const Center(
                  child: Text(
                    "Looks like no one here",
                    style: TextStyle(color: Color(0xff50586C)),
                  ),
                )
              : ListView.builder(
                  itemCount: resultsList.length,
                  itemBuilder: (ctx, index) => UserCardOnResult(
                        userName: resultsList[index].name,
                        datetime: resultsList[index].dateTime,
                      )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              width: 70.0,
              height: 70.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: const Color(0xff50586C),
              ),
              child: IconButton(
                onPressed: () {
                  removeData("/Room/${widget.roomCode}/startGame/Results");
                },
                icon: const Icon(
                  Icons.restart_alt_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
