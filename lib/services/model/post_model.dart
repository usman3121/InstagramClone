class PostModel {
  String userName;
  String? comments;
  int? likesCount;
  String? captions;

  PostModel(
      {required this.userName, this.comments, this.likesCount, this.captions});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        userName: json['userName'],
        comments: json['comments'],
        likesCount: json['likesCount'],
        captions: json['captions']);
  }

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName as String;
    data['comments'] = comments as String;
    data['likesCount'] = likesCount as int;
    data['captions'] = captions as String;
    return data;
  }
}
