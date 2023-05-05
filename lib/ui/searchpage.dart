import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:onlineshop_provider/shared/appstyle.dart';
import 'package:onlineshop_provider/shared/searchpics.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List _items = [];

  @override
  void initState() {
    // TODO: implement initState
    loadJson();
    super.initState();
  }

  Future<void> loadJson() async {
    final String response = await rootBundle.loadString('assets/shoedata.json');
    final data = await jsonDecode(response);
    data['items'].forEach((element) {
      _items.add(element);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
            margin: EdgeInsets.only(
                top: height * 0.035,
                left: width * 0.03,
                right: width * 0.03,
                bottom: height * 0.01),
            height: height * 0.05,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.grey, blurRadius: 4, spreadRadius: 1)
              ],
            ),
            child: TextFormField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
          Expanded(
            child: MasonryGridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _items.length,
                gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return SearchPics(
                      imgurl: _items[index]['imageURL'],
                      id: _items[index]['id'],
                      name: _items[index]['name'],
                      price: _items[index]['price']);
                }),
          ),
        ],
      ),
    );
  }
}
