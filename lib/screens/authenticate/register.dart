import 'package:coffee_gang/services/auth.dart';
import 'package:coffee_gang/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggle;
  Register({this.toggle});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email, pass, err = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              backgroundColor: Colors.grey[700],
              elevation: 0.0,
              title: Text('Register'),
              centerTitle: true,
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggle();
                    },
                    icon: Icon(Icons.person_outline),
                    label: Text('Sign-In'))
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
                            ? 'Password must be more than 6 digits'
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
                                await _auth.registerWithEmail(email, pass);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                err = 'Invalid Email';
                              });
                            }
                          } else {}
                        },
                        icon: Icon(
                          Icons.done_outline,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Register',
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
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
