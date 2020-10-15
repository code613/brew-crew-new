import 'package:flutter/material.dart';
import 'package:new_brew/screans/authenticate/register.dart';
import 'package:new_brew/screans/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool isSignedIn = true;
  void toggleVeiw() {
    setState(() {
      isSignedIn = !isSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isSignedIn) {
      return SignIn(tv: toggleVeiw);
    } else {
      return Register(tv: toggleVeiw);
    }
  }
}
