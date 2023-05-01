
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:onlineshop_provider/controllers/favourites_provider.dart';
import 'package:onlineshop_provider/shared/appstyle.dart';

import '../ui/individualshoes.dart';

class ShoeCard extends StatelessWidget {
  final int id;
  final String name;
  final String imgUrl;
  final int price;
  final String category;
  const ShoeCard({
    Key? key,
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.price, required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<Favourites>(
      builder: (context, value, child) {
        Map<int, dynamic> favItems = value.items;
        return GestureDetector(
          onTap: () {
             Navigator.push(context, MaterialPageRoute(builder: (context)=>IndividualShoe(shoename: name, price: price, category: category, imgUrl: imgUrl)));
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            margin: const EdgeInsets.only(right: 10,left: 5),
            // color: Color.fromARGB(255, 242, 234, 234),
            decoration: const BoxDecoration(
                color: Color(0xFFFAFAFA),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height:height * 0.34,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                              fit: BoxFit.cover, image: NetworkImage(imgUrl)),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          splashRadius: 1,
                          color: const Color(0xFFFF8282),
                          onPressed: () {
                            value.addFavourties(
                                id: id,
                                name: name,
                                imgUrl: imgUrl,
                                price: price);
                          },
                          icon: Icon(
                            favItems.containsKey(id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                          )),
                    ),
                    Positioned(
                      width: MediaQuery.of(context).size.width * 0.6,
                      top: height*0.275,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 6,right:9 ),
                            width: width*0.45,
                            child: Text(
                              name,
                              style: appstyleWithHeight(
                                  16, Colors.black, FontWeight.w600, 1.0),
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
      },
    );
  }
}
