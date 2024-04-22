/*
import 'package:flutter/material.dart';

import '../services/model/post_model.dart';

class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  StreamBuilder<List<PostModel>>(
        stream: postController.fetchPost(), // Stream of posts
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            print('Received ${snapshot.data!.length} posts');
            return
              GridView.builder(
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final post = snapshot.data![index];
                  return Card(
                    color: Colors.black,
                    child: Image.network(
                      post.imageUrl ??
                          'https://via.placeholder.com/150',
                      fit: BoxFit.cover,
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
*/
