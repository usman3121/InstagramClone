class CommentModel {
  String? commentId;
  String? comment;

  CommentModel({
    this.commentId,
    this.comment,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentId: json['userId'] as String?,
      comment: json['comment'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      'comment': comment,
    };
  }
}