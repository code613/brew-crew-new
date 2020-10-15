import 'package:flutter/material.dart';
import 'package:new_brew/models/brew.dart';
import 'package:new_brew/screans/home/brew_list.dart';
import 'package:new_brew/screans/home/settings_form.dart';
import 'package:new_brew/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:new_brew/services/database.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SettingsForm(),
            );
          });
    }

    return Container(
      child: StreamProvider<List<Brew>>.value(
        value: DatebaseService().brewStream,
        child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text('brew crew new'),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  icon: Icon(Icons.person),
                  label: Text('logout')),
              FlatButton.icon(
                  onPressed: () => _showSettingsPanel(),
                  icon: Icon(Icons.settings),
                  label: Text('settings'))
            ],
          ),
          body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/coffe_beens_flutter_1.png'),
                      fit: BoxFit.cover)),
              child: BrewList()),
        ),
      ),
    );
  }
}
