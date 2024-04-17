import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:instagram/services/controller/registration_controller.dart';
import '../../services/controller/post_controller.dart';
import '../../services/model/user_model.dart';
import 'comment_list_widget.dart';

class FeedPostCard extends StatelessWidget {
  FeedPostCard({
    super.key,
    required this.postController,
    required this.userData,
  });

  final Post_Controller postController;
  final List<UserModel> userData;
  RegistrationController commentController = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<UserModel>>(
        future: postController.getUserData(),
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
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.black,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                  userData.first.profileImagePath ??
                                      'https://via.placeholder.com/150',
                                ),
                              ),
                              const SizedBox(width: 20),
                              Text(
                                userData.first.userName ?? '',
                                /*post.userName ?? '',*/
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.network(
                          post.profileImagePath ??
                              'https://via.placeholder.com/150',
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
                              onPressed: () {},
                            ),
                            IconButton(
                              icon:
                                  const Icon(Icons.share, color: Colors.white),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        Text("Total Likes: ${post.followers ?? 0}"),
                        Text("Captions: ${post.userName ?? 'No caption'}"),
                        TextFormField(
                          controller: commentController.commentController,
                          decoration: const InputDecoration(
                            labelText: 'Add Comment',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            Get.to(() => CommentListWidget(userData: userData));
                          },
                          child: Text('View Comments'),
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
