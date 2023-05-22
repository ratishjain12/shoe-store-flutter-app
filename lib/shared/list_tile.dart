import 'package:flutter/material.dart';
import 'package:onlineshop_provider/shared/appstyle.dart';
// import 'package:google_fonts/google_fonts.dart

class CustomTile extends StatelessWidget {
  void Function() onTap;
  // Color? color, iconColor;
  IconData? icon;
  String name;
  CustomTile(
      {super.key,
      required this.onTap,
      // required this.color,
      // required this.iconColor,
      required this.icon,
      required this.name});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.009),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: EdgeInsets.all(height * 0.01),
          decoration: BoxDecoration(
            color: const Color(0xffff8282).withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: const Color(0xffff8282),
            size: 25,
          ),
        ),
        title: Text(name, style: appstyle(20, Colors.black, FontWeight.w600)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}
