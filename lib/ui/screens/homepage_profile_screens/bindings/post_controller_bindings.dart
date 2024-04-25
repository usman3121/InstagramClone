import 'package:get/get.dart';
import 'package:instagram/ui/screens/homepage_profile_screens/controller/post_controller.dart';
import '../controller/edit_profile_controller.dart';

class RegistrationAndLoginControllerBindings implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => PostController());
    Get.lazyPut(() => EditProfileController());
  }
}