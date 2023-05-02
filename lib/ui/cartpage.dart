import 'package:flutter/material.dart';
import 'package:onlineshop_provider/shared/appstyle.dart';
import 'package:provider/provider.dart';

import '../controllers/cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFFF8282),
        title: Text(
          "Cart",
          style: appstyle(22, Colors.white, FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Consumer<Cart>(
        builder: (context, value, child) {
          Map<int, dynamic> cartItems = value.items;
          return cartItems.isEmpty
              ? Center(
                  child: Text(
                    "No items in Cart",
                    style: appstyle(30, Colors.black, FontWeight.w600),
                  ),
                )
              : Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: height * 0.01),
                      height: height * 0.68,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          int key = cartItems.keys.elementAt(index);
                          return Card(
                            margin: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 160.0,
                                  child: Image(
                                    image: NetworkImage(
                                      cartItems[key].imgUrl,
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: width * 0.5,
                                        child: Text(
                                          cartItems[key].name,
                                          style: appstyleWithHeight(
                                              17,
                                              Colors.black,
                                              FontWeight.w600,
                                              1.0),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "\$${cartItems[key].price.toString()}",
                                        style: appstyleWithHeight(20,
                                            Colors.black, FontWeight.w600, 1.1),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Qty:  ${cartItems[key].qty.toString()}",
                                        style: appstyleWithHeight(20,
                                            Colors.black, FontWeight.w600, 1.1),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: width * 0.01),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: width * 0.01),
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                const Color(0xFFFF8282),
                                              )),
                                              onPressed: () {
                                                value.incrementFromCart(
                                                    id: key);
                                              },
                                              child: const Icon(Icons.add),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: width * 0.01),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                value.decrementFromCart(
                                                    id: key);
                                              },
                                              child: const Icon(Icons.remove),
                                            ),
                                          ),
                                          ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                              Colors.red,
                                            )),
                                            onPressed: () {
                                              value.deleteItem(id: key);
                                            },
                                            child: const Icon(Icons.delete),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: cartItems.length,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                      padding: EdgeInsets.symmetric(vertical: height * 0.01),
                      width: double.maxFinite,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF8282),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Cart Total: \$${value.totalPay.toString()}",
                            style: appstyle(20, Colors.white, FontWeight.w600),
                          ),
                          MaterialButton(
                            onPressed: () {},
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.2,
                                vertical: height * 0.01),
                            color: Colors.white,
                            child: Text(
                              "Checkout",
                              style:
                                  appstyle(18, Colors.black, FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
