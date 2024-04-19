import 'package:get/get.dart';

import 'comment_model.dart';
class PostModel {
  String? postId;
  String? caption;
  String? imageUrl;
  RxList<CommentModel>? comments;
  int? likeCount ;
  PostModel({
    this.postId,
    this.caption,
    this.imageUrl,
    List<CommentModel>? comments,
    this.likeCount
  }): comments = comments != null ? RxList<CommentModel>.from(comments) : RxList<CommentModel>();

  void addComment(CommentModel comment) {
    comments?.add(comment);
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postId: json['postId'] as String?,
      likeCount: json['likeCount'] as int?,
      caption: json['caption'] as String?,
      imageUrl: json['imageUrl'] as String?,
      comments: (json['comments'] as List<dynamic>?)
          ?.map((commentJson) => CommentModel.fromJson(commentJson as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'caption': caption,
      'imageUrl': imageUrl,
      'comments': comments?.map((comment) => comment.toJson()).toList() ?? [],
    };
  }
}
