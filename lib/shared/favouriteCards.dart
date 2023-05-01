
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:onlineshop_provider/controllers/favourites_provider.dart';
import 'package:onlineshop_provider/shared/appstyle.dart';

class FavouriteCard extends StatelessWidget {
  final int id;
  final String name;
  final String imgUrl;
  final int price;
  const FavouriteCard({
    Key? key,
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Favourites>(
      builder: (context, value, child) {
        Map<int, dynamic> favItems = value.items;
        return GestureDetector(
          onTap: () {},
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            margin: const EdgeInsets.symmetric(horizontal: 10),
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
                      width: MediaQuery.of(context).size.width * 0.85,
                      top: 256,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Text(
                              name,
                              style: appstyleWithHeight(
                                  16, Colors.black, FontWeight.w600, 1.3),
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
