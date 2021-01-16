import 'package:flutter/material.dart';
import 'package:coffee_gang/models/coffee.dart';

class CoffeeTile extends StatelessWidget {
  
  final Coffee coffee;
  CoffeeTile({this.coffee});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/cup.png'),
            radius: 25.0,
            backgroundColor: Colors.brown[coffee.strength],
          ),
          title: Text(
            coffee.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Takes ${coffee.sugars} sugar(s).',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 17.0),
          ),
        ),
      ),
    );
  }
}