import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram/ui/screens/registry/controller/registration_controller.dart';
import '../../../../config/router/app_routes.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../components/cutom_button.dart';
import '../../homepage_profile_screens/controller/post_controller.dart';



class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final RegistrationAndLoginController controller = Get.put(RegistrationAndLoginController());
  final PostController postController = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.15,
              ),
              SizedBox(
                height: Get.height * 0.15,
                child: Text('Instagram',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 50,
                      color: Colors.white,
                      fontFamily: GoogleFonts.oleoScript().fontFamily,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, bottom: 10, top: 10),
                child: CustomTextFormField(
                  controller: controller.emailController,
                  name: 'Username or email',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, bottom: 10, top: 10),
                child: CustomTextFormField(
                  controller: controller.passwordController,
                  name: 'password',obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, bottom: 10, top: 10),
                child: CustomElevetedButton(
                  label: 'Log In',
                  onPressed: () {
                   // postController.getPosts();
                    controller.login();

                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Forgotten your login details?",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Get Help with logging in.",
                          style: TextStyle(fontSize: 13, color: Colors.blue),
                        )),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 20, left: 20, top: 10),
                child: Row(
                  children: [
                    Expanded(
                        child: Divider(
                      height: 1,
                    )),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "OR",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Expanded(
                        child: Divider(
                      height: 1,
                    )),
                  ],
                ),
              ),
              Padding(
                padding:  const EdgeInsets.only(right: 20, left: 20, top: 10,bottom: 120),
                child: CustomElevetedButton(onPressed :(){} ,label:'Continue as ...' ,),
              ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account",
                  style: TextStyle(fontSize: 12, color: Colors.white)),
              TextButton(
                  onPressed: () {
                  Get.toNamed(AppRoutes.signUp);
                    },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 15, color: Colors.blue),
                  )),
        
            ],
          ),
        ]),
            ),
      ));
  }
}
