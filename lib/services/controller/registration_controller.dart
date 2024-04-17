import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:instagram/ui/components/utils.dart';

import '../../ui/router/app_routes.dart';

class RegistrationController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    mobileController.dispose();
    usernameController.dispose();
    super.onClose();
  }

  Future<void> getCurrentUserEmail() async {
    String? currentEmail;
    User? user = auth.currentUser;
    if (user != null) {
     currentEmail = user.email;
    }
  }

  void login() {
    auth
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) {
      Utils().toastMessage(value.user!.email.toString());
      emailController.clear();
      passwordController.clear();
      Get.toNamed(App_Routes.HomePage);
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
    });
  }

  void signUp() {
    auth
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) {
      Utils().toastMessage('Sign-up successful!');
      Get.toNamed(App_Routes.HomePage);
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
    });
  }

  void isLogin() {
    auth.userChanges().listen((User? user) {
      if (user == null) {
        debugPrint('User is currently signed out!');
        Get.offNamed(App_Routes.signIn);
      } else {
        debugPrint('User is signed in!');
        Utils().toastMessage("User is signed in!");
        /*Get.offNamed(App_Routes.dashboard);*/
      }
    }, onError: (error, stackTrace) {
      Utils().toastMessage(error.toString());
    });
  }
}
