//this class also isn't named properly..
class UserForFirebase {
  final String uid;

  UserForFirebase({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String suger;
  final int strength;

  UserData({this.name, this.strength, this.suger, this.uid});
}
