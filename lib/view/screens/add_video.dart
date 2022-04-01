import 'package:flutter/material.dart';
import 'package:food_delivery_and_grocery/constants.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {},
          child: Container(
            height: 50,
            width: 190,
            decoration: BoxDecoration(color: buttonColor),
            child: Center(
              child: Text(
                'Add Video',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
