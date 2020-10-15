import 'package:flutter/material.dart';
import 'package:new_brew/services/auth.dart';
import 'package:new_brew/shared_code/consts.dart';
import 'package:new_brew/shared_code/loading.dart';

class Register extends StatefulWidget {
  final tv;
  Register({this.tv});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authSignIn = AuthService(); //auth.dart
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text feild state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0,
              title: Text("Registration to new brew crew"),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.tv();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Sign in'))
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration:
                              textInputDeceration.copyWith(hintText: 'Email'),
                          validator: (value) =>
                              value.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          //password
                          decoration: textInputDeceration.copyWith(
                              hintText: 'Password'),
                          validator: (value) => value.length < 6
                              ? 'Enter a password > 5 chars'
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                            color: Colors.pink,
                            child: Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result = await _authSignIn
                                    .registerWithEandP(email, password);
                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    error = 'please supply valid cred';
                                  });
                                }
                              }
                            }),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        )
                      ],
                    ))),
          );
  }
}
