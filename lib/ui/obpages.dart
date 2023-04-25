import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:onlineshop_provider/shared/appstyle.dart';
import 'package:onlineshop_provider/ui/mainscreen.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
      )),
    );
  }
}

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
      )),
    );
    ;
  }
}

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
            margin: EdgeInsets.symmetric(vertical: 15),
            child: IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainScreen()));
              },
            ),
          )
        ],
      )),
    );
  }
}
