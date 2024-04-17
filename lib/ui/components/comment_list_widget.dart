import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/controller/post_controller.dart';
import '../../services/model/user_model.dart'; // Import your user model

class CommentListWidget extends StatelessWidget {
  final List<UserModel> userData;

  CommentListWidget({required this.userData, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: ListView.builder(
        itemCount: userData.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('User: ${userData[index].userName ?? "Unknown"}',style: TextStyle(color: Colors.white)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(" comments are :${userData[index].comment ?? 'no comments'} ",style: TextStyle(color: Colors.white),),
              ],
            ),
          );
        },
      ),

    );
  }
}

