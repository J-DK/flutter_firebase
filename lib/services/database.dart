import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/models/brew.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String name, String sugars, int strength) async {
    await brewCollection.doc(uid).set({
      'name': name,
      'sugars': sugars,
      'strength': strength
    });
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(brewListFromSnapshot);
  }

  List<Brew> brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => Brew(
        name: doc.data()['name'] ?? '',
        sugars: doc.data()['sugars'] ?? '',
        strength: doc.data()['strength'] ?? 100
    )).toList();

  }
}