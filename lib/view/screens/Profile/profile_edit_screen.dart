// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_and_grocery/view/screens/Profile/profile_screen.dart';
import 'package:food_delivery_and_grocery/view/widgets/text_input.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController email = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController name = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> updateUser(
    id,
    name,
    email,
  ) {
    return users
        .doc(id)
        .update({
          'name': name,
          'email': email,
        })
        .then(
          (value) => print("User Updated"),
        )
        .catchError(
          (onError) => print(onError),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Container(
            color: Colors.white,
            child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.id)
                  .get(),
              builder: (_, snapshot) {
                if (snapshot.hasError) {
                  print('Something went Wrong');
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var data = snapshot.data!.data();
                var _name = data!['name'];
                var _email = data['email'];

                _name.text = name.toString();
                _email.text = email.toString();

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Center(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          Center(
                            child: Text(
                              'Edit User Details',
                              style: GoogleFonts.oswald(
                                textStyle: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 48,
                          ),
                          TextInputField(
                            controller: name,
                            labelText: 'Full Name',
                            onChanged: (value) => _name = value,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          TextInputField(
                            controller: email,
                            labelText: 'E-Mail',
                            onChanged: (value) => _email = value,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          InkWell(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                  updateUser(
                                    widget.id,
                                    name,
                                    email,
                                  );
                                });
                                // print(updateUser);
                                Get.off;
                                Get.snackbar(
                                  'Success',
                                  'User Updated Successfully.',
                                  isDismissible: true,
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.5,
                                  backgroundColor: Colors.white,
                                  duration: const Duration(
                                    seconds: 2,
                                  ),
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                                // Get.to
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                              ),
                              decoration: ShapeDecoration(
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: Text(
                                'Update'.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          InkWell(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });

                                Get.off(const ProfileMainScreen());
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                              ),
                              decoration: ShapeDecoration(
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: Text(
                                'HOME'.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}
