class Results {
  Results(this.name, this.dateTime);
  String name;
  Duration dateTime;
}

class JoinRoom {
  JoinRoom(this.userIndex, this.canJoin);
  int userIndex;
  bool canJoin;
}
