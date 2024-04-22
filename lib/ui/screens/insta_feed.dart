import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:instagram/services/model/post_model.dart';
import '../../services/controller/post_controller.dart';
import '../../services/controller/registration_controller.dart';
import '../../services/controller/stories_bar.dart';
import '../../services/controller/stories_controller.dart';
import '../../services/model/user_model.dart';
import '../components/comment_list_widget.dart';
import '../components/feed_post_card.dart';
import '../components/insta_top_bar.dart';
import '../components/post_menu.dart';

class InstaFeed extends StatefulWidget {
  const InstaFeed({super.key});

  @override
  State<InstaFeed> createState() => _InstaFeedState();
}

RegistrationController commentController = Get.put(RegistrationController());

class _InstaFeedState extends State<InstaFeed> {
  final Stories_Controller storiesController = Get.put(Stories_Controller());
  final Post_Controller postController = Get.put(Post_Controller());
  final UserModel users = UserModel();
  List<UserModel> userData = [];

/*
  @override
  void initState() {
    super.initState();
    fetchPostData();
  }

  Future<void> fetchPostData() async {
    userData = await postController.getUserData();
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.03),
            const InstaTopBar(),
            StoriesBar(postController: postController),
            //FeedPostCard(postController: postController, userData: userData),
            //FeedPostCard(),
            FeedPostCard(userData: userData)
          ],
        ),
      ),
    );
  }
}
