import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugar, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugar,
      'name': name,
      'strength': strength,
    });
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: (snapshot.data() as Map)['name'],
        sugars: (snapshot.data() as Map)['sugars'],
        strength: (snapshot.data() as Map)['strength']);
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return Brew(
          name: (doc.data()! as Map)["name"],
          strength: (doc.data()! as Map)['strength'],
          sugars: (doc.data()! as Map)['sugars']);
    }).toList();
  }

  Stream<List<Brew>> get brew {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
