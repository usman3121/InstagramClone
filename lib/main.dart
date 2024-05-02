import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:get/get.dart';
import 'package:instagram/services/background/backgroundservices.dart';
import 'package:instagram/ui/components/bottom_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:instagram/ui/screens/camera_screen/controller/image_controller.dart';
import 'package:workmanager/workmanager.dart';
import 'config/router/app_routes.dart';
import 'config/router/router_controller.dart';
import 'firebase_options.dart';



  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
/*    await initializeService();*/


    /*Workmanager().initialize(callbackDispatcher,isInDebugMode: true);*/

    runApp(const MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

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
        initialRoute: AppRoutes.initial,
        initialBinding: BindingsBuilder(() {
          Get.put(BottomNavBarController());
        }),
      );
    }


  }




























/*
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    switch (task) {
      case "uploadVideo":
        String videoPath = inputData!['videoPath'];
        String uniqueVideoId = inputData['uniqueVideoId'];
        MediaController().backgroundVideoUpload(videoPath, uniqueVideoId);
        break;
      default:
        print("Unknown task");
    }
    return Future.value(true);
  });
}
*/