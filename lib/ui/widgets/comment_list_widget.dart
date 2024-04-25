import 'package:flutter/material.dart';
import 'package:instagram/services/model/comment_model.dart';

class CommentListWidget extends StatelessWidget {
  final List<CommentModel>? posts; 

  const CommentListWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: posts != null
          ? ListView.builder(
              itemCount: posts!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('User: ${posts![index].comment ?? "PostId"}',
                      style: const TextStyle(color: Colors.white)),
                  subtitle: Text(posts!.length.toString()),
                );
              },
            )
          : const Center(
              child: Text('No comments available'),
            ),
    );
  }
}
