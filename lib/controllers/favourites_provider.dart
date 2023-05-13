// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'favourites_provider.g.dart';

@HiveType(typeId: 1)
class FavouriteItem {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String imgUrl;

  @HiveField(3)
  final int price;

  FavouriteItem({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.price,
  });
}

class Favourites extends ChangeNotifier {
  List _FavouriteList = <FavouriteItem>[];
  List _FavouriteKeys = [];
  List get favouriteList => _FavouriteList;
  List get favouriteKeys => _FavouriteKeys;
  addItem(FavouriteItem item, int index) async {
    var box = await Hive.openBox<FavouriteItem>('favourites');

    box.put(index, item);

    notifyListeners();
  }

  getItem() async {
    final box = await Hive.openBox<FavouriteItem>('favourites');

    _FavouriteList = box.values.toList();
    _FavouriteKeys = box.keys.toList();
    notifyListeners();
  }

  deleteItem(int index) {
    final box = Hive.box<FavouriteItem>('favourites');

    box.delete(index);
    getItem();
    notifyListeners();
  }
}
