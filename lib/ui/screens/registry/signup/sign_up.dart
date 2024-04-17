import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/ui/router/app_routes.dart';
import 'package:instagram/ui/screens/registry/signup/passwoard_screen.dart';
import '../../../../services/controller/registration_controller.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../components/cutom_button.dart';

class SignUpUser extends StatefulWidget {
  const SignUpUser({super.key});

  @override
  State<SignUpUser> createState() => _SignUpUserState();
}

class _SignUpUserState extends State<SignUpUser> {
  final RegistrationController controller =Get.put(RegistrationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Choose username",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "You can always change it later",
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20,bottom: 10,top: 10),
              child: Custom_Text_Form_Field(name: 'Username',controller: controller.usernameController,),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Custom_Eleveted_Button(
                label: 'Next',
                onPressed: () {
                  print("pressed");
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


