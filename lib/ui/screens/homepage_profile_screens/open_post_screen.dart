import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import '../../../services/controller/post_controller.dart';
import '../../../services/model/post_model.dart';
import '../../../services/model/user_model.dart';
import '../../components/feed_post_card.dart';

class OpenPostScreen extends StatefulWidget {
  const OpenPostScreen({super.key});

  @override
  State<OpenPostScreen> createState() => _OpenPostScreenState();
}

class _OpenPostScreenState extends State<OpenPostScreen> {
  final Post_Controller postController = Get.put(Post_Controller());
  List<UserModel> userData = [];

  final PostModel post = PostModel();
  RxList<PostModel> postData =<PostModel>[].obs;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    // List<UserModel> data = await postController.getUserData();
    List<PostModel> data = await postController.getPosts();
    setState(() {
      postData = data.obs;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar( title: const Text(
        "Posts",
        style: TextStyle(color: Colors.white),
      ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),backgroundColor: Colors.black,),
      body: Column(
        children: [
        /*  FeedPostCard(*//*postController: postController, userData: userData,posts: postData,*//*),*/
          FeedPostCard(userData: userData)

        ],
      ),
    );
  }
}
