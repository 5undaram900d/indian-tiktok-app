
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/Models/user.dart' as model;
import 'package:tiktok_clone/Views/Screens/Auth/login_screen.dart';
import 'package:tiktok_clone/Views/Screens/home_screen.dart';
import 'package:tiktok_clone/constants.dart';

class AuthController extends GetxController{

  static AuthController instance = Get.find();

  late Rx<User?> _user;

  late Rx<File?> _pickedImage;

  File? get profilePhoto => _pickedImage.value;

  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user){
    if(user == null) {
      Get.offAll(()=> LoginScreen());
    }
    else{
      Get.offAll(()=> const HomeScreen());
    }
  }

  /// Pick Image
  void pickImage() async{
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImage!=null) {
      Get.snackbar('Profile Picture', 'Successfully select your profile picture', backgroundColor: Colors.green.withOpacity(0.2), colorText: Colors.green, snackPosition: SnackPosition.BOTTOM,);
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  /// Upload to firebase storage
  Future<String> _uploadToStorage(File image) async{
    Reference ref = firebaseStorage.ref().child('profilePics').child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  /// Register the user
  void registerUser(String username, String email, String password, File? image) async{
    try{
      if(username.isNotEmpty && email.isNotEmpty && password.isNotEmpty && image!=null) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password,);
        String downloadUrl = await _uploadToStorage(image);
        model.User user = model.User(name: username, email: email, uid: cred.user!.uid, profilePhoto: downloadUrl,);
        await fireStore.collection('users').doc(cred.user!.uid).set(user.toJson());
      }
      else{
        Get.snackbar('Error', 'Please enter all fields', backgroundColor: Colors.red.withOpacity(0.2), colorText: Colors.red, snackPosition: SnackPosition.BOTTOM,);
      }
    } catch (e) {
      Get.snackbar('Error Creating Account', e.toString(), backgroundColor: Colors.red.withOpacity(0.2), colorText: Colors.red, snackPosition: SnackPosition.BOTTOM,);
    }
  }

  void loginUser(String email, String password) async{
    try{
      if(email.isNotEmpty && password.isNotEmpty){
        await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
        Get.snackbar('Success', 'you logged in successfully', backgroundColor: Colors.green.withOpacity(0.2), colorText: Colors.green, snackPosition: SnackPosition.BOTTOM,);
      }
      else {
        Get.snackbar('Error Login Account', "Please provide all field", backgroundColor: Colors.red.withOpacity(0.2), colorText: Colors.red, snackPosition: SnackPosition.BOTTOM,);
      }
    } catch (e) {
      Get.snackbar('Error Login Account', e.toString(), backgroundColor: Colors.red.withOpacity(0.2), colorText: Colors.red, snackPosition: SnackPosition.BOTTOM,);
    }
  }

  void signOut() async{
    await firebaseAuth.signOut();
  }

}