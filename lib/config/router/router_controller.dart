import 'package:get/get.dart';


import '../../ui/screens/bottom_navigation_screen.dart';
import '../../ui/screens/registry/signIn/signin.dart';
import '../../ui/screens/registry/signup/add_phone_email.dart';
import '../../ui/screens/registry/signup/passwoard_screen.dart';
import '../../ui/screens/registry/signup/sign_up.dart';
import 'app_routes.dart';


class GetAppRouter{

  List<GetPage> getRoutes()=> [

    GetPage(name: AppRoutes.initial, page: () => const SignIn(),),
    GetPage(name: AppRoutes.signUp, page: () => const SignUpUser(),),
    GetPage(name: AppRoutes.signIn, page: () => const SignIn(),),
    GetPage(name: AppRoutes.passwordScreen, page: () => const PasswordScreen(),),
    GetPage(name: AppRoutes.addPhoneEmail, page: () => const AddPhoneEmail(),),
    GetPage(name: AppRoutes.homePage, page: () => const BottomNavigationScreen(),),


  ];
}