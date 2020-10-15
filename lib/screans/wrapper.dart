import 'package:flutter/material.dart';
import 'package:new_brew/models/user.dart';
import 'package:new_brew/screans/home/home.dart';
import 'package:provider/provider.dart';

import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserForFirebase>(context);
    print(user);
    print("used provider");
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
