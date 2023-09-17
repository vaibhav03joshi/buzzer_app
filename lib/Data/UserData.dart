class Results {
  Results(this.name, this.dateTime);
  String name;
  DateTime dateTime;
}

class JoinRoom {
  JoinRoom(this.userIndex, this.canJoin);
  int userIndex;
  bool canJoin;
}
