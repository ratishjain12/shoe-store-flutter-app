import 'package:flutter/material.dart';
import 'package:onlineshop_provider/shared/appstyle.dart';
import 'package:provider/provider.dart';

import '../controllers/favourites_provider.dart';
import '../shared/favouriteCards.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    context.watch<Favourites>().getItem();
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFFFF8282),
          title: Text(
            "Favourite",
            style: appstyle(22, Colors.white, FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Consumer<Favourites>(
            builder: ((context, value, child) {
              return value.favouriteList.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                          child: Image(
                              image: AssetImage(
                                  "assets/images/favourite-icon.png")),
                        ),
                        Center(
                          child: Text(
                            "No items in favourite",
                            style: appstyle(30, Colors.black, FontWeight.w600),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: value.favouriteList.length,
                              itemBuilder: ((context, index) {
                                FavouriteItem fav = value.favouriteList[index];

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FavouriteCard(
                                      id: fav.id,
                                      name: fav.name,
                                      imgUrl: fav.imgUrl,
                                      price: fav.price),
                                );
                              })),
                        )
                      ],
                    );
            }),
          ),
        ));
  }
}
