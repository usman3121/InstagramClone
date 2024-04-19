import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:instagram/services/controller/imageController.dart';
import 'package:instagram/services/controller/registration_controller.dart';
import 'package:instagram/services/model/post_model.dart';
import 'package:instagram/services/model/user_model.dart';
import 'package:uuid/uuid.dart';
import '../../ui/components/utils.dart';
import '../model/comment_model.dart';

class Post_Controller extends GetxController {
  final RegistrationController controller = Get.put(RegistrationController());
  final ImagePickerController imageController =
      Get.put(ImagePickerController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? userPostDocumentID;
  String? userDataDocumentID;

  @override
  void onInit() {
    super.onInit();
    fetchUserPostDocumentID().then((_) => update());
    fetchUserDataDocumentID().then((_) => update());
  }

  Future<void> fetchUserPostDocumentID() async {
    QuerySnapshot snapshot = await _firestore.collection('post').get();
    if (snapshot.docs.isNotEmpty) {
      userPostDocumentID = snapshot.docs.first.id;
    }
  }

  Future<void> fetchUserDataDocumentID() async {
    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .doc(getCurrentUserID())
        .collection('data')
        .get();
    if (snapshot.docs.isNotEmpty) {
      userDataDocumentID = snapshot.docs.first.id;
    }
  }

  Future<String?> getUserPostDocumentID() async {
    await fetchUserPostDocumentID();
    return userPostDocumentID;
  }

  String? getCurrentUserID() {
    return _auth.currentUser?.uid;
  }

  CollectionReference userPostCollection() {
    return _firestore.collection('post');
  }

  CollectionReference userDataCollection() {
    return _firestore
        .collection('users')
        .doc(getCurrentUserID())
        .collection('data');
  }

  Future<void> addCommentToPost(PostModel post) async {
    try {

      String? currentUserId = getCurrentUserID();
      if (currentUserId != null) {
        CommentModel newComment =
            CommentModel(comment: controller.commentController.text);
        post.addComment(newComment);
        await userPostCollection().doc(post.postId).update({
          'comments':
              post.comments?.map((comment) => comment.toJson()).toList(),
        });
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
    }}



  Future<void> addPost() async {
    try {
      var uuid = const Uuid();
      String postId = uuid.v1(); // Generate a v1 (time-based) id

      String? profileImagePath = imageController.imageUrl;
      if (profileImagePath.isNotEmpty) {
        CommentModel newComment =
        CommentModel(comment: controller.commentController.text);
        List<CommentModel> comments = [newComment];
        PostModel model = PostModel(
          comments: comments,
          imageUrl: imageController.imageUrl,
          caption: 'this is a caption',
          likeCount: 24,
          postId: postId,
        );
        model.addComment(newComment);

        await FirebaseFirestore.instance.collection('post').doc(postId).set(model.toJson());
      }
    } catch (e) {
      if (e is FirebaseException) {
      } else {
      }
      Utils().toastMessage(e.toString());
    }
  }





/*  Future<void> addPost() async {
    try {
      String postId = await getUserPostDocumentID() ?? '';
      String? profileImagePath = imageController.imageUrl;
      if (profileImagePath.isNotEmpty && postId != null) {
        CommentModel newComment =
            CommentModel(comment: controller.commentController.text);
        List<CommentModel> comments = [newComment];
        print("new comment $newComment");
        print("comment list : $comments");
        PostModel model = PostModel(
          comments: comments,
          imageUrl: imageController.imageUrl,
          caption: 'this is a caption',
          likeCount: 24,
          postId: postId,
        );
        model.addComment(newComment);

        await userPostCollection().add(model.toJson());
      }
    } catch (e) {
      if (e is FirebaseException) {
        print('Firebase Error: ${e.code} - ${e.message}');
      } else {
        print('Error: $e');
      }
      Utils().toastMessage(e.toString());
    }
  }*/

  Future<void> addUserData() async {
    try {
      String? profileImagePath = imageController.imageUrl;
      if (profileImagePath.isNotEmpty) {
        UserModel usermodel = UserModel(
          bio: controller.bioController.text,
          followers: 30,
          following: 20,
          profileImagePath: imageController.imageUrl,
          userName: controller.usernameController.text,
          totalPost: 1,
          comment: [controller.commentController.text],
        );
        await userDataCollection().add(usermodel.tojson());
      } else {
      }
    } catch (e) {
      if (e is FirebaseException) {
      } else {
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
      /*  debugPrint(
            "From getUserData user model List is : ${userData.toString()}");
        debugPrint("user model data is : $usermodel");*/
      });
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
    return userData;
  }

  Future<void> getUpdatedUserData(
      String userName, String userId, String bio) async {
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
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
  }

  Future<List<PostModel>> getPosts() async {
    List<PostModel> posts = [];
    try {
      QuerySnapshot snapshot = await userPostCollection().get();
      snapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        debugPrint("From getPosts this is get posts data $data");
        PostModel model = PostModel.fromJson(data);
        posts.add(model);
/*        debugPrint("From getPosts model List is : ${posts.toString()}");
        debugPrint("post model data is : ${model.toString()}");*/
        //print(model);
      });
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
    return posts;
  }
  Future<void> deletePost(String postId) async {
    try {
      await userPostCollection().doc(postId).delete();
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
  }
}
