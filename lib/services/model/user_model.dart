class UserModel {
  int? totalPost;
  int? followers;
  int? following;
  String? userName;
  String? bio;
  String? profileImagePath;
  String? userId;
  List<String>? comment;

  @override
  String toString() {
    return 'UserModel{totalPost: $totalPost, followers: $followers, following: $following, userName: $userName,'
        ' bio: $bio, profileImagePath: $profileImagePath, comment: $comment, userId: $userId}';
  }

  UserModel({
    this.totalPost,
    this.followers,
    this.following,
    this.userName,
    this.bio,
    this.profileImagePath,
    this.comment,
    this.userId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    try {
      return UserModel(
        totalPost: json['totalPost'] != null
            ? int.parse(json['totalPost'].toString())
            : null,
        followers: json['followers'] != null
            ? int.parse(json['followers'].toString())
            : null,
        following: json['following'] != null
            ? int.parse(json['following'].toString())
            : null,
        userName: json['userName'],
        bio: json['bio'] as String?,
        profileImagePath: json['profileImagePath'] as String?,
        comment:
            json['comment'] != null ? List<String>.from(json['comment']) : null,
        userId: json['userId'] as String?,
      );
    } catch (e) {
      return UserModel();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName as String;
    data['followers'] = followers as int;
    data['totalPost'] = totalPost as int;
    data['following'] = following as int;
    data['bio'] = bio as String;
    data['profileImagePath'] = profileImagePath;
    data['comment'] = comment ?? [];
    data['userId'] = userId ?? [];
    return data;
  }
}
