import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  String emailAddress = '';
  String passsword = '';
  String name= '';
  String lastName = '';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  // late User _userAuth;

  bool get isLoading {
    return _isLoading;
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  // User get user {
  //   return _userAuth;
  // }

  // set user(User value) {
  //   _userAuth = value;
  //   notifyListeners();
  // }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void resetForm() {
    formKey.currentState?.reset();
  }
}
