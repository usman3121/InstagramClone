
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:instagram/services/authentication/firebaseservices.dart';
import 'package:uuid/uuid.dart';

import '../../ui/screens/camera_screen/controller/imageController.dart';
import '../../ui/screens/registry/controller/registration_controller.dart';
import '../../ui/utils/message toaster/utils.dart';
import '../model/user_model.dart';

class UserServices extends GetxController{
  //User Methods:
  RxList<UserModel> userData = <UserModel>[].obs;
  final RegistrationAndLoginController controller = Get.put(RegistrationAndLoginController());
  final ImagePickerController imageController =
  Get.put(ImagePickerController());
  final FirebaseServices firebaseServices =Get.put(FirebaseServices());

  //RxString userId = ''.obs;

  Future<void> addUserData() async {
    try {
      /*var uuid = const Uuid();
      userId.value = uuid.v1();*/
      String? profileImagePath = imageController.imageUrl;
      if (profileImagePath.isNotEmpty) {
        UserModel usermodel = UserModel(
          bio: controller.bioController.value.text,
          followers: 30,
          following: 20,
          profileImagePath: imageController.imageUrl,
          userName: controller.usernameController.value.text,
          totalPost: 1,
          comment: [controller.commentController.text],
          userId: firebaseServices.getCurrentUserID().toString(),
        );
        userData?.add(usermodel);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseServices.getCurrentUserID().toString())
            .set(usermodel.toJson());
      }
    } catch (e) {
      if (e is FirebaseException) {
      } else {}
      Utils().toastMessage(e.toString());
    }
  }

  Future<RxList<UserModel>> getUserData() async {
    RxList<UserModel> userData = <UserModel>[].obs;
    try {
      QuerySnapshot snapshot = await firebaseServices.userDataCollection().get();
      snapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        UserModel usermodel = UserModel.fromJson(data);
        userData.add(usermodel);
      });
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
    return userData;
  }

}