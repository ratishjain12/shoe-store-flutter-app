import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';

import 'package:onlineshop_provider/controllers/mainscreen_provider.dart';

import 'package:onlineshop_provider/ui/cartpage.dart';
import 'package:onlineshop_provider/ui/favourite.dart';
import 'package:onlineshop_provider/ui/homepage.dart';
import 'package:onlineshop_provider/ui/profilepage.dart';
import 'package:onlineshop_provider/ui/searchpage.dart';
import 'package:provider/provider.dart';

import '../shared/bottomtabs.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> pageList = const [
    HomePage(),
    SearchPage(),
    FavouritePage(),
    CartPage(),
    ProfilePage(),
  ];

  final auth = FirebaseAuth.instance;

  void setNumber() {
    final mainScreenContext =
        Provider.of<MainScreenNotifier>(context, listen: false);
    if (FirebaseAuth.instance.currentUser != null) {
      mainScreenContext.changeUserPhone =
          FirebaseAuth.instance.currentUser!.phoneNumber.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setNumber();
    });
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<MainScreenNotifier>(
        builder: (context, mainScreenNotifier, child) {
      return Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        body: pageList[mainScreenNotifier.pageIndex],
        bottomNavigationBar: SafeArea(
            child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: width * 0.001, vertical: 5.0),
          child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.1, vertical: height * 0.016),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                  color: Color(0xFFFF8282),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BottomNavElement(
                      icon: Icon(
                        mainScreenNotifier.pageIndex == 0
                            ? Icons.home
                            : Icons.home_outlined,
                        color: Colors.white,
                        size: 25,
                      ),
                      onTap: () {
                        mainScreenNotifier.pageIndexChange = 0;
                      }),
                  BottomNavElement(
                      icon: Icon(
                        mainScreenNotifier.pageIndex == 1
                            ? Icons.search
                            : Icons.search_outlined,
                        color: Colors.white,
                        size: 25,
                      ),
                      onTap: () {
                        mainScreenNotifier.pageIndexChange = 1;
                      }),
                  BottomNavElement(
                    icon: Icon(
                      mainScreenNotifier.pageIndex == 2
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.white,
                      size: 25,
                    ),
                    onTap: () {
                      mainScreenNotifier.pageIndexChange = 2;
                    },
                  ),
                  BottomNavElement(
                    icon: Icon(
                      mainScreenNotifier.pageIndex == 3
                          ? Icons.shopping_basket
                          : Icons.shopping_basket_outlined,
                      color: Colors.white,
                      size: 25,
                    ),
                    onTap: () {
                      mainScreenNotifier.pageIndexChange = 3;
                    },
                  ),
                  BottomNavElement(
                    icon: Icon(
                      mainScreenNotifier.pageIndex == 4
                          ? Icons.person
                          : Icons.person_outlined,
                      color: Colors.white,
                      size: 25,
                    ),
                    onTap: () {
                      mainScreenNotifier.pageIndexChange = 4;
                    },
                  ),
                ],
              )),
        )),
      );
    });
  }
}
