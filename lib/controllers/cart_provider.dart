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
  List _inventoryList = <CartItem>[];
  List get inventoryList => _inventoryList;

  // void addToCart(
  //     {required int id,
  //     required String name,
  //     required String imgUrl,
  //     required int price,
  //     required String category}) async {
  //   var cart = await Hive.openBox("cartBox");
  //   if (cartItems.containsKey(id)) {
  //     cartItems.update(
  //         id,
  //         (value) => CartItem(
  //             id: value.id,
  //             name: value.name,
  //             imgUrl: value.imgUrl,
  //             price: value.price,
  //             category: value.category,
  //             qty: value.qty + 1));

  //     cart.putAt(id, cartItems[id]);
  //     notifyListeners();
  //   } else {
  //     cartItems.putIfAbsent(
  //         id,
  //         () => CartItem(
  //             id: id,
  //             name: name,
  //             imgUrl: imgUrl,
  //             price: price,
  //             qty: 1,
  //             category: category));
  //     cart.put(id, cartItems[id]);
  //     notifyListeners();
  //   }
  // }

  addItem(CartItem item) async {
    var box = await Hive.openBox<CartItem>('inventory');

    box.add(item);

    notifyListeners();
  }

  getItem() async {
    final box = await Hive.openBox<CartItem>('inventory');

    _inventoryList = box.values.toList();

    notifyListeners();
  }

  updateItem(int index, CartItem inventory) {
    final box = Hive.box<CartItem>('inventory');

    box.putAt(index, inventory);

    notifyListeners();
  }

  deleteItem(int index) {
    final box = Hive.box<CartItem>('inventory');

    box.deleteAt(index);

    getItem();
    notifyListeners();
  }

  double get totalPay {
    double amount = 0;
    inventoryList.forEach((element) {
      amount += element.price * element.qty;
    });
    return amount;
  }
}
