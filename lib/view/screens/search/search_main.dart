import 'package:flutter/material.dart';

class SearchMain extends StatelessWidget {
  const SearchMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search for something',
              prefixIcon: Icon(Icons.search),
              suffixIcon: Icon(Icons.mic),
              enabledBorder: InputBorder.none,
              focusColor: Colors.white,
              fillColor: Colors.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: const Center(child: Text('Search Page')),
        ),
      ),
    );
  }
}
