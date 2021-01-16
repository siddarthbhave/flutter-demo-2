import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_gang/models/coffee.dart';
import 'package:coffee_gang/models/user.dart';

class DatabaseService {
  //collection references
  final CollectionReference coffee = Firestore.instance.collection('coffees');
  final String uid;
  DatabaseService({this.uid});
  Future updateUserData(String sugars, String name, int strength) async {
    return await coffee.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  //get the stream from database
  Stream<List<Coffee>> get coffeeStream {
    return coffee.snapshots().map(_toCoffee);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return coffee.document(uid).snapshots().map(_toUserData);
  }

  //coffee list from snapshot
  List<Coffee> _toCoffee (QuerySnapshot query) {
    return query.documents.map((doc){
      return Coffee(
        name: doc.data['name'] ?? '',
        sugars: doc.data['sugars'] ?? '0',
        strength: doc.data['strength'] ?? 0
      );
    }).toList();
  }

  //user data from snapshot
  UserData _toUserData(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength']
    );
  }

}
