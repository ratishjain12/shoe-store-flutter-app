import 'package:flutter/material.dart';
import 'package:onlineshop_provider/controllers/favourites_provider.dart';
import 'package:provider/provider.dart';

import '../ui/individualshoes.dart';

class SearchPics extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Consumer<Favourites>(
      builder: (context, value, child) {
        Map<int, dynamic> favItems = value.items;
        return Stack(children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => IndividualShoe(
                            shoename: name,
                            price: price,
                            imgUrl: imgurl,
                            id: id,
                          )));
            },
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Image.network(imgurl),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              splashRadius: 1,
              color: const Color(0xffff8282),
              onPressed: () {
                value.addFavourties(
                    id: id, name: name, imgUrl: imgurl, price: price);
              },
              icon: Icon(favItems.containsKey(id)
                  ? Icons.favorite
                  : Icons.favorite_border),
            ),
          )
        ]);
      },
    );
  }
}
