import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/ui/screens/homepage_profile_screens/controller/post_controller.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../components/cutom_button.dart';
import '../../../config/router/app_routes.dart';
import '../controller/registration_controller.dart';

class SignUpUser extends StatefulWidget {
  const SignUpUser({super.key});

  @override
  State<SignUpUser> createState() => _SignUpUserState();
}

class _SignUpUserState extends State<SignUpUser> {
  final RegistrationAndLoginController controller =Get.put(RegistrationAndLoginController());
  final PostController userController = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Choose username",
                style: TextStyle(fontSize: 30),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "You can always change it later",
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20,bottom: 10,top: 10),
              child: Custom_Text_Form_Field(name: 'Username',controller: controller.usernameController.value,),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Custom_Eleveted_Button(
                label: 'Next',
                onPressed: () {
                  userController.addUserData();
                  Get.toNamed(App_Routes.PasswordScreen);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}


