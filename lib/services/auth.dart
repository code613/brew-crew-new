//package should be called AuthService instead of auth

import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_brew/models/user.dart';
import 'package:new_brew/services/database.dart';

class AuthService {
  //await Firebase.initializeApp();
  final FirebaseAuth _auth = FirebaseAuth.instance; //_ is private

  //creat userforfirebase obj based on firebaseuser
  UserForFirebase _userFromFirebase(User u) {
    return u != null ? UserForFirebase(uid: u.uid) : null;
  }

  //auth change user stream
  Stream<UserForFirebase> get user {
    return _auth
        .authStateChanges() //.map((User user) => _userFromFirebase(user));
        .map(_userFromFirebase);
  }

  //sign in anon
  Future signInAnon() async {
    try {
      //signInAnonymously must be enabled in firebase project
      UserCredential result = await _auth.signInAnonymously();
      User theUser = result.user;

      return _userFromFirebase(theUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email/pass
  Future signInWithEandP(String e, String p) async {
    try {
      //signIn with email and password must be enabled in firebase project
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: e, password: p);
      User theUser = result.user;
      return _userFromFirebase(theUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email /pass
  Future registerWithEandP(String e, String p) async {
    try {
      //signIn with email and password must be enabled in firebase project
      UserCredential result =
          await _auth.createUserWithEmailAndPassword(email: e, password: p);
      User theUser = result.user;

      //create a new document for the user and the uid
      await DatebaseService(uid: theUser.uid)
          .updateUserData('0', 'new crew brew member', 100);
      return _userFromFirebase(theUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
