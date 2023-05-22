import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlineshop_provider/shared/appstyle.dart';
import 'package:onlineshop_provider/shared/list_tile.dart';
import 'package:onlineshop_provider/ui/loginpage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoggedin = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
      body: isLoggedin
          ? Container(
              padding: EdgeInsets.symmetric(vertical: height * 0.035),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                    child: Center(
                        child: CircleAvatar(
                      backgroundColor: const Color(0xffff8282),
                      radius: height * 0.05,
                      child: Icon(
                        Icons.person,
                        size: height * 0.05,
                        color: const Color(0xffffffff),
                      ),
                    )),
                  ),
                  Text(
                    'Name',
                    style: appstyle(25, Colors.black, FontWeight.bold),
                  ),
                  Text(
                    '+91 XXXXX XXXXX',
                    style: appstyle(15, Colors.black, FontWeight.w600),
                  ),
                  Divider(
                    height: height * 0.04,
                    thickness: 1,
                    indent: width * 0.2,
                    endIndent: width * 0.2,
                  ),
                  CustomTile(
                      onTap: () {},
                      icon: Icons.location_on_outlined,
                      name: 'Change Address'),
                  CustomTile(
                      onTap: () {},
                      icon: Icons.shopping_cart_outlined,
                      name: 'My orders'),
                  CustomTile(
                      onTap: () {},
                      icon: Icons.manage_accounts_outlined,
                      name: 'Account Settings'),
                  SizedBox(height: height * 0.15),
                  MaterialButton(
                    onPressed: () {},
                    color: const Color(0xffff8282),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13)),
                    minWidth: width * 0.3,
                    height: height * 0.05,
                    child: Text(
                      'logout',
                      style: appstyle(18, Colors.white, FontWeight.w600),
                    ),
                  )
                ],
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                  "Please login!!",
                  style: appstyle(30, Colors.grey.shade700, FontWeight.bold),
                )),
                SizedBox(
                  height: height * 0.03,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => const LoginPage()));
                  },
                  color: const Color(0xffff8282),
                  minWidth: width * 0.3,
                  height: height * 0.05,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    "login",
                    style: appstyle(18, Colors.white, FontWeight.w600),
                  ),
                )
              ],
            ),
    );
  }
}
