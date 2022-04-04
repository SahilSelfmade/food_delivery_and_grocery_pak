import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_and_grocery/view/screens/Profile/profile_edit_screen.dart';
import 'package:get/get.dart';

class ProfileMainScreen extends StatefulWidget {
  const ProfileMainScreen({Key? key}) : super(key: key);

  @override
  State<ProfileMainScreen> createState() => _ProfileMainScreenState();
}

class _ProfileMainScreenState extends State<ProfileMainScreen> {
  late String email;
  late String name;
  late String profilePic;
  late String uid;

  fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((value) {
        name = value.data()!['name'];
        email = value.data()!['email'];
        profilePic = value.data()!['profilePhoto'];
        uid = value.data()!['uid'];
      });
    }
  }

  Container _ListTileProfilePage(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: ListTile(
        title: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        tileColor: const Color.fromARGB(255, 70, 70, 70),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Scaffold(
              body: SafeArea(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      // horizontal: 20,
                      vertical: 30,
                    ),
                    child: CircleAvatar(
                        radius: Get.width * 0.2,
                        backgroundImage: NetworkImage(
                          profilePic,
                        )),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        name.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 28),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Get.to(() => ProfileEditScreen(id: uid));
                        },
                        child: Container(
                          child: const Text(
                            'Edit Profile',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(),
                  const SizedBox(height: 50),
                  _ListTileProfilePage('Rating & Review'),
                  const SizedBox(height: 20),
                  _ListTileProfilePage('Help'),
                  const SizedBox(height: 20),
                  _ListTileProfilePage('Contact US'),
                ],
              )),
            );
          }
        });
  }
}
