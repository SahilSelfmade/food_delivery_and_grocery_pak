import 'package:flutter/material.dart';

class SplashScreenMain extends StatelessWidget {
  const SplashScreenMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Image.asset('assets/food4.jpeg'),
          CircularProgressIndicator(),
        ],
      )),
    );
  }
}
