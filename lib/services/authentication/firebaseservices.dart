import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../ui/screens/camera_screen/controller/image_controller.dart';
import '../../ui/screens/registry/controller/registration_controller.dart';


class FirebaseServices extends GetxController{

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxMap likedPostIds = {}.obs;
  final RegistrationAndLoginController controller = Get.put(RegistrationAndLoginController());
  final MediaController imageController =
  Get.put(MediaController());


  CollectionReference userPostCollection() {
    return firestore.collection('post');
  }

  CollectionReference userDataCollection() {
    return firestore
        .collection('users');
  }

  String? getCurrentUserID() {
    return auth.currentUser?.uid;
  }
}