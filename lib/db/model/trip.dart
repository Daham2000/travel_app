import 'dart:convert';

class AttractionTripModel {
  String id;
  bool isRoomBooked;

  AttractionTripModel({
    required this.id,
    required this.isRoomBooked,
  });

  factory AttractionTripModel.fromJson(String str) =>
      AttractionTripModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AttractionTripModel.fromMap(Map<String, dynamic> json) =>
      AttractionTripModel(
        id: json["id"],
        isRoomBooked: json["isRoomBooked"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "isRoomBooked": isRoomBooked,
      };
}

class Trip {
  String name;
  String id;
  List<String> users;
  DateTime startDate;
  DateTime endDate;
  List<AttractionTripModel> attractionList;

  Trip({
    required this.name,
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.attractionList,
    required this.users,
  });

  factory Trip.fromJson(String str) => Trip.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Trip.fromMap(Map<String, dynamic> json) => Trip(
        name: json["name"],
        id: json["id"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        attractionList: json["attractionList"],
    users: json["users"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "id": id,
        "startDate": startDate,
        "endDate": endDate,
        "users": users,
        "attractionList": List<dynamic>.from(
            attractionList.map((x) => x.toJson())),
      };
}
