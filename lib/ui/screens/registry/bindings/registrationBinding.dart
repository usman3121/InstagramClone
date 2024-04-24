import 'package:get/get.dart';
import 'package:instagram/ui/screens/registry/controller/registration_controller.dart';

class registrationAndLoginControllerBindings implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => RegistrationAndLoginController());
  }
}