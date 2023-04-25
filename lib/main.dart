import 'package:flutter/material.dart';
import 'package:onlineshop_provider/controllers/favourites_provider.dart';
import 'package:onlineshop_provider/controllers/mainscreen_provider.dart';
import 'package:onlineshop_provider/ui/mainscreen.dart';
import 'package:onlineshop_provider/ui/oboardingpage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MainScreenNotifier()),
    ChangeNotifierProvider(create: (context) => Favourites()),
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
      home: OnboardingPage(),
    );
  }
}
