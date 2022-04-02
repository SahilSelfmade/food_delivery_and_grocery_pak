import 'package:flutter/material.dart';
import 'package:food_delivery_and_grocery/constants.dart';
import 'package:food_delivery_and_grocery/view/screens/auth/login_screen_phone.dart';
import 'package:food_delivery_and_grocery/view/widgets/text_input.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'register_screen.dart';

class LoginScreenEMail extends StatelessWidget {
  LoginScreenEMail({
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
            Text(
              'Logo\nArea',
              textAlign: TextAlign.center,
              style: GoogleFonts.oswald(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 30.0)),
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
                    style:  TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 35,
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
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    Get.to(() => SignUpScreen());
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
            ),
            const SizedBox(height: 20),
            Text(
              'OR',
              style: TextStyle(
                color: buttonColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login using Phone Number?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    Get.to(() => LoginPagePhone());
                  },
                  child: Text(
                    'Login',
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
