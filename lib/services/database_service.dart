import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onlineshop_provider/controllers/cart_provider.dart';
import 'package:provider/provider.dart';

class DatabaseService {
  CollectionReference orderItems =
      FirebaseFirestore.instance.collection("orderItems");
  CollectionReference cartItems =
      FirebaseFirestore.instance.collection("cartItems");

  Future addToDatabase(String userid, BuildContext context) async {
    final cart = Provider.of<Cart>(context, listen: false);
    Map<String, dynamic> map = {};
    for (var item in cart.inventoryList) {
      map.putIfAbsent(
          item.id.toString(),
          () => {
                "id": item.id,
                "name": item.name,
                "imgUrl": item.imgUrl,
                "category": item.category,
                "price": item.price,
                "quantity": item.qty,
              });
    }
    print(map);
    await orderItems
        .doc(userid)
        .set({"items": FieldValue.arrayUnion(map.values.toList())});
  }

  Future addToCartItems(String userid, CartItem item) async {
    Map<String, dynamic> map = {
      "userid": userid,
      "id": item.id,
      "name": item.name,
      "price": item.price,
      "qty": item.qty,
      "category": item.category
    };
    QuerySnapshot sp = await cartItems.get();
    bool found = false;
    String docid = "";
    for (var docs in sp.docs) {
      if (docs["id"] == item.id) {
        docid = docs.id;
        found = true;
        break;
      }
    }
    if (found) {
      await cartItems.doc(docid).update(map);
    } else {
      await cartItems.add(map);
    }
  }
}
