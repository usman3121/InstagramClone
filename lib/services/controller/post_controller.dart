import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:instagram/services/controller/imageController.dart';
import 'package:instagram/services/controller/registration_controller.dart';
import 'package:instagram/services/model/post_model.dart';
import 'package:instagram/services/model/user_model.dart';
import 'package:instagram/ui/router/app_routes.dart';
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
  RxList<PostModel>? postModelRxList;

  Stream<List<PostModel>> fetchPost() async* {
    try {
      Stream<QuerySnapshot> snapshots = userPostCollection().snapshots();
      await for (QuerySnapshot snapshot in snapshots) {
        List<PostModel> posts = [];
        for (QueryDocumentSnapshot doc in snapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          PostModel model = PostModel.fromJson(data);
          posts.add(model);
        }
        yield posts;
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
  }
  @override
  void onInit() {
    super.onInit();
    fetchUserPostDocumentID().then((_) => update());
    fetchUserDataDocumentID().then((_) => update());
    fetchPost();
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
  RxMap likedPostIds = {}.obs;

  void toggleLike(String postId) async {
    // Toggle like state
    if (likedPostIds.containsKey(postId)) {
      likedPostIds[postId] = !likedPostIds[postId]!;
    } else {
      likedPostIds[postId] = true;
    }

    try {
      final postRef = userPostCollection().doc(postId);
      final postSnapshot = await postRef.get();
      final postData = postSnapshot.data();
      if (postData is Map<String, dynamic>) {
        final currentLikes = postData['likeCount'] as int? ?? 0;
        int updatedLikes;
        if (likedPostIds[postId]!) {
          updatedLikes = currentLikes + 1; // Increment like count if liked
        } else {
          updatedLikes = currentLikes - 1; // Decrement like count if disliked
          updatedLikes = updatedLikes.clamp(0, updatedLikes); // Ensure like count is not negative
        }
        await postRef.update({'likeCount': updatedLikes});
      } else {
        print('Error: Post data is not a Map<String, dynamic>');
      }
    } catch (e) {
      print('Error updating like count: $e');
    }
  }
  bool isPostLiked(String postId) {
    return likedPostIds.containsKey(postId) ? likedPostIds[postId]! : false;
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
          // 'comments': FieldValue.arrayUnion([newComment]),
        });
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
    }}


  Future<void> addPost() async {
    try {
      var uuid = const Uuid();
      String postId = uuid.v1();
      String? profileImagePath = imageController.imageUrl;
      if (profileImagePath.isNotEmpty) {
          CommentModel newComment =
          CommentModel(comment: controller.commentController.text);
          PostModel model = PostModel(
            imageUrl: imageController.imageUrl,
            caption: 'this is a caption',
            postId: postId,
          );
          model.addComment(newComment);
          postModelRxList?.add(model);
          Utils().toastMessage("data: added sucessful");
          print(postModelRxList.toString());
          await FirebaseFirestore.instance.collection('post').doc(postId).set(model.toJson());
          Utils().toastMessage("data added sucessful");
      }
    } catch (e) {
      print ('data failed to add' );
      Utils().toastMessage("data failed to add");
      if (e is FirebaseException) {
      } else {
      }
      Utils().toastMessage(e.toString());
    }
  }

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
        UserModel usermodel = UserModel.fromJson(data);
        userData.add(usermodel);
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


  RxList<PostModel> posts = <PostModel>[].obs;
  Future<RxList<PostModel>> getPosts() async {

    try {
      QuerySnapshot snapshot = await userPostCollection().get();
      snapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        PostModel model = PostModel.fromJson(data);
        posts.add(model);
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
  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.toNamed(App_Routes.signIn);
    } catch (e) {
     Utils().toastMessage(e.toString());
    }
  }
}
