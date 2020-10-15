import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:new_brew/models/brew.dart';
import 'package:new_brew/models/user.dart';

class DatebaseService {
  final String uid;
  DatebaseService({this.uid});
  //collection refrence
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String suger, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'suger': suger,
      'name': name,
      'strength': strength,
    });
  }

  //brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snap) {
    return snap.docs.map((d) {
      return Brew(
        name: d.data()['name'] ?? '',
        strength: d.data()['strength'] ?? '0',
        suger: d.data()['suger'] ?? '0',
      );
    }).toList();
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snap) {
    return UserData(
      uid: uid,
      name: snap.data()['name'],
      suger: snap.data()['suger'],
      strength: snap.data()['strength'],
    );
  }

  //get brews streams
  Stream<List<Brew>> get brewStream {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
