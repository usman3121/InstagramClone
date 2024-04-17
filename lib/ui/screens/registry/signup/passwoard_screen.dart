import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:instagram/ui/components/utils.dart';
import 'package:instagram/ui/router/app_routes.dart';
import 'package:instagram/ui/screens/registry/signup/add_phone_email.dart';
import '../../../../services/controller/registration_controller.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../components/cutom_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  bool _isChecked = false;
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
                "Create a password",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 40,
                right: 40,
                top: 8,
              ),
              child: Text(
                "For security, your password must be six\n                  characters or more",
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 20, left: 20, bottom: 1, top: 10),
              child: Custom_Text_Form_Field(
                name: 'password',controller: controller.passwordController,obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: CheckboxListTile(
                title: Text(
                  'Remember password',
                  style: TextStyle(color: Colors.white), // Text color
                ),
                value: _isChecked,
                onChanged: (newValue) {
                  setState(() {
                    _isChecked = newValue!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.all(0),
                activeColor: Colors.blue,
                tileColor: Colors.transparent,
                checkColor: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Custom_Eleveted_Button(
                label: 'Next',
                onPressed: () {
                  if (controller.passwordController.text.length < 6) {
                    Utils().toastMessage("Password must be at least 6 characters long");
                  } else {
                    controller.signUp();
                    Get.toNamed(App_Routes.AddPhoneEmail);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
