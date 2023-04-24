import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlineshop_provider/shared/appstyle.dart';
import 'package:onlineshop_provider/shared/latestshoes.dart';
import 'package:onlineshop_provider/shared/shoecard.dart';

class WomenSection extends StatefulWidget {
  const WomenSection({super.key});

  @override
  State<WomenSection> createState() => _WomenSectionState();
}

class _WomenSectionState extends State<WomenSection> {
  List _shoes = [];

  @override
  void initState() {
    // TODO: implement initState
    loadJsonData();
    super.initState();
  }

  Future<void> loadJsonData() async {
    final String response = await rootBundle.loadString("assets/shoedata.json");
    final data = await jsonDecode(response);
    data["items"].forEach((ele) {
      if (ele["gender"] == "WOMEN") {
        _shoes.add(ele);
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Women's Shoes",
                style: appstyle(24, Colors.black, FontWeight.bold),
              ),
            ),
            _shoes.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    color: const Color(0xFFFAFAFA),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.34,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return ShoeCard(
                            name: _shoes[index]["name"],
                            price: _shoes[index]["price"],
                            imgUrl: _shoes[index]["imageURL"],
                          );
                        }),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest Shoes",
                    style: appstyle(18, Colors.black, FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        "Show all ",
                        style: appstyle(18, Colors.black, FontWeight.bold),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _shoes.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          int reverseIndex = _shoes.length - index - 1;
                          return LatestShoeCard(
                            imgUrl: _shoes[reverseIndex]['imageURL'],
                          );
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}
