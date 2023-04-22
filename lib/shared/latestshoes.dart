import 'package:flutter/material.dart';
import 'package:onlineshop_provider/shared/appstyle.dart';

class LatestShoeCard extends StatefulWidget {
  const LatestShoeCard({super.key});

  @override
  State<LatestShoeCard> createState() => _LatestShoeCardState();
}

class _LatestShoeCardState extends State<LatestShoeCard> {
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
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/99a7d3cb-e40c-4474-91c2-0f2e6d231fd2/joyride-run-flyknit-womens-running-shoe-HcfnJd.jpg')),
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
