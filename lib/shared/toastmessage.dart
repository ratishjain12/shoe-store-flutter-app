import 'package:flutter/material.dart';
import 'package:onlineshop_provider/shared/appstyle.dart';

class ToastMessage {
  static void showToast(BuildContext context, String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        style: appstyle(20, Colors.white, FontWeight.w400),
        textAlign: TextAlign.center,
      ),
      backgroundColor: color,
      duration: const Duration(milliseconds: 2000),
    ));
  }
}
