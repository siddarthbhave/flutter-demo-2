import 'package:coffee_gang/screens/authenticate/authenticate.dart';
import 'package:coffee_gang/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_gang/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    //return either home or authenticate depending on the auth
    return user == null ? Authenticate() : Home();
  }
}
