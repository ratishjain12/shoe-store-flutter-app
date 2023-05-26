import 'package:flutter/material.dart';

class MainScreenNotifier extends ChangeNotifier {
  int _pageIndex = 0;

  String? userPhone = "";

  String? get getUserPhone => userPhone;

  set changeUserPhone(String val) {
    userPhone = val;
    notifyListeners();
  }

  int get pageIndex => _pageIndex;

  set pageIndexChange(int newIndex) {
    _pageIndex = newIndex;
    notifyListeners();
  }

  void changeToSearch() {
    _pageIndex = 1;
    notifyListeners();
  }
}
