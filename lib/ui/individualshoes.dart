import 'package:flutter/material.dart';

import 'package:onlineshop_provider/controllers/cart_provider.dart';
import 'package:onlineshop_provider/controllers/favourites_provider.dart';
import 'package:onlineshop_provider/shared/appstyle.dart';

import 'package:onlineshop_provider/shared/toastmessage.dart';
import 'package:provider/provider.dart';

class IndividualShoe extends StatefulWidget {
  final int id;
  final String shoename;
  final int price;
  final String? category;
  final String imgUrl;

  const IndividualShoe(
      {super.key,
      required this.shoename,
      required this.price,
      this.category,
      required this.imgUrl,
      required this.id});

  @override
  State<IndividualShoe> createState() => _IndividualShoeState();
}

class _IndividualShoeState extends State<IndividualShoe> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final cart = Provider.of<Cart>(context, listen: false);
    context.watch<Cart>().getItem();
    context.watch<Favourites>().getItem();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 232, 232),
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            children: [
              Container(
                width: double.maxFinite,
                height: height * 0.460,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.all(Radius.circular(40)).copyWith(
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                  ),
                  image: DecorationImage(
                      image: NetworkImage(widget.imgUrl), fit: BoxFit.cover),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              Consumer<Favourites>(
                builder: (context, value, child) {
                  return Positioned(
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        if (value.favouriteKeys.contains(widget.id)) {
                          value.deleteItem(widget.id);
                        } else {
                          final data = FavouriteItem(
                            id: widget.id,
                            name: widget.shoename,
                            imgUrl: widget.imgUrl,
                            price: widget.price,
                          );

                          value.addItem(data, widget.id);
                        }
                      },
                      icon: value.favouriteKeys.contains(widget.id)
                          ? const Icon(
                              Icons.favorite,
                              color: Color(0xFFFF8282),
                            )
                          : const Icon(Icons.favorite_border),
                    ),
                  );
                },
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: height * 0.04),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.shoename,
                    style: appstyleWithHeight(
                        22, Colors.black, FontWeight.bold, 2),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Price:" + " \$${widget.price.toString()}",
                        style: appstyle(18, Colors.black, FontWeight.w600),
                      ),
                      Text(
                        "Category: " + "${widget.category}",
                        style: appstyle(18, Colors.black, FontWeight.w600),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GestureDetector(
              onTap: () {
                var itemFound = cart.inventoryList
                    .indexWhere((element) => element.id == widget.id);
                print(itemFound);
                if (itemFound != -1) {
                  final data = CartItem(
                      id: widget.id,
                      name: widget.shoename,
                      imgUrl: widget.imgUrl,
                      price: widget.price,
                      qty: cart.inventoryList[itemFound].qty + 1);
                  cart.updateItem(itemFound, data);
                } else if (itemFound == -1) {
                  final data = CartItem(
                      id: widget.id,
                      name: widget.shoename,
                      imgUrl: widget.imgUrl,
                      price: widget.price,
                      qty: 1);
                  cart.addItem(data);
                }

                // ignore: use_build_context_synchronously
                ToastMessage.showToast(
                    context, "Item added to cart!!", const Color(0xFFFF8282));
              },
              child: Container(
                margin: EdgeInsets.only(top: height * 0.19),
                width: double.infinity,
                height: 56,
                decoration: const BoxDecoration(
                    color: Color(0xFFFF8282),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.shopping_basket,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Add to cart",
                      style: appstyle(22, Colors.white, FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
