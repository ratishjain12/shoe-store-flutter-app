import 'package:flutter/material.dart';
import 'package:onlineshop_provider/shared/appstyle.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Account",
            style: appstyle(22, Colors.white, FontWeight.w600),
          ),
          backgroundColor: const Color(0xFFFF8282),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            "Profilepage",
            style: appstyle(30, Colors.black, FontWeight.bold),
          ),
        ));
  }
}
