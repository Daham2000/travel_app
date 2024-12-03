import 'dart:convert';

class User {
  final String email;
  String id;
  final String firstName;
  final String lastName;
  final List<Invitation> invitations;

  User({
    required this.email,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.invitations,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    email: json["email"],
    id: json["id"] ?? "",
    firstName: json["firstName"],
    lastName: json["lastName"],
    invitations: json["invitations"] != null ? List<Invitation>.from(json["invitations"].map((x) => Invitation.fromMap(x))) : [],
  );

  Map<String, dynamic> toMap() => {
    "email": email,
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "invitations": List<dynamic>.from(invitations.map((x) => x.toMap())),
  };
}

class Invitation {
  final String email;
  final bool accepted;

  Invitation({
    required this.email,
    required this.accepted,
  });

  factory Invitation.fromJson(String str) => Invitation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Invitation.fromMap(Map<String, dynamic> json) => Invitation(
    email: json["email"],
    accepted: json["accepted"],
  );

  Map<String, dynamic> toMap() => {
    "email": email,
    "accepted": accepted,
  };
}
