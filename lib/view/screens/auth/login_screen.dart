import 'package:flutter/material.dart';
import 'package:food_delivery_and_grocery/constants.dart';
import 'package:food_delivery_and_grocery/view/widgets/text_input.dart';
import 'package:get/get.dart';

import 'register_screen.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({
    Key? key,
  }) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login\nArea',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 0.0, height: 65),
            Container(
              width: Get.width,
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextInputField(
                controller: _emailController,
                labelText: 'E-Mail',
                icon: Icons.email,
              ),
            ),
            const SizedBox(width: 0.0, height: 25),
            Container(
              width: Get.width,
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextInputField(
                controller: _passwordController,
                labelText: 'Password',
                icon: Icons.password,
                isObscure: true,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: Get.width - 40,
              height: 50,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: InkWell(
                onTap: () {
                  authController.loginUser(
                      _emailController.text, _passwordController.text); 
                  print('Login Button Clicked');
                },
                child: const Center(
                  child: Text(
                    'LOGIN',
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Dont\'t have an account?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.offAll(() => SignUpScreen());
                    print('Register Button Clicked on Login Page');
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: buttonColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
