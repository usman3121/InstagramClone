import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:instagram/services/controller/registration_controller.dart';
import 'package:instagram/services/model/post_model.dart';
import '../../services/controller/post_controller.dart';
import '../../services/model/user_model.dart';
import 'comment_list_widget.dart';
import 'post_menu.dart';

class FeedPostCard extends StatelessWidget {
  FeedPostCard({
    Key? key, required this.userData
  }) : super(key: key);

  final Post_Controller postController = Get.put(Post_Controller());
  final List<UserModel> userData;

  RegistrationController commentController = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<PostModel>>(
        stream: postController.fetchPost(), // Stream of posts
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            print('Received ${snapshot.data!.length} posts');
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final post = snapshot.data![index];
                print(
                    "dkjszidsiusdifuhidsfhidsfuisdfublidsfabibl$postController.postModelRxList![index]");
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.black,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                      post.imageUrl ??
                                          'https://via.placeholder.com/150',
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    userData.isNotEmpty
                                        ? userData.first.userName ??
                                        'username'
                                        : 'username',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  await postController
                                      .deletePost(post.postId ?? '');
                                  print(post.postId.toString());
                                },
                                icon: const Icon(
                                    Icons.delete_outline_outlined)),
                            IconButton(
                              icon: const Icon(Icons.more_vert,
                                  color: Colors.white),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return InstagramPostMenu(
                                      postId: post.postId,
                                      postController: postController,
                                    ); // Your custom dialog widget
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        Image.network(
                          post.imageUrl ??
                              'https://via.placeholder.com/150',
                          fit: BoxFit.cover,
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: postController
                                  .isPostLiked(post.postId ?? '')
                                  ? Icon(Icons.favorite,
                                  color: Colors.red)
                                  : Icon(Icons.favorite_border,
                                  color: Colors.white),
                              onPressed: () {
                                print('likes getting pressed');
                                postController
                                    .toggleLike(post.postId ?? '');
                                if (postController
                                    .isPostLiked(post.postId ?? '')) {
                                  print('likes increases');
                                  post.likeCount =
                                      (post.likeCount ?? 0) + 1;
                                } else {
                                  print('likes decreases');
                                  post.likeCount =
                                      (post.likeCount ?? 0) - 1;
                                }
                                postController.update();
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.comment,
                                  color: Colors.white),
                              onPressed: () {
                                Get.to(() => CommentListWidget(
                                  posts: post.comments,
                                ));
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.share,
                                  color: Colors.white),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        Text("Total Likes: ${post.likeCount ?? 0}"),
                        Text(
                            "Captions: ${post.caption ?? 'No caption'}"),
                        TextFormField(
                          controller:
                          commentController.commentController,
                          decoration: InputDecoration(
                            labelText: 'Add Comment',
                            suffixIcon: IconButton(
                              icon: const Icon(
                                  Icons.send), // Icon for sending
                              onPressed: () async {
                                await postController
                                    .addCommentToPost(post);
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 183),
                          child: TextButton(
                            onPressed: () async {
                              Get.to(() => CommentListWidget(
                                posts: post.comments,
                              ));
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
