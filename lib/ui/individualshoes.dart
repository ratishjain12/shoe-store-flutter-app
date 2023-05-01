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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            children: [
              Container(
                width: double.maxFinite,
                height: height * 0.4,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.all(Radius.circular(40)).copyWith(
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                  ),
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
              Positioned(
                right: 0,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_border),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.shoename,
                  style:
                      appstyleWithHeight(22, Colors.black, FontWeight.bold, 2),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Price:" + " \$${widget.price.toString()}",
                      style: appstyle(18, Colors.black, FontWeight.w600),
                    ),
                    Text(
                      "Category: " + "${widget.category}",
                      style: appstyle(18, Colors.black, FontWeight.w600),
                    )
                  ],
                ),
              ],
            ),
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
