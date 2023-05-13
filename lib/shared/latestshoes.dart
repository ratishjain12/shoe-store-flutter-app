// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:onlineshop_provider/ui/individualshoes.dart';
import 'package:provider/provider.dart';
import 'package:onlineshop_provider/controllers/favourites_provider.dart';

class LatestShoeCard extends StatefulWidget {
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
  State<LatestShoeCard> createState() => _LatestShoeCardState();
}

class _LatestShoeCardState extends State<LatestShoeCard> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<Favourites>(
      builder: ((context, value, child) {
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
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.imgUrl)),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        splashRadius: 1,
                        onPressed: () {
                          if (value.favouriteKeys.contains(widget.id)) {
                            value.deleteItem(widget.id);
                            print("item deleted");
                          } else {
                            final data = FavouriteItem(
                              id: widget.id,
                              name: widget.name,
                              imgUrl: widget.imgUrl,
                              price: widget.price,
                            );
                            value.addItem(data, widget.id);
                            print("item added");
                          }
                        },
                        icon: value.favouriteKeys.contains(widget.id)
                            ? const Icon(
                                Icons.favorite,
                                color: Color(0xFFFF8282),
                              )
                            : const Icon(Icons.favorite_border),
                      ),
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
