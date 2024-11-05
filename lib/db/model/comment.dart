class Comment {
  Comment({
    required this.userEmail,
    required this.userName,
    required this.commentDescription,
    required this.commentTime,
  });

  String userEmail;
  String userName;
  String commentDescription;
  final commentTime;

  factory Comment.fromJson(json) => Comment(
        userEmail: json["userEmail"],
        userName: json["userName"],
        commentDescription: json["commentDescription"],
        commentTime: json["commentTime"],
      );

  Map<String, dynamic> toJson() => {
        "userEmail": userEmail,
        "userName": userName,
        "commentDescription": commentDescription,
        "commentTime": commentTime,
      };
}
