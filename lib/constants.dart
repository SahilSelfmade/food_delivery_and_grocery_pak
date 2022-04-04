import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_and_grocery/view/screens/Profile/profile_screen.dart';
import 'package:food_delivery_and_grocery/view/screens/food/food_main.dart';
import 'package:food_delivery_and_grocery/view/screens/home/home.dart';
import 'controller/auth_controller.dart';
import 'view/screens/search/search_main.dart';

List pages = [
  const MainPage(),
  FoodMain(),
  const SearchMain(),
  ProfileMainScreen(),
  // VideoScreen(),
  // SearchScreen(),
  // Text('Messages Screen'),
  // ProfileScreen(uid: authController.user.uid),
];

// COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.green[400];
const borderColor = Colors.grey;

// FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

// CONTROLLER
var authController = AuthController.instance;
