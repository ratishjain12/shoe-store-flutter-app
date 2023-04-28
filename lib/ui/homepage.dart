import 'package:flutter/material.dart';
import 'package:onlineshop_provider/shared/appstyle.dart';
import 'package:onlineshop_provider/ui/mensection.dart';
import 'package:onlineshop_provider/ui/womensection.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int choiceIndex = 0;
  final _pageController = PageController(initialPage: 0);
  List<Widget> sections = const [
    MenSection(),
    WomenSection(),
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color(0xFAFAFAFA),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Explore",
                      style: appstyle(40, Colors.black, FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.01, horizontal: width * 0.03),
                margin: EdgeInsets.only(
                    left: width * 0.25,
                    top: height * 0.01,
                    bottom: height * 0.01),
                decoration: const BoxDecoration(
                  color: Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          choiceIndex = 0;
                        });
                        _pageController.animateToPage(0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 8),
                        decoration: BoxDecoration(
                            color: choiceIndex == 0
                                ? Color(0xFF64ECC7)
                                : Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(22))),
                        child: Center(
                            child: Text(
                          "Men",
                          style: appstyle(18, Colors.black, FontWeight.normal),
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          choiceIndex = 1;
                        });
                        _pageController.animateToPage(1,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                            color: choiceIndex == 1
                                ? Color(0xFF64ECC7)
                                : Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(22))),
                        child: Center(
                            child: Text(
                          "Women",
                          style: appstyle(18, Colors.black, FontWeight.normal),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 0.7,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: const [
                    MenSection(),
                    WomenSection(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
