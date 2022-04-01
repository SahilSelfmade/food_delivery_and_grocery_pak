import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery_and_grocery/constants.dart';
import 'package:food_delivery_and_grocery/view/screens/auth/login_screen.dart';
import 'package:food_delivery_and_grocery/view/widgets/text_input.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({
    Key? key,
  }) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 0.0, height: 65),
              Text(
                'Logo\nArea',
                style: TextStyle(
                  fontSize: 45,
                  color: buttonColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 0.0, height: 65),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundColor: Colors.black,
                    backgroundImage: NetworkImage(
                        'https://source.unsplash.com/1600x900/?coding,programmer'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        authController.pickImage();
                        print('Icon Button Pressed');
                      },
                      icon: Icon(
                        Icons.add_a_photo,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 0.0, height: 25),
              Container(
                width: Get.width,
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: TextInputField(
                  controller: _usernameController,
                  labelText: 'Username',
                  icon: Icons.people,
                ),
              ),
              const SizedBox(width: 0.0, height: 25),
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
                    authController.registerUser(
                      _usernameController.text,
                      _emailController.text,
                      _passwordController.text,
                      authController.profilePhoto,
                    ); 
                    print('Register Button Clicked');
                  },
                  child: Center(
                    child: Text(
                      'Register'.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
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
                  Text(
                    'Already have an account?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.offAll(() => LoginScreen());
                      print('Login Button Clicked on Register Page');
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
      ),
    );
  }
}
