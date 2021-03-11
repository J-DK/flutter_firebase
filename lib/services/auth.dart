import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  BrewUser userFromFirebase(User user) {
    return user != null ? BrewUser(uid: user.uid) : null;
  }

  Stream<BrewUser> get user {
    return _auth.authStateChanges().map((User user) => userFromFirebase(user));
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
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return userFromFirebase(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return userFromFirebase(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Sign Out
  Future signOut() async {
    try {
     return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}