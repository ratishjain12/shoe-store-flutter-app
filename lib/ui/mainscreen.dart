import 'package:flutter/material.dart';

import 'package:onlineshop_provider/controllers/mainscreen_provider.dart';

import 'package:onlineshop_provider/ui/cartpage.dart';
import 'package:onlineshop_provider/ui/homepage.dart';
import 'package:onlineshop_provider/ui/profilepage.dart';
import 'package:onlineshop_provider/ui/searchpage.dart';
import 'package:provider/provider.dart';

import '../shared/bottomtabs.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  List<Widget> pageList = const [
    HomePage(),
    SearchPage(),
    HomePage(),
    CartPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
        builder: (context, mainScreenNotifier, child) {
      return Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        body: pageList[mainScreenNotifier.pageIndex],
        bottomNavigationBar: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
              padding: const EdgeInsets.all(10),
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
                      ),
                      onTap: () {
                        mainScreenNotifier.pageIndexChange = 1;
                      }),
                  BottomNavElement(
                    icon: Icon(
                      mainScreenNotifier.pageIndex == 2
                          ? Icons.favorite
                          : Icons.favorite_outlined,
                      color: Colors.white,
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
