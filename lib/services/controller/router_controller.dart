import 'package:get/get.dart';

import '../../ui/router/app_routes.dart';
import '../../ui/screens/bottom_navigation_screen.dart';
import '../../ui/screens/registry/signIn/signin.dart';
import '../../ui/screens/registry/signup/add_phone_email.dart';
import '../../ui/screens/registry/signup/passwoard_screen.dart';
import '../../ui/screens/registry/signup/sign_up.dart';

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