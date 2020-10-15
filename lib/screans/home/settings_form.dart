import 'package:flutter/material.dart';
import 'package:new_brew/models/user.dart';
import 'package:new_brew/services/database.dart';
import 'package:new_brew/shared_code/consts.dart';
import 'package:new_brew/shared_code/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>(); // TODO:
  final List<String> sugers = ['0', '1', '2', '3', '4'];

  //form values
  String _currentName;
  String _currentSugers;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserForFirebase>(context);

    return StreamBuilder<UserData>(
        stream: DatebaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          } else {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'update your brew settings.',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDeceration,
                    validator: (val) =>
                        val.isEmpty ? "please enter name" : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //drop down
                  DropdownButtonFormField(
                    decoration: textInputDeceration,
                    value: _currentSugers ?? userData.suger,
                    items: sugers.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugers = val),
                  ),
                  //slider
                  Slider(
                    min: 100,
                    max: 900,
                    divisions: 8,
                    activeColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                  ),
                  //botton
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await DatebaseService(uid: user.uid).updateUserData(
                              //(String suger, String name, int strength)
                              _currentSugers ?? userData.suger,
                              _currentName ?? userData.name,
                              _currentStrength ?? userData.strength);
                          Navigator.pop(context); //pop off form
                        }
                        print(_currentName);
                      })
                ],
              ),
            );
          }
        });
  }
}
