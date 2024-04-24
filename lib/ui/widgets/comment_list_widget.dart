import 'package:flutter/material.dart';
import 'package:instagram/services/model/comment_model.dart';

class CommentListWidget extends StatelessWidget {
  final List<CommentModel>? posts; 

  CommentListWidget({required this.posts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: posts != null
          ? ListView.builder(
              itemCount: posts!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('User: ${posts![index].comment ?? "PostId"}',
                      style: TextStyle(color: Colors.white)),
                  subtitle: Text(posts!.length.toString()),
                );
              },
            )
          : Center(
              child: Text('No comments available'),
            ),
    );
  }
}
