import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../firebase_options.dart';
import '../../ui/screens/camera_screen/controller/image_controller.dart';
import '../../ui/screens/homepage_profile_screens/controller/post_controller.dart';

MediaController mediaController = Get.put(MediaController());
final PostController postController = Get.put(PostController());

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
      iosConfiguration: IosConfiguration(),
      androidConfiguration:
      AndroidConfiguration(onStart: onStartBackGround, isForegroundMode: true));
  await service.startService();await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

}

@pragma('vm:entry-point')
void onStartBackGround(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });
  bool isUploading = false;
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (service is AndroidServiceInstance) {
      if(await service.isForegroundService()){
        service.setForegroundNotificationInfo(title: "video is being uploading", content: "uploading");
      }
    }
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final prefs = await SharedPreferences.getInstance();
    final pickedVideoPath = prefs.getString('pickedVideoPath');
    print('background service is running ${pickedVideoPath}');
    if (pickedVideoPath != null&& !isUploading) {
      isUploading = true;

     await mediaController.uploadVideo(pickedVideoPath);
      print('background service is running');
     prefs.remove('pickedVideoPath');
      postController.addPost();
     mediaController.pickedVideoPath = null;
      isUploading = false;
      service.stopSelf();
    }
    service.invoke('update');
  });
}