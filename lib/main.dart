import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/services/controller/router_controller.dart';
import 'package:instagram/ui/components/bottom_navigation_bar.dart';
import 'package:instagram/ui/router/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      //darkTheme: ThemeData.dark(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        textTheme: Typography.dense2014,
       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: GetAppRouter().getRoutes(),
      initialRoute: App_Routes.initial,
      initialBinding: BindingsBuilder(() {
        Get.put(BottomNavBarController());
      }),
    );
  }
}

