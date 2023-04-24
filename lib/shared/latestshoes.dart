// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:onlineshop_provider/shared/appstyle.dart';

class LatestShoeCard extends StatelessWidget {
  final String imgUrl;
  const LatestShoeCard({
    Key? key,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        // color: Color.fromARGB(255, 242, 234, 234),
        decoration: const BoxDecoration(
            color: Color(0xFFFAFAFA),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(imgUrl)),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_outline)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
