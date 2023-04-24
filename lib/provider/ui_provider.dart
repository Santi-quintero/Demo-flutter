import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _selectedMenuOpt = 0;

  bool _isFail = false;

  String _messageFail = '';

  int get selectedMenuOpt {
    return _selectedMenuOpt;
  }

  set selectedMenuOpt(int i) {
    _selectedMenuOpt = i;
    notifyListeners();
  }

  bool get isFail {
    return _isFail;
  }

  set isFail(bool value) {
    _isFail = value;
    notifyListeners();
  }

  String get messageFail {
    return _messageFail;
  }

  set messageFail(String value) {
    _messageFail = value;
    notifyListeners();
  }
}
