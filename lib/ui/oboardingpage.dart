import 'package:flutter/material.dart';
import 'package:onlineshop_provider/ui/obpages.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageController = PageController();
  static const _duration = Duration(milliseconds: 500);
  static const _curve = Curves.ease;
  final _arrowColor = Color(0xffff8282).withOpacity(0.8);
  int _activePage = 0;

  final List<Widget> _pages = [
    const PageOne(),
    const PageTwo(),
    const PageThree()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IconTheme(
        data: IconThemeData(color: _arrowColor),
        child: Stack(
          children: [
            PageView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _pageController,
                itemBuilder: (BuildContext context, int index) {
                  return _pages[index % _pages.length];
                }),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.grey.withOpacity(0.5),
                  padding: const EdgeInsets.all(20),
                  child: Center(
                      child: SmoothPageIndicator(
                    controller: _pageController,
                    count: _pages.length,
                    effect: const ExpandingDotsEffect(
                        dotColor: Colors.white,
                        activeDotColor: Color(0xffff8282)),
                  )),
                ))
          ],
        ),
      ),
    );
  }
}
