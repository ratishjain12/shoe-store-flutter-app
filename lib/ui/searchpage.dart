import 'dart:convert';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:onlineshop_provider/shared/searchpics.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List _items = [];
  List _foundItems = [];

  TextEditingController searchText = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    loadJson();
    _foundItems = _items;
    super.initState();
  }

  void _runFilter(String keyWord) {
    List results = [];
    if (keyWord.isEmpty) {
      results = _items;
    } else {
      results = _items
          .where((element) =>
              element["name"].toLowerCase().contains(keyWord.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundItems = results;
    });
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
  void dispose() {
    // TODO: implement dispose
    searchText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: AnimSearchBar(
                rtl: true,
                width: 400,
                textController: searchText,
                onSuffixTap: () {},
                onSubmitted: (val) => _runFilter(val),
              ),
            ),
            Expanded(
              child: MasonryGridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _foundItems.length,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return SearchPics(
                        imgurl: _foundItems[index]['imageURL'],
                        id: _foundItems[index]['id'],
                        name: _foundItems[index]['name'],
                        price: _foundItems[index]['price']);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
