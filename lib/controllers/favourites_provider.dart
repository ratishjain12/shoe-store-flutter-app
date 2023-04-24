// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// ignore: camel_case_types
class favouriteItem {
  final int id;
  final String name;
  final String imgUrl;
  final int price;

  favouriteItem({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.price,
  });
}

class Favourites extends ChangeNotifier {
  Map<int, favouriteItem> favouriteItems = {};
  bool favSelect = false;
  Map<int, favouriteItem> get items {
    return {...favouriteItems};
  }

  void addFavourties(
      {required int id,
      required String name,
      required String imgUrl,
      required int price}) {
    if (favouriteItems.containsKey(id)) {
      favouriteItems.remove(id);
      notifyListeners();
    } else {
      favouriteItems.putIfAbsent(
          id,
          () =>
              favouriteItem(id: id, name: name, imgUrl: imgUrl, price: price));
      notifyListeners();
    }
  }
}
