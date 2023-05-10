import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'cart_provider.g.dart';

@HiveType(typeId: 0)
class CartItem {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String? category;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String imgUrl;

  @HiveField(4)
  final int price;

  @HiveField(5)
  final int qty;

  CartItem({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.price,
    required this.qty,
    this.category,
  });
}

class Cart extends ChangeNotifier {
  Map<int, CartItem> cartItems = {};

  Map<int, CartItem> get items {
    return {...cartItems};
  }

  void addToCart(
      {required int id,
      required String name,
      required String imgUrl,
      required int price,
      required String category}) async {
    var cart = await Hive.openBox("cartBox");
    if (cartItems.containsKey(id)) {
      cartItems.update(
          id,
          (value) => CartItem(
              id: value.id,
              name: value.name,
              imgUrl: value.imgUrl,
              price: value.price,
              category: value.category,
              qty: value.qty + 1));

      cart.putAt(id, cartItems[id]);
      notifyListeners();
    } else {
      cartItems.putIfAbsent(
          id,
          () => CartItem(
              id: id,
              name: name,
              imgUrl: imgUrl,
              price: price,
              qty: 1,
              category: category));
      cart.put(id, cartItems[id]);
      notifyListeners();
    }
  }

  void decrementFromCart({required int id}) async {
    var cart = await Hive.openBox("cartBox");
    cartItems.update(id, (value) {
      return CartItem(
          id: value.id,
          name: value.name,
          imgUrl: value.imgUrl,
          price: value.price,
          qty: value.qty - 1);
    });

    if (cartItems.containsKey(id)) {
      if (cartItems[id]!.qty == 0) {
        cartItems.remove(id);
        cart.delete(id);
      } else {
        cart.putAt(id, cartItems);
      }
    }
    notifyListeners();
  }

  void incrementFromCart({required int id}) async {
    var cart = await Hive.openBox("cartBox");
    cartItems.update(
        id,
        (value) => CartItem(
            id: value.id,
            name: value.name,
            imgUrl: value.imgUrl,
            price: value.price,
            qty: value.qty + 1));
    cart.putAt(id, cartItems);
    notifyListeners();
  }

  void deleteItem({required int id}) async {
    var cart = await Hive.openBox("cartBox");
    cart.delete(id);
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
