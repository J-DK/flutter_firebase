import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  BrewUser userFromFirebase(User user) {
    return user != null ? BrewUser(uid: user.uid) : null;
  }

  // Sign in anonymous
  Future signInAnonymous() async {

    try {
      UserCredential result =  await _auth.signInAnonymously();
      User user = result.user;
      return userFromFirebase(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Sign in with email & password

  // Register with email & password

  // Sign Out
}