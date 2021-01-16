import 'package:coffee_gang/screens/authenticate/register.dart';
import 'package:coffee_gang/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignin = true;
  void toggleView() {
    setState(() {
      showSignin = !showSignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: showSignin == true
          ? SignIn(toggle: toggleView)
          : Register(toggle: toggleView),
    );
  }
}
