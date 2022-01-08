import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.email,
    this.firstName,
    this.lastLogin,
    this.lastName,
    this.miv,
    this.uid,
  });

  String email;
  String firstName;
  DateTime lastLogin;
  String lastName;
  int miv;
  String uid;

  factory User.fromJson(Map<String, dynamic> json) => User(
    email: json["email"],
    firstName: json["firstName"],
    lastLogin: DateTime.parse(json["lastLogin"]),
    lastName: json["lastName"],
    miv: json["miv"],
    uid: json["uid"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "firstName": firstName,
    "lastLogin": lastLogin.toIso8601String(),
    "lastName": lastName,
    "miv": miv,
    "uid": uid,
  };
}
