import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:instagram/services/authentication/firebaseservices.dart';
import '../../ui/screens/camera_screen/controller/image_controller.dart';
import '../../ui/screens/registry/controller/registration_controller.dart';
import '../../ui/utils/message toaster/utils.dart';
import '../model/user_model.dart';

class UserServices extends GetxController{

  RxList<UserModel> userData = <UserModel>[].obs;
  final RegistrationAndLoginController controller = Get.put(RegistrationAndLoginController());
  final MediaController imageController =
  Get.put(MediaController());
  final FirebaseServices firebaseServices =Get.put(FirebaseServices());
  var userName =''.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  //RxString userId = ''.obs;
  Stream<List<UserModel>> fetchUser() {
    try {
      return firebaseServices.userDataCollection().snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>)).toList());
    } catch (e) {
      Utils().toastMessage(e.toString());
      rethrow;
    }
  }

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
        userData.add(usermodel);
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
    Map<dynamic,dynamic> data = {};
    try {
      QuerySnapshot snapshot = await firebaseServices.userDataCollection().get();
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        UserModel usermodel = UserModel.fromJson(data);
        userData.add(usermodel);

      }

        userName.value =userData.last.userName.toString();

    } catch (e) {
      Utils().toastMessage(e.toString());
    }
    return userData;
  }

  Future<UserModel?> getUserById(String userId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
      await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        return UserModel.fromJson(userDoc.data()!);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }
}