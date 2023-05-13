import 'package:flutter/material.dart';
import 'package:onlineshop_provider/shared/toastmessage.dart';

import 'package:provider/provider.dart';

import 'package:onlineshop_provider/controllers/favourites_provider.dart';
import 'package:onlineshop_provider/shared/appstyle.dart';

import '../ui/individualshoes.dart';

class ShoeCard extends StatefulWidget {
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
    required this.price,
    required this.category,
  }) : super(key: key);

  @override
  State<ShoeCard> createState() => _ShoeCardState();
}

class _ShoeCardState extends State<ShoeCard> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<Favourites>(
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => IndividualShoe(
                          shoename: widget.name,
                          price: widget.price,
                          category: widget.category,
                          imgUrl: widget.imgUrl,
                          id: widget.id,
                        )));
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            margin: const EdgeInsets.only(right: 10, left: 5),
            decoration: const BoxDecoration(
                color: Color(0xFFFAFAFA),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: height * 0.34,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.imgUrl)),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Consumer<Favourites>(
                        builder: ((context, value, child) {
                          return IconButton(
                            onPressed: () {
                              if (value.favouriteKeys.contains(widget.id)) {
                                value.deleteItem(widget.id);
                              } else {
                                final data = FavouriteItem(
                                  id: widget.id,
                                  name: widget.name,
                                  imgUrl: widget.imgUrl,
                                  price: widget.price,
                                );
                                value.addItem(data, widget.id);
                              }
                            },
                            icon: value.favouriteKeys.contains(widget.id)
                                ? const Icon(
                                    Icons.favorite,
                                    color: Color(0xFFFF8282),
                                  )
                                : const Icon(Icons.favorite_border),
                          );
                        }),
                      ),
                    ),
                    Positioned(
                      width: MediaQuery.of(context).size.width * 0.6,
                      top: height * 0.275,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 6, right: 9),
                            width: width * 0.45,
                            child: Text(
                              widget.name,
                              style: appstyleWithHeight(
                                  16, Colors.black, FontWeight.w600, 1.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              "\$${widget.price.toString()}",
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
