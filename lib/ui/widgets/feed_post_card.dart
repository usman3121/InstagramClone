import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/services/authentication/user_services.dart';
import 'package:instagram/ui/screens/registry/controller/registration_controller.dart';
import 'package:instagram/services/model/post_model.dart';
import '../screens/homepage_profile_screens/controller/post_controller.dart';
import '../../services/model/user_model.dart';
import 'comment_list_widget.dart';
import 'post_menu.dart';

class FeedPostCard extends StatelessWidget {
  final PostController postController = Get.put(PostController());
  final UserServices userServices = Get.put(UserServices());
  final RegistrationAndLoginController commentController = Get.put(RegistrationAndLoginController());
  final List<UserModel> userData;

  FeedPostCard({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<PostModel>>(
        stream: postController.fetchPost(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final post = snapshot.data![index];
                return FutureBuilder<UserModel?>(
                  future: userServices.getUserById(post.userId ?? ''),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (userSnapshot.hasError) {
                      return Center(child: Text('Error: ${userSnapshot.error}'));
                    } else if (userSnapshot.hasData && userSnapshot.data != null) {
                      final user = userSnapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Card(
                          color: Colors.black,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundImage: NetworkImage(
                                            user.profileImagePath ??
                                                'https://via.placeholder.com/150',
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Text(user.userName ?? ''),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.more_vert, color: Colors.white),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return InstagramPostMenu(
                                            postId: post.postId,
                                            postController: postController,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.5,
                                child: Image.network(
                                  post.imageUrl ?? 'https://via.placeholder.com/150',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              ButtonBar(
                                alignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    icon: postController.isPostLiked(post.postId ?? '')
                                        ? const Icon(Icons.favorite, color: Colors.red)
                                        : const Icon(Icons.favorite_border, color: Colors.white),
                                    onPressed: () {
                                      postController.toggleLike(post.postId ?? '');
                                      // Update like count
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.comment, color: Colors.white),
                                    onPressed: () {
                                      Get.to(() => CommentListWidget(posts: post.comments));
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.share, color: Colors.white),
                                    onPressed: () {
                                    },
                                  ),
                                ],
                              ),
                              Text("Total Likes: ${post.likeCount ?? 0}"),
                              Text("Captions: ${post.caption ?? 'No caption'}"),
                              TextFormField(
                                controller: commentController.commentController,
                                decoration: InputDecoration(
                                  labelText: 'Add Comment',
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.send),
                                    onPressed: () async {
                                      await postController.addCommentToPost(post);
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 183),
                                child: TextButton(
                                  onPressed: () async {
                                    Get.to(() => CommentListWidget(posts: post.comments));
                                  },
                                  child: const Text(
                                    'View all Comments',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('No posts available'));
          }
        },
      ),
    );
  }
}

