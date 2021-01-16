import 'package:coffee_gang/models/user.dart';
import 'package:coffee_gang/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //change Firebase user to User
  User _toUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream (very important)
  Stream<User> get user {
    return _auth.onAuthStateChanged.map((FirebaseUser user) => _toUser(user));
    //the above can also be done as:
    //.map(_toUser);
  }

  //sign in anon
  Future signinanon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _toUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email
  Future registerWithEmail(String email, String pass) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid)
          .updateUserData('0', 'new member', 100);
      return _toUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sigin in with email and password
  Future signInWithEmail(String email, String pass) async {
    try {
      AuthResult result =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = result.user;

      return _toUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
