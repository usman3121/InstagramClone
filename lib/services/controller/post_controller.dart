import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:instagram/services/controller/imageController.dart';
import 'package:instagram/services/controller/registration_controller.dart';
import 'package:instagram/services/model/post_model.dart';
import 'package:instagram/services/model/user_model.dart';

import '../../ui/components/utils.dart';

class Post_Controller extends GetxController {
  final RegistrationController controller = Get.put(RegistrationController());
  final ImagePickerController imageController =
      Get.put(ImagePickerController());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? getCurrentUserID() {
    return _auth.currentUser?.uid;
  }

  CollectionReference userPostCollection() {
    return _firestore
        .collection('users')
        .doc(getCurrentUserID())
        .collection('post');
  }

  CollectionReference userDataCollection() {
    return _firestore
        .collection('users')
        .doc(getCurrentUserID())
        .collection('data');
  }

  Future<void> addPost(
      String userName, String captions, String comments, int likesCount) async {
    try {
      print("hitting towards addpost");
      PostModel model = PostModel(
        userName: userName,
        captions: captions,
        comments: comments,
        likesCount: likesCount,
      );
      await userPostCollection().add(model.tojson());
    } catch (e) {
      if (e is FirebaseException) {
        print('Firebase Error: ${e.code} - ${e.message}');
      } else {
        print('Error: $e');
      }
      Utils().toastMessage(e.toString());
    }
  }

  Future<void> addUserData() async {
    try {
      String? profileImagePath = imageController
          .imageUrl;
      if (profileImagePath.isNotEmpty) {
        UserModel usermodel = UserModel(
          bio: controller.bioController.text,
          followers: 30,
          following: 20,
          profileImagePath: imageController.imageUrl,
          userName: controller.usernameController.text,
          totalPost: 1,
          comment:[controller.commentController.text],
        );
        await userDataCollection().add(usermodel.tojson());
      } else {
        print("From AddUserData Profile image URL is empty.");
      }
    } catch (e) {
      if (e is FirebaseException) {
        print('Firebase Error: ${e.code} - ${e.message}');
      } else {
        print('Error: $e');
      }
      Utils().toastMessage(e.toString());
    }
  }

  Future<RxList<UserModel>> getUserData() async {
    RxList<UserModel> userData = <UserModel>[].obs;
    try {
      QuerySnapshot snapshot = await userDataCollection().get();
      snapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        debugPrint("From getUserData this is get user data $data");
        UserModel usermodel = UserModel.fromJson(data);
        userData.add(usermodel);
        debugPrint("From getUserData user model List is : ${userData.toString()}");
        debugPrint("user model data is : $usermodel");
      });
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
    return userData;
  }


  Future<void> getUpdatedUserData(String userName, String userId, String bio) async {
    try {
      CollectionReference userDataCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('data');
      QuerySnapshot querySnapshot = await userDataCollection.get();
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        await documentSnapshot.reference.update({
          'userName': userName,
          'bio': bio,
        });
      }
      print('User data updated successfully');
    } catch (e) {
      print('Error updating user data: $e');
    }
  }


  Future<List<PostModel>> getPosts() async {
    List<PostModel> posts = [];
    try {
      QuerySnapshot snapshot = await userPostCollection().get();
      snapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        //print("hjdiiu ${data}");
        PostModel model = PostModel.fromJson(data);
        posts.add(model);
        //print(model);
      });
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
    return posts;
  }
}
