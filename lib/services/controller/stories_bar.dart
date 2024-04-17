import 'package:flutter/material.dart';
import 'package:instagram/services/controller/post_controller.dart';

import '../../ui/components/utils.dart';
import '../model/user_model.dart';

class StoriesBar extends StatelessWidget {
  const StoriesBar({
    super.key,
    required this.postController,
  });

  final Post_Controller postController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.13,
      child: FutureBuilder<List<UserModel>>(
        future: postController.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            Utils().toastMessage("There is an error getting user snapshot");
            return const SizedBox();
          } else if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final story = snapshot.data![index];
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                          story.profileImagePath ?? 'https://via.placeholder.com/150',
                        ),
                      ),
                    ),
                    Text(
                      "Status $index",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            return const SizedBox(); // Return an empty SizedBox if no data
          }
        },
      ),
    );
  }
}