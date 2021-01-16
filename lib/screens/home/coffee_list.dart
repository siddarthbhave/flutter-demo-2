

import 'package:coffee_gang/models/user.dart';
import 'package:coffee_gang/services/database.dart';
import 'package:coffee_gang/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_gang/models/coffee.dart';
import 'coffee_tile.dart';
class CoffeeList extends StatefulWidget {
  @override
  _CoffeeListState createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> {

  
  @override
  Widget build(BuildContext context) {
    
    final coffees = Provider.of<List<Coffee>>(context) ?? [];
    final user = Provider.of<User>(context);
    UserData parUser;
    Coffee temp;
    void firstUser(){
      for(int i=0; i<coffees.length; ++i){
        if(coffees[i].name == parUser.name){
          //swap coffees[i] with coffees[0]
          temp = coffees[i];
          coffees[i] = coffees[0];
          coffees[0] = temp;
        }
      }
    }
    

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot){
        if (snapshot.hasData) {
          parUser = snapshot.data;
          firstUser();
          return ListView.builder(
                      itemCount: coffees.length,
                      itemBuilder: (context , index){
                      return CoffeeTile(coffee : coffees[index]);
              },
            );
          
        } else {
          return Loading();
        }


      },
    );
  }
}