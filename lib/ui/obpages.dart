import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:onlineshop_provider/shared/appstyle.dart';
import 'package:onlineshop_provider/ui/mainscreen.dart';
import 'package:provider/provider.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
          child: Container(
        color: Colors.white,
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/page1.png'),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Find your favorite shoes',
                style: appstyle(20, Colors.black, FontWeight.bold),
              ),
            ),
            Text(
              'Find Your favourite shoes \n that you need to buy.',
              style: appstyle(15, Colors.black, FontWeight.normal),
            )
          ],
        ),
      )),
    );
  }
}

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
          child: Container(
        color: Colors.white,
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/page2.png'),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Easy & safe payment',
                style: appstyle(20, Colors.black, FontWeight.bold),
              ),
            ),
            Text(
              'Safe & easy payment methods \n for your shopping.',
              style: appstyle(15, Colors.black, FontWeight.normal),
            )
          ],
        ),
      )),
    );
    ;
  }
}

class PageThree extends StatefulWidget {
  const PageThree({super.key});

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  var box = Hive.box('onBoarding');

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
          child: Container(
        color: Colors.white,
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/page3.png'),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Product Delivery',
                style: appstyle(20, Colors.black, FontWeight.bold),
              ),
            ),
            Text(
              'Your products are delivered home \n safely & securely.',
              style: appstyle(15, Colors.black, FontWeight.normal),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  box.put("status", true);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
