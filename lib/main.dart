import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:onlineshop_provider/controllers/cart_provider.dart';
import 'package:onlineshop_provider/controllers/favourites_provider.dart';
import 'package:onlineshop_provider/controllers/mainscreen_provider.dart';
import 'package:onlineshop_provider/ui/oboardingpage.dart';
import 'package:onlineshop_provider/utils/appconstants.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishableKey;
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MainScreenNotifier()),
    ChangeNotifierProvider(create: (context) => Favourites()),
    ChangeNotifierProvider(create: (context) => Cart()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online Shop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const OnboardingPage(),
    );
  }
}
