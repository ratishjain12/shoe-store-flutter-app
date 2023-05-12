import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Onboarding extends ChangeNotifier {
  bool onBoarded = false;
  bool get ob => onBoarded;

  void changeOnboarding(bool value) async {
    var box = await Hive.openBox('onboarding');
    box.put('onboard', value);
    onBoarded = box.get('onboard');
    notifyListeners();
  }
}
