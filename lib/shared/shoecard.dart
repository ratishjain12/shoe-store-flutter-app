// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:onlineshop_provider/shared/appstyle.dart';

class ShoeCard extends StatelessWidget {
  final String name;
  final String imgUrl;
  final int price;
  const ShoeCard({
    Key? key,
    required this.name,
    required this.imgUrl,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        // color: Color.fromARGB(255, 242, 234, 234),
        decoration: const BoxDecoration(
            color: Color(0xFFFAFAFA),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.34,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(imgUrl)),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {}, icon: Icon(Icons.favorite_outline)),
                ),
                Positioned(
                  width: MediaQuery.of(context).size.width * 0.6,
                  top: 245,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: 170,
                        child: Text(
                          name,
                          style: appstyleWithHeight(
                              16, Colors.black, FontWeight.w600, 1.2),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          "\$${price.toString()}",
                          style: appstyleWithHeight(
                              18, Colors.black, FontWeight.w600, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
