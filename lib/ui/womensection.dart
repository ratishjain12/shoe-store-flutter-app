import 'package:flutter/material.dart';
import 'package:onlineshop_provider/shared/appstyle.dart';

class WomenSection extends StatelessWidget {
  const WomenSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Women's Shoes",
                  style: appstyle(24, Colors.black, FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
