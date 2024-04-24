import 'package:get/get.dart';

import '../../screens/bottom_navigation_screen.dart';
import '../../screens/registry/signIn/signin.dart';
import '../../screens/registry/signup/add_phone_email.dart';
import '../../screens/registry/signup/passwoard_screen.dart';
import '../../screens/registry/signup/sign_up.dart';
import 'app_routes.dart';


class GetAppRouter{

  List<GetPage> getRoutes()=> [

    GetPage(name: App_Routes.initial, page: () => const SignIn(),),
    GetPage(name: App_Routes.signUp, page: () => const SignUpUser(),),
    GetPage(name: App_Routes.signIn, page: () => const SignIn(),),
    GetPage(name: App_Routes.PasswordScreen, page: () => const PasswordScreen(),),
    GetPage(name: App_Routes.AddPhoneEmail, page: () => const AddPhoneEmail(),),
    GetPage(name: App_Routes.HomePage, page: () => const BottomNavigationScreen(),),


  ];
}