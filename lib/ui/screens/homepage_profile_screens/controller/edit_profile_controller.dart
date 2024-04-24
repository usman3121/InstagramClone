import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../utils/message toaster/utils.dart';

class EditProfileController extends GetxController {
  var userName = ''.obs;
  var userId = ''.obs;
  var bio = ''.obs;
  Future<void> getUpdatedUserData(String userName, String userId, String bio) async {
    try {
      if (userId.isEmpty) {
        throw Exception('User ID cannot be empty');
      }
      print('user id is: $userId');
      CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
      await userCollection.doc(userId).update({
        'userName': userName,
        'bio': bio,
      });
      this.userName.value = userName;
      this.userId.value = userId;
      this.bio.value = bio;
      print('updated done:');
    } catch (e) {
      print('there is an error: $e');
      Utils().toastMessage(e.toString());
    }
  }
}
