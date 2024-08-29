import 'dart:convert';

class User {
  String email;
  String firstName;
  String lastName;

  User({
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    email: json["email"],
    firstName: json["firstName"],
    lastName: json["lastName"],
  );

  Map<String, dynamic> toMap() => {
    "email": email,
    "firstName": firstName,
    "lastName": lastName,
  };
}
