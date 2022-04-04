import 'package:flutter/material.dart';
import 'package:food_delivery_and_grocery/constants.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final bool isObscure;
  final IconData? icon;
  final Function(String)? onChanged;
  const TextInputField({
    Key? key,
    this.onChanged,
    this.controller,
    this.labelText,
    this.isObscure = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        labelStyle: const TextStyle(
          fontSize: 20,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: borderColor,
            )),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
      ),
      obscureText: isObscure,
    );
  }
}
