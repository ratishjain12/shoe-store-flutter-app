import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:onlineshop_provider/services/database_service.dart';
import 'package:onlineshop_provider/shared/appstyle.dart';
import 'package:onlineshop_provider/shared/toastmessage.dart';
import 'package:onlineshop_provider/ui/individualshoes.dart';
import 'package:onlineshop_provider/utils/appconstants.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import '../controllers/cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Map<String, dynamic>? paymentIntent;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<Cart>().getItem();
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
          return value.inventoryList.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      child: Image(
                          image: AssetImage("assets/images/cart-icon.png")),
                    ),
                    Center(
                      child: Text(
                        "No items in Cart",
                        style: appstyle(30, Colors.black, FontWeight.w600),
                      ),
                    )
                  ],
                )
              : Column(
                  children: [
                    Container(
                      height: height * 0.65,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          CartItem inv = value.inventoryList[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => IndividualShoe(
                                          shoename: inv.name,
                                          price: inv.price,
                                          category: inv.category,
                                          imgUrl: inv.imgUrl,
                                          id: inv.id)));
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 160.0,
                                    child: Image(
                                      image: NetworkImage(
                                        inv.imgUrl,
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: width * 0.5,
                                          child: Text(
                                            inv.name,
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
                                          "\$${inv.price.toString()}",
                                          style: appstyleWithHeight(
                                              20,
                                              Colors.black,
                                              FontWeight.w600,
                                              1.1),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Qty:  ${inv.qty.toString()}",
                                          style: appstyleWithHeight(
                                              20,
                                              Colors.black,
                                              FontWeight.w600,
                                              1.1),
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
                                                        MaterialStateProperty
                                                            .all(
                                                  const Color(0xFFFF8282),
                                                )),
                                                onPressed: () {
                                                  final data = CartItem(
                                                      id: inv.id,
                                                      name: inv.name,
                                                      imgUrl: inv.imgUrl,
                                                      price: inv.price,
                                                      qty: inv.qty + 1);
                                                  value.updateItem(index, data);
                                                },
                                                child: const Icon(Icons.add),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: width * 0.01),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  final data = CartItem(
                                                      id: inv.id,
                                                      name: inv.name,
                                                      imgUrl: inv.imgUrl,
                                                      price: inv.price,
                                                      qty: inv.qty - 1);
                                                  if (data.qty == 0) {
                                                    value.deleteItem(index);
                                                    return;
                                                  }
                                                  value.updateItem(index, data);
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
                                                value.deleteItem(index);
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
                            ),
                          );
                        },
                        itemCount: value.inventoryList.length,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                      padding: EdgeInsets.symmetric(vertical: height * 0.01),
                      width: double.maxFinite,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF8282),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Cart Total: \$${value.totalPay.toString()}",
                            style: appstyle(20, Colors.white, FontWeight.w600),
                          ),
                          MaterialButton(
                            onPressed: () async {
                              int price = value.totalPay.toInt();
                              makePayment(price.toString(), "INR");
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
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

  Future<void> makePayment(String amount, String currency) async {
    try {
      paymentIntent = await createPaymentIntent(amount, currency);

      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: "GB", currencyCode: "GBP", testEnv: true);

      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent!['client_secret'],
            style: ThemeMode.dark,
            googlePay: gpay,
            merchantDisplayName: "Ratish",
          ))
          .then((value) {});
      displayPaymentSheet();
    } on StripeException catch (e) {
      ToastMessage.showToast(context, e.toString(), const Color(0xFFFF8282));
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            "Authorization": 'Bearer $secretKey',
            "Content-Type": "application/x-www-form-urlencoded"
          });

      return jsonDecode(response.body);
    } catch (e) {
      ToastMessage.showToast(context, e.toString(), const Color(0xFFFF8282));
    }
  }

  calculateAmount(String amount) {
    final price = int.parse(amount) * 100;
    return price.toString();
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      setState(() {
        paymentIntent = {};
      });
      // ignore: use_build_context_synchronously
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await DatabaseService()
            .addToDatabase(FirebaseAuth.instance.currentUser!.uid, context);
      }
      ToastMessage.showToast(context, "Paid Successfully", Colors.green);
    } on StripeException catch (e) {
      ToastMessage.showToast(
          context, "Payment Cancelled!!", const Color(0xFFFF8282));
    }
  }
}
