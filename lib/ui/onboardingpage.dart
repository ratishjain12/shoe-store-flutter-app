import 'package:flutter/material.dart';
import 'package:onlineshop_provider/ui/obpages.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [PageOne(), PageTwo(), PageThree()];
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        PageView.builder(
            itemCount: _pages.length,
            controller: _pageController,
            itemBuilder: ((context, index) {
              return _pages[index % _pages.length];
            }))
      ]),
    );
  }
}
