import 'package:flutter/material.dart';
import 'package:onlineshop_provider/shared/appstyle.dart';

class IndividualShoe extends StatefulWidget {
  final String shoename;
  final int price;
  final String category;
  final String imgUrl;

  const IndividualShoe(
      {super.key,
      required this.shoename,
      required this.price,
      required this.category,
      required this.imgUrl});

  @override
  State<IndividualShoe> createState() => _IndividualShoeState();
}

class _IndividualShoeState extends State<IndividualShoe> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 232, 232),
      body: SafeArea(
        child: Column(children: [
          Stack(
            children: [
              Container(
                width: double.maxFinite,
                height: height * 0.4,
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      image: NetworkImage(widget.imgUrl), fit: BoxFit.cover),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
            ],
          ),
          Row(
            children: [
              Text(widget.shoename),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                height: 56,
                decoration: const BoxDecoration(
                    color: Color(0xFFFF8282),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.shopping_basket,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Add to cart",
                      style: appstyle(22, Colors.white, FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
