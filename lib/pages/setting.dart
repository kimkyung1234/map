import 'package:flutter/material.dart';
import 'package:map/widgets/common.dart';
import 'package:map/widgets/set_home.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          flexibleText(
              text: 'Set Home',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(20)),
          SetHomeWidget(),
        ],
      ),
    );
  }
}
