import 'dart:core';

import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {
  String name = '';
  String lastName = '';
  String phone = '';
  String address= '';
  int date = 0;
  String gender = 'Male';
  String emailAddress = '';
  String passsword = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void resetForm() {
    formKey.currentState?.reset();
  }
}
