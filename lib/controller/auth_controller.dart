import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_delivery_and_grocery/constants.dart';
import 'package:food_delivery_and_grocery/view/screens/auth/login_screen_email.dart';
import 'package:food_delivery_and_grocery/view/screens/home_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:food_delivery_and_grocery/model/user.dart' as model;

class AuthController extends GetxController {
  static AuthController instance = Get.find();
// PHONE VERIFICATION
  var isLoading = false.obs;
  var authStatus = "".obs;
  late String phoneNumber, verificationID;

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

//  Register USer using Phone
  verifyPhone(String phone) async {
    await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(
          seconds: 15,
        ),
        verificationCompleted: (PhoneAuthCredential authCredeintial) {
          if (firebaseAuth.currentUser != null) {
            isLoading.value = false;
            print(authCredeintial);
            authStatus.value = authCredeintial.toString();
          }
        },
        verificationFailed: (FirebaseAuthException authException) {
          Get.snackbar('SMS Code Info', authException.toString());
        },
        codeSent: (String id, [int? resendToken]) {
          isLoading.value = false;
          verificationID = id;
          // print(verificationId);
          authStatus.value = 'Login Success';
        },
        codeAutoRetrievalTimeout: (String id) {
          verificationID = id;
        });
  }

// Verify Phone OTP
  verifyOTP(String otp) async {
    isLoading.value = true;
    try {
      var phoneCred =
          await firebaseAuth.signInWithCredential(PhoneAuthProvider.credential(
        verificationId: verificationID,
        smsCode: otp,
      ));
      if (phoneCred.user != null) {
        isLoading.value = false;
        Get.offAll(() => const HomeScreen());
      }
    } on Exception catch (e) {
      Get.snackbar(
        'OTP INFO',
        e.toString(),
      );
    }
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
      Get.offAll(
        () => LoginScreenEMail(),
      );
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }
}
