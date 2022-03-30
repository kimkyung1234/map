import 'package:flutter/material.dart';
import 'package:map/widgets/common.dart';
import 'package:map/widgets/search_widget.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: const Padding(
          padding: EdgeInsets.only(left: 20),
          child: BackButton(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          flexibleText(
              text: 'Search',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              textColor: Colors.black,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(20)),
          SearchWidget(),
        ],
      ),
    );
  }
}
