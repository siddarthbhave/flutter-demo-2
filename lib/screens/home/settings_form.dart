import 'package:coffee_gang/services/database.dart';
import 'package:coffee_gang/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:coffee_gang/models/user.dart';
import 'package:provider/provider.dart';
class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];

  String _currentName, _currentSugar ;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0,),
                Text(
                  'Update your preferences:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,),
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  initialValue: userData.name,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey, width: 2.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 2.0)),
                  ),
                  validator: (val) => val.isEmpty ? 'Please enter your name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                  
                ),
                SizedBox(height: 20.0,),
                //dropdown
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey, width: 2.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 2.0)),
                  ),
                  value: _currentSugar ?? userData.sugars,
                  items: sugars.map((sugar){
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugar(s)'),
                    );
                  }).toList(),
                  validator: (val) => val == null ? 'Select the sugar count' : null,
                  onChanged: (val) => setState((){_currentSugar = val;}),
                ),
                //slider
                Slider(
                  min: 100, // increment in 100 steps
                  max: 900,
                  divisions: 8,
                  onChanged: (val) => setState(()=> _currentStrength = val.round()),
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  activeColor: Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor: Colors.green,
                ),
                RaisedButton(
                  color: Colors.black,
                  child: Text(
                    'Update!',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugar ?? userData.sugars,
                        _currentName ?? userData.name,
                        _currentStrength ?? userData.strength
                      );
                      Navigator.pop(context);
                    } 
                  },
                ),
                SizedBox(height: 20.0,),
                Text('Swipe down to go back'),
                Icon(
                  Icons.arrow_downward,
                ),
              ],
            ),
            
          );

        } else {
          return Loading();
        }
        
      }
    );
  }
}