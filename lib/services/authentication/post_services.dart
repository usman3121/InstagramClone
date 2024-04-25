import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:instagram/services/authentication/firebaseservices.dart';
import 'package:uuid/uuid.dart';
import '../../ui/screens/camera_screen/controller/image_controller.dart';
import '../../ui/screens/registry/controller/registration_controller.dart';
import '../../ui/utils/message toaster/utils.dart';
import '../model/comment_model.dart';
import '../model/post_model.dart';

class PostServics extends GetxController{

  final FirebaseServices _firebaseService = Get.put(FirebaseServices());
  RxList<PostModel>? postModelRxList;
  RxMap likedPostIds = {}.obs;
  final RegistrationAndLoginController controller = Get.put(RegistrationAndLoginController());
  final ImagePickerController imageController =
  Get.put(ImagePickerController());



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
          userId: _firebaseService.getCurrentUserID(),
        );
        model.addComment(newComment);
        postModelRxList?.add(model);
        Utils().toastMessage("data: added sucessful");
        await FirebaseFirestore.instance.collection('post').doc(postId).set(model.toJson());
        Utils().toastMessage("data added sucessful");
      }
    } catch (e) {
      Utils().toastMessage("data failed to add");
      if (e is FirebaseException) {
      } else {
      }
      Utils().toastMessage(e.toString());
    }
  }



  Future<void> addCommentToPost(PostModel post) async {
    try {

      String? currentUserId = _firebaseService.getCurrentUserID();
      if (currentUserId != null) {
        CommentModel newComment =
        CommentModel(comment: controller.commentController.text);
        post.addComment(newComment);
        await _firebaseService.userPostCollection().doc(post.postId).update({
          'comments':
          post.comments?.map((comment) => comment.toJson()).toList(),
        });
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
    }}
  Stream<List<PostModel>> fetchPost() {
    try {
      return _firebaseService.userPostCollection().snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => PostModel.fromJson(doc.data() as Map<String, dynamic>)).toList());
    } catch (e) {
      Utils().toastMessage(e.toString());
      rethrow;
    }
  }


  void toggleLike(String postId) async {
    if (likedPostIds.containsKey(postId)) {
      likedPostIds[postId] = !likedPostIds[postId]!;
    } else {
      likedPostIds[postId] = true;
    }
    try {
      final postRef = _firebaseService.userPostCollection().doc(postId);
      final postSnapshot = await postRef.get();
      final postData = postSnapshot.data();
      if (postData is Map<String, dynamic>) {
        final currentLikes = postData['likeCount'] as int? ?? 0;
        int updatedLikes;
        if (likedPostIds[postId]!) {
          updatedLikes = currentLikes + 1;
        } else {
          updatedLikes = currentLikes - 1;
          updatedLikes = updatedLikes.clamp(0, updatedLikes);
        }
        await postRef.update({'likeCount': updatedLikes});
      } else {
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
  }


  bool isPostLiked(String postId) {
    return likedPostIds.containsKey(postId) ? likedPostIds[postId]! : false;
  }


  Future<void> deletePost(String postId) async {
    try {
      await _firebaseService.userPostCollection().doc(postId).delete();
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
  }


  Future<RxList<PostModel>> getPosts() async {
    RxList<PostModel> posts = <PostModel>[].obs;
    try {
      QuerySnapshot snapshot = await _firebaseService.userPostCollection().get();
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        PostModel model = PostModel.fromJson(data);
        posts.add(model);
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
    return posts;
  }

}