import 'package:buzzer_app/Screens/ClientPage.dart';
import 'package:buzzer_app/Screens/HostScreen.dart';
import 'package:buzzer_app/widget/UserWaitingCard.dart';
import 'package:flutter/material.dart';
import '../Data/Functions.dart';

class WaitingScreen extends StatefulWidget {
  WaitingScreen(
      {required this.showStartButton,
      required this.roomCode,
      this.username,
      this.userIndex,
      super.key});

  final bool showStartButton;
  final String roomCode;
  final String? username;
  final String? userIndex;

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen>
    with WidgetsBindingObserver {
  bool canDelete = true;
  List<String> waitingUsers = [];

  void WaitingUserListCall() async {
    List<String> list = await returnWaitingUsers(widget.roomCode);
    setState(() {
      waitingUsers = list;
    });
  }

  void deleteDataFromRoom() {
    if (canDelete) {
      if (widget.userIndex != null) {
        removeUsersData("/Room/${widget.roomCode}/Users/${widget.userIndex}");
      } else {
        removeUsersData("/Room/${widget.roomCode}");
      }
    }
  }

  void pushClientScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (ctx) => ClientPage(
                username: widget.username ?? "",
                roomCode: widget.roomCode,
              )),
    );
  }

  var sub1, sub2, sub3;

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
    WidgetsBinding.instance.addObserver(this);
    waitingRoomFunction(widget.roomCode, true, false);
    super.initState();
    sub1 = databaseReference
        .child("/Room/${widget.roomCode}/Users")
        .onChildAdded
        .listen((event) {
      WaitingUserListCall();
    });
    sub2 = databaseReference
        .child("/Room/${widget.roomCode}/Users")
        .onChildRemoved
        .listen((event) {
      WaitingUserListCall();
    });
    if (widget.username != null) {
      sub3 = databaseReference
          .child("/Room/${widget.roomCode}/startGame")
          .onChildChanged
          .listen((event) {
        pushClientScreen();
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    deleteDataFromRoom();
    sub1?.cancle;
    sub2?.cancle;
    sub3?.cancel;
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
          waitingUsers.isEmpty
              ? const Center(
                  child: Text(
                    "Looks like no one here",
                    style: TextStyle(color: Color(0xff50586C)),
                  ),
                )
              : ListView.builder(
                  itemCount: waitingUsers.length,
                  itemBuilder: (ctx, index) =>
                      UserCard(userName: waitingUsers[index])),
          widget.showStartButton
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: Color(0xff50586C),
                    ),
                    child: IconButton(
                      onPressed: () {
                        canDelete = false;
                        waitingRoomFunction(widget.roomCode, false, true);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => HostScreen(
                              roomCode: widget.roomCode,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.play_arrow_rounded,
                        color: Color(0xffDCE2F0),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
