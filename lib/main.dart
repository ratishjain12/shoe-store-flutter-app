import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive/hive.dart';
import 'package:onlineshop_provider/controllers/cart_provider.dart';
import 'package:onlineshop_provider/controllers/favourites_provider.dart';
import 'package:onlineshop_provider/controllers/mainscreen_provider.dart';
import 'package:onlineshop_provider/controllers/onboarding_provider.dart';
import 'package:onlineshop_provider/ui/mainscreen.dart';

import 'package:onlineshop_provider/ui/oboardingpage.dart';
import 'package:onlineshop_provider/ui/obpages.dart';
import 'package:onlineshop_provider/utils/appconstants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter<CartItem>(CartItemAdapter());
  Stripe.publishableKey = publishableKey;
  var box = await Hive.openBox('onboarding');
  box.put('onboard', false);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MainScreenNotifier()),
    ChangeNotifierProvider(create: (context) => Favourites()),
    ChangeNotifierProvider(create: (context) => Cart()),
    ChangeNotifierProvider(create: (context) => Onboarding())
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool onboard = false;
  obFunction() async {
    var box = await Hive.openBox('onboarding');
    setState(() {
      onboard = box.get('onboard');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Online Shop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Consumer<Onboarding>(
          builder: (context, value, child) {
            // print(onboard.ob);
            obFunction();
            return onboard ? MainScreen() : OnboardingPage();
          },
        ));
  }
}
