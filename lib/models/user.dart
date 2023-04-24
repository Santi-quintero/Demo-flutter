import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier{
  String name;
  String emailAdrees;
  String password;

  UserModel(
      {required this.name, required this.emailAdrees, required this.password});

  factory UserModel.fromFirestore(DocumentSnapshot userDoc) {
    Map userData = userDoc.data as Map;
    return UserModel(
      name: userData['name'],
      emailAdrees: userData['emailAdrees'],
      password: userData['password'],
    );
  }

  void setFromFireStore(DocumentSnapshot userDoc) {
    Map userData = userDoc.data as Map;
    name = userData['name'];
    emailAdrees = userData['emailAdrees'];
    password = userData['password'];
    notifyListeners();
  }
}
