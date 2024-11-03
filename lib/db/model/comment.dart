class Comment {
  Comment({
    required this.userEmail,
    required this.userName,
    required this.commentDescription,
  });

  String userEmail;
  String userName;
  String commentDescription;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        userEmail: json["userEmail"],
        userName: json["userName"],
        commentDescription: json["commentDescription"],
      );

  Map<String, dynamic> toJson() => {
        "userEmail": userEmail,
        "userName": userName,
        "commentDescription": commentDescription,
      };
}
