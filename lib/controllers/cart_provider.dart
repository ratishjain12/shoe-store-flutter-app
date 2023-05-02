import 'package:flutter/material.dart';

class cartItem {
  final int id;
  final String? category;
  final String name;
  final String imgUrl;
  final int price;
  final int qty;

  cartItem({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.price,
    required this.qty,
    this.category,
  });
}

class Cart extends ChangeNotifier {
  Map<int, cartItem> cartItems = {};

  Map<int, cartItem> get items {
    return {...cartItems};
  }

  void addToCart(
      {required int id,
      required String name,
      required String imgUrl,
      required int price,
      required String category}) {
    if (cartItems.containsKey(id)) {
      cartItems.update(
          id,
          (value) => cartItem(
              id: value.id,
              name: value.name,
              imgUrl: value.imgUrl,
              price: value.price,
              category: value.category,
              qty: value.qty + 1));
      notifyListeners();
    } else {
      cartItems.putIfAbsent(
          id,
          () => cartItem(
              id: id,
              name: name,
              imgUrl: imgUrl,
              price: price,
              qty: 1,
              category: category));
      notifyListeners();
    }
  }

  void decrementFromCart({required int id}) {
    cartItems.update(
        id,
        (value) => cartItem(
            id: value.id,
            name: value.name,
            imgUrl: value.imgUrl,
            price: value.price,
            qty: value.qty - 1));

    if (cartItems.containsKey(id)) {
      if (cartItems[id]!.qty == 0) {
        cartItems.remove(id);
      }
    }
    notifyListeners();
  }

  void incrementFromCart({required int id}) {
    cartItems.update(
        id,
        (value) => cartItem(
            id: value.id,
            name: value.name,
            imgUrl: value.imgUrl,
            price: value.price,
            qty: value.qty + 1));

    notifyListeners();
  }

  void deleteItem({required int id}) {
    cartItems.remove(id);
    notifyListeners();
  }

  double get totalPay {
    double amount = 0;
    cartItems.forEach((key, value) {
      amount += value.price * value.qty;
    });
    return amount;
  }
}
