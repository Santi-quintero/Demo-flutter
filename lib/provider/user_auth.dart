import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase database = FirebaseDatabase.instance;

  User? _user;

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      notifyListeners();
      return 'true';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return 'e';
    }
  }

  Future singInWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _user = userCredential.user;
      notifyListeners();
      return 'true';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email...';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    } catch (e) {
      return ('algo salio mal');
    }
  }

  Future addUserDatabase(String name, String lastName, String phone,
      String address, int date, String gender, String email) async {
    try {
      final uuid = _user?.uid;
      print('uuid: $uuid');
      final ref = database.ref().child('/lawyers/$uuid');
      await ref.set({
        "name": name,
        "lastName": lastName,
        "phone": phone,
        "address": address,
        "dateOfbirth": date,
        "gender": gender,
        "email": email,
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  getUser() {
    return _user;
  }

  void signOut() async {
    await _auth.signOut();
    // ignore: avoid_print
    print('cierra sesion');
    notifyListeners();
  }
}
