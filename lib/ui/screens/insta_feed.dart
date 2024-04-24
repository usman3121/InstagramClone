import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'homepage_profile_screens/controller/post_controller.dart';
import 'registry/controller/registration_controller.dart';
import '../widgets/stories_bar.dart';
import '../../services/model/user_model.dart';
import '../widgets/feed_post_card.dart';
import '../components/insta_top_bar.dart';


class InstaFeed extends StatefulWidget {
  const InstaFeed({super.key});

  @override
  State<InstaFeed> createState() => _InstaFeedState();
}

RegistrationAndLoginController commentController = Get.put(RegistrationAndLoginController());

class _InstaFeedState extends State<InstaFeed> {
  final PostController postController = Get.put(PostController());
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
