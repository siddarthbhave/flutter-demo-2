import 'package:coffee_gang/models/coffee.dart';
import 'package:flutter/material.dart';
import 'package:coffee_gang/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:coffee_gang/services/database.dart';
import 'package:coffee_gang/screens/home/coffee_list.dart';
import 'package:coffee_gang/screens/home/settings_form.dart';


class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    

    void _showSettings(){
      showModalBottomSheet( isScrollControlled: true ,context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical:20.0 , horizontal:60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Coffee>>.value(
        value: DatabaseService().coffeeStream,
        child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text('Coffee Gang'),
          backgroundColor: Colors.grey[700],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              label: Text('Log-out'),
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person_outline),
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings_applications),
              label: Text('Edit'),
              onPressed: () => _showSettings(),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee.png'),
              fit: BoxFit.cover
            )
          ),
          child: CoffeeList()
        ),
      ),
    );
  }
}
