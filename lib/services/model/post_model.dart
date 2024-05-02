import 'package:get/get.dart';

import 'comment_model.dart';
class PostModel {
  String? postId;
  String? caption;
  String? imageUrl;
  String? videoUrl;
  RxList<CommentModel>? comments;
  int? likeCount ;
  String? userId;
  PostModel({
    this.postId,
    this.caption,
    this.imageUrl,
    this.videoUrl,
    List<CommentModel>? comments,
    this.likeCount,
    this.userId
  }): comments = RxList<CommentModel>.from(comments ?? []);

  void addComment(CommentModel comment) {
    comments?.add(comment);
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postId: json['postId'] as String?,
      likeCount: json['likeCount'] as int?,
      caption: json['caption'] as String?,
      imageUrl: json['imageUrl'] as String?,
      videoUrl: json['videoUrl'] as String?,
      comments: (json['comments'] as List<dynamic>?)
          ?.map((commentJson) => CommentModel.fromJson(commentJson as Map<String, dynamic>))
          .toList(),
        userId: json['userId']as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'caption': caption,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'comments': comments?.map((comment) => comment.toJson()).toList() ?? [],
      'userId': userId,
    };
  }
}
