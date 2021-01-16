import 'package:coffee_gang/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:coffee_gang/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn({this.toggle});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //state for email and password
  String email = '';
  String pass = '';
  String err = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading  ? Loading() : Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              backgroundColor: Colors.grey[700],
              elevation: 0.0,
              title: Text('Sign In'),
              centerTitle: true,
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggle();
                    },
                    icon: Icon(Icons.person_add),
                    label: Text('Register'))
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Email goes here!',
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0)),
                        ),
                        validator: (val) => val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Password goes here!',
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0)),
                        ),
                        validator: (val) => val.length < 6
                            ? 'Passwords must be 6+ characters'
                            : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() {
                            pass = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton.icon(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result =
                                await _auth.signInWithEmail(email, pass);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                err = 'Invalid Email to sign-in';
                              });
                            }
                          } else {}
                        },
                        icon: Icon(
                          Icons.done_outline,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Verify',
                          style: TextStyle(
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        err,
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0),
                      ),
                      // Divider(
                      //   color: Colors.blue[900],
                      //   height: 50.0,
                      // ),
                      // RaisedButton(
                      //   child: Text('Sign-in anonymously'),
                      //   onPressed: () async {
                      //     dynamic result = await _auth.signinanon();
                      //     result == null
                      //         ? print('Error signing in')
                      //         : print('signed in as ${result.uid}');
                      //   },
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
