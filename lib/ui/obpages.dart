import 'package:flutter/material.dart';
import 'package:onlineshop_provider/shared/appstyle.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: RichText(
            text: TextSpan(
      children: [
        TextSpan(
            text: 'Find your favourite shoes \n\n',
            style: appstyle(20, Colors.black, FontWeight.bold)),
        TextSpan(text: 'Find your favourite shoes \n'),
        TextSpan(text: 'That you need to wear')
      ],
    )));
  }
}

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: RichText(
            text: TextSpan(
      children: [
        TextSpan(
            text: 'Easy & safe payment \n\n',
            style: appstyle(20, Colors.black, FontWeight.bold)),
        TextSpan(text: 'Pay for the products you buy \n'),
        TextSpan(text: 'easily and safely')
      ],
    )));
  }
}

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: RichText(
            text: TextSpan(
      children: [
        TextSpan(
            text: 'Product delivery \n\n',
            style: appstyle(20, Colors.black, FontWeight.bold)),
        TextSpan(text: 'Your products are delivered \n'),
        TextSpan(text: 'home safely and securely')
      ],
    )));
  }
}
