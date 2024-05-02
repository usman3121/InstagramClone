import 'package:get/get.dart';

import '../controller/image_controller.dart';

class CameraBindings implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => MediaController());
    }
}