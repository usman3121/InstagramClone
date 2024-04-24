import 'package:get/get.dart';

import '../controller/imageController.dart';

class cameraBindings implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => ImagePickerController());
    }
}