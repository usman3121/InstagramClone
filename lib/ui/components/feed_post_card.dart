import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/services/controller/registration_controller.dart';
import 'package:instagram/services/model/post_model.dart';
import '../../services/controller/post_controller.dart';
import '../../services/model/user_model.dart';
import 'comment_list_widget.dart';
import 'post_menu.dart';

class FeedPostCard extends StatelessWidget {
  FeedPostCard({
    Key? key,
    required this.postController,
    required this.userData,
    required this.posts,
  }) : super(key: key);

  final Post_Controller postController;
  final List<UserModel> userData;
  final List<PostModel> posts;
  RegistrationController commentController = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<PostModel>>(
        future: postController.getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final post = snapshot.data![index];
                post.comments;
                String id= post.postId.toString();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
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
                                      posts.first.imageUrl ??
                                          'https://via.placeholder.com/150',
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    userData.first.userName ?? 'username',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(onPressed: () async{
                              await postController.deletePost(post.postId??"'");
                              print(post.postId.toString());
                            }, icon: Icon(Icons.delete_outline_outlined)),
                            IconButton(
                              icon: Icon(Icons.more_vert, color: Colors.white),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return InstagramPostMenu(postId: post.postId, postController: postController,); // Your custom dialog widget
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        Image.network(
                          post.imageUrl ?? 'https://via.placeholder.com/150',
                          fit: BoxFit.cover,
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.favorite,
                                  color: Colors.white),
                              onPressed: () {},
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
                              icon:
                              const Icon(Icons.share, color: Colors.white),
                              onPressed: () {},
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
                              icon: Icon(Icons.send), // Icon for sending
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
                              Get.to(() => CommentListWidget(
                                posts: post.comments,
                              ));
                            },
                            child: const Text('View all Comments',style: TextStyle(color: Colors.white),),
                          ),
                        ),
                        /* TextFormField(
                          controller: commentController.commentController,
                          decoration: const InputDecoration(
                            labelText: 'Add Comment',
                          ),
                        ),
                        Text('comments : ${post.comment ?? ''}'),*/
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

