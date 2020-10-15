import 'package:flutter/material.dart';
import 'package:new_brew/services/auth.dart';
import 'package:new_brew/shared_code/consts.dart';
import 'package:new_brew/shared_code/loading.dart';

class SignIn extends StatefulWidget {
  final tv;
  SignIn({this.tv});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
              title: Text("sign in to new brew crew"),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.tv();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Register'))
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
                          obscureText: true,
                          validator: (value) => value.length < 6
                              ? 'Enter a password > 5 chars'
                              : null,
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
                              'Sign In',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result = await _authSignIn
                                    .signInWithEandP(email, password);

                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    error = 'could not sign in with your creds';
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
