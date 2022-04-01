import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_delivery_and_grocery/constants.dart';
import 'package:food_delivery_and_grocery/view/screens/auth/login_screen.dart';
import 'package:food_delivery_and_grocery/view/screens/auth/register_screen.dart';
import 'package:food_delivery_and_grocery/view/screens/home_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:food_delivery_and_grocery/model/user.dart' as model;

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  //Pick Image
  late Rx<File?> _pickedImage;

  late Rx<User?> _user;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  File? get profilePhoto => _pickedImage.value;

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar(
          'Profile Picture', 'You have successfully selct profile picture');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

// Registering the User
  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        //Save User to our Database
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        String downloadUrl = await _uploadToStorage(image);
        model.User user = model.User(
          name: username,
          profilePhoto: downloadUrl,
          email: email,
          uid: cred.user!.uid,
        );
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar('Error', 'Please enter all the Fields');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
      );
    }
  }

  //Login User
  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        print('Login Successfully');
      } else {
        Get.snackbar('Error Logging In', 'Please fill all Fields');
      }
    } catch (e) {
      Get.snackbar(
        'Error Logging In',
        e.toString(),
      );
    }
  }

// Upload Image to Firebase Storage
  Future<String> _uploadToStorage(File image) async {
    // Upload Location
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);
// Upload Task
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    // Getting Download URL
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }
}
