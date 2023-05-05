import 'package:flutter/material.dart';
import 'package:onlineshop_provider/controllers/favourites_provider.dart';
import 'package:provider/provider.dart';

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
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(2),
              child: Image.network(imgurl),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              splashRadius: 1,
              color: Color(0xffff8282),
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
