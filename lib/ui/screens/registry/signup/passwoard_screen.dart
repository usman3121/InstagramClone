import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/ui/utils/message%20toaster/utils.dart';
import '../../../../config/router/app_routes.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../components/cutom_button.dart';
import '../controller/registration_controller.dart';


class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  bool _isChecked = false;
  final RegistrationAndLoginController controller =Get.put(RegistrationAndLoginController());

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
                "Create a password",
                style: TextStyle(fontSize: 30),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
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
              child: CustomTextFormField(
                name: 'password',controller: controller.passwordController,obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: CheckboxListTile(
                title: const Text(
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
                contentPadding: const EdgeInsets.all(0),
                activeColor: Colors.blue,
                tileColor: Colors.transparent,
                checkColor: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: CustomElevetedButton(
                label: 'Next',
                onPressed: () {
                  if (controller.passwordController.text.length < 6) {
                    Utils().toastMessage("Password must be at least 6 characters long");
                  } else {
                    controller.signUp();
                    Get.toNamed(AppRoutes.addPhoneEmail);
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
