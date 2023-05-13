import 'package:flutter/material.dart';
import 'package:onlineshop_provider/controllers/favourites_provider.dart';
import 'package:provider/provider.dart';

import '../ui/individualshoes.dart';

class SearchPics extends StatefulWidget {
  String imgurl;
  int id;
  int price;
  String name;
  SearchPics(
      {Key? key,
      required this.imgurl,
      required this.id,
      required this.name,
      required this.price})
      : super(key: key);

  @override
  State<SearchPics> createState() => _SearchPicsState();
}

class _SearchPicsState extends State<SearchPics> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Favourites>(
      builder: (context, value, child) {
        return Stack(children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => IndividualShoe(
                            shoename: widget.name,
                            price: widget.price,
                            imgUrl: widget.imgurl,
                            id: widget.id,
                          )));
            },
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Image.network(widget.imgurl),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                if (value.favouriteKeys.contains(widget.id)) {
                  value.deleteItem(widget.id);
                } else {
                  final data = FavouriteItem(
                    id: widget.id,
                    name: widget.name,
                    imgUrl: widget.imgurl,
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
            ),
          )
        ]);
      },
    );
  }
}
