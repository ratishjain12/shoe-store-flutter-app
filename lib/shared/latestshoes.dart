// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:onlineshop_provider/ui/individualshoes.dart';
import 'package:provider/provider.dart';
import 'package:onlineshop_provider/controllers/favourites_provider.dart';

class LatestShoeCard extends StatelessWidget {
  final int id;
  final String name;
  final int price;
  final String imgUrl;
  final String category;
  const LatestShoeCard({
    Key? key,
    required this.id,
    required this.name,
    required this.price,
    required this.imgUrl,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<Favourites>(
      builder: ((context, value, child) {
        Map<int, dynamic> favItems = value.items;
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => IndividualShoe(
                        shoename: name,
                        price: price,
                        category: category,
                        imgUrl: imgUrl)));
          },
          child: Container(
            width: width * 0.5,
            margin: EdgeInsets.only(right: width * 0.025, left: width * 0.015),
            decoration: const BoxDecoration(
                color: Color(0xFFFAFAFA),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: height * 0.2,
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
                          color: const Color(0xFFFF8282),
                          splashRadius: 1,
                          onPressed: () {
                            value.addFavourties(
                                id: id,
                                name: name,
                                imgUrl: imgUrl,
                                price: price);
                          },
                          icon: Icon(favItems.containsKey(id)
                              ? Icons.favorite
                              : Icons.favorite_border)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
