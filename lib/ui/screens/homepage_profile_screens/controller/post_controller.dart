import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:instagram/services/authentication/firebaseservices.dart';
import 'package:instagram/services/authentication/postServices.dart';
import 'package:instagram/ui/screens/camera_screen/controller/imageController.dart';
import 'package:instagram/ui/screens/registry/controller/registration_controller.dart';
import 'package:instagram/services/model/post_model.dart';
import 'package:instagram/services/model/user_model.dart';
import '../../../../services/authentication/userServices.dart';
import '../../../utils/message toaster/utils.dart';


class PostController extends GetxController {
  FirebaseServices services = Get.put(FirebaseServices());
  final RegistrationAndLoginController controller =
      Get.put(RegistrationAndLoginController());
  final ImagePickerController imageController =
      Get.put(ImagePickerController());
  RxList<PostModel>? postModelRxList;
  final PostServics postServices = Get.put(PostServics());
  final UserServices userServices = Get.put(UserServices());


  @override
  void onInit() {
    super.onInit();
    fetchPost();
  }

  void addPost() async {
    await postServices.addPost();
  }

  Stream<List<PostModel>> fetchPost() {
    try {
      return postServices.fetchPost();
    } catch (e) {
      Utils().toastMessage(e.toString());
      throw e;
    }
  }

  Future<void> addCommentToPost(PostModel post) async {
    try {
      await postServices.addCommentToPost(post);
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await postServices.deletePost(postId);
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
  }

  void toggleLike(String postId) {
    postServices.toggleLike(postId);
  }

  bool isPostLiked(String postId) {
    return postServices.isPostLiked(postId);
  }


  Future<void> addUserData() async {
    try {
      await userServices.addUserData();
    } catch (e) {
      if (e is FirebaseException) {
      } else {}
      Utils().toastMessage(e.toString());
    }
  }

  Future<RxList<UserModel>> getUserData() async {
    RxList<UserModel> userData = <UserModel>[].obs;
    try {
      userData.assignAll(await userServices.getUserData());
      return userData;
    } catch (e) {
      Utils().toastMessage(e.toString());
      throw e;
    }
  }


  Future<void> getUpdatedUserData(String userName, String userId, String bio) async {
    try {
      if (userId.isEmpty) {
        throw Exception('User ID cannot be empty');
      }
      print ('user id is: $userId');
      CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
      await userCollection.doc(userId).update({
        'userName': userName,
        'bio': bio,
      });
      print('updated done:');
    } catch (e) {
      print('there is an error: $e');
      Utils().toastMessage(e.toString());
    }
  }




  Future<RxList<PostModel>> getPosts() async {
    RxList<PostModel> posts = <PostModel>[].obs;
    try {
        posts.assignAll(await postServices.getPosts());
        return posts;
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
    return posts;
  }
}
