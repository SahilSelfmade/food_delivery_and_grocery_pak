// ignore_for_file: avoid_print

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_and_grocery/constants.dart';
import 'package:food_delivery_and_grocery/controller/auth_controller.dart';
import 'package:food_delivery_and_grocery/view/screens/auth/register_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginPagePhone extends StatefulWidget {
  LoginPagePhone({Key? key}) : super(key: key);
  final phoneOTPController = AuthController();

  @override
  _LoginPagePhoneState createState() => _LoginPagePhoneState();
}

class _LoginPagePhoneState extends State<LoginPagePhone> {
  late String phoneNumber, verificationId;
  late String otp, authStatus = "";

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');

  Future<void> verifyPhoneNumber(BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 15),
      verificationCompleted: (AuthCredential authCredential) {
        setState(() {
          authStatus = "Your account is successfully verified";
        });
      },
      verificationFailed: (FirebaseAuthException authException) {
        print(authException);
        setState(() {
          authStatus = "Authentication failed";
        });
      },
      codeSent: (String verId, [int? forceCodeResent]) {
        verificationId = verId;
        setState(() {
          authStatus = "OTP has been successfully send";
        });
        otpDialogBox(context).then((value) {});
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
        setState(() {
          authStatus = "TIMEOUT";
        });
      },
    );
  }

  otpDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Enter your OTP'),
            children: [
              PinFieldAutoFill(
                  onCodeSubmitted: (value) {
                    Navigator.of(context).pop();
                    signIn(value);
                  }, //code submitted callback
                  onCodeChanged: (value) {
                    otp = value!;
                  }, //code changed callback
                  codeLength: 6),
              /*Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    otp = value;
                  },
                ),
              ),*/
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  signIn(otp);
                },
                child: const Text(
                  'Submit',
                ),
              ),
            ],
            contentPadding: const EdgeInsets.all(10.0),
          );
        });
  }

  Future<void> signIn(String otp) async {
    await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Logo\nArea",
              textAlign: TextAlign.center,
              style: GoogleFonts.oswald(
                  textStyle:const  TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 30.0)),
            ),
            /* SizedBox(
              width: 200,
              child: Image.asset(
                "assets/images/logo.png",
              ),
            ),*/
            const SizedBox(
              height: 100.0,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: Color.fromARGB(255, 64, 64, 64),
                ),
                child: InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    print(number);
                    phoneNumber = number.toString();
                  },
                  onInputValidated: (bool value) {
                    print(value);
                  },
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.DROPDOWN,
                  ),
                  ignoreBlank: false,
                  searchBoxDecoration:
                      const InputDecoration(fillColor: Colors.white),
                  autoValidateMode: AutovalidateMode.disabled,
                  selectorTextStyle:const  TextStyle(
                    color: Colors.white,
                  ),
                  initialValue: number,
                  textFieldController: controller,
                  formatInput: false,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  onSaved: (PhoneNumber number) {
                    print('On Saved: $number');
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: MaterialButton(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                minWidth: MediaQuery.of(context).size.width,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                onPressed: () async {
                  if (phoneNumber != null) {
                    verifyPhoneNumber(context);
                    await SmsAutoFill().listenForCode();
                  }
                },
                child: Text(
                  "Send OTP",
                  style: GoogleFonts.openSans(
                      textStyle:
                          const TextStyle(fontSize: 18.0, color: Colors.white)),
                ),
                elevation: 5.0,
                color: buttonColor,
              ),
            ),
            Text(
              authStatus == "" ? "" : authStatus,
              style: TextStyle(
                  color: authStatus.contains("fail") ||
                          authStatus.contains("TIMEOUT")
                      ? Colors.red
                      : Colors.green),
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account?',
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
          ],
        ),
      ),
    );
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'IN');

    setState(() {
      this.number = number;
    });
  }
}

