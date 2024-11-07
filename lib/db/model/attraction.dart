// To parse this JSON data, do
//
//     final attraction = attractionFromJson(jsonString);

import 'package:travel_app/db/model/comment.dart';

class Attraction {
  Attraction({
    required this.description,
    required this.district,
    required this.images,
    required this.latLng,
    required this.shortDetail,
    required this.title,
    required this.youtubeId,
    required this.comments,
    this.id,
  });

  String description;
  String district;
  List<String> images;
  List<String> latLng;
  String shortDetail;
  String title;
  String youtubeId;
  List<Comment> comments;
  String? id;

  factory Attraction.fromJson(json) => Attraction(
        description: json["Description"],
        district: json["District"],
        images: List<String>.from(json["Images"].map((x) => x)),
        latLng: List<String>.from(json["LatLng"].map((x) => x)),
        shortDetail: json["ShortDetail"],
        title: json["Title"],
        youtubeId: json["youtubeID"],
        id: json["id"],
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Description": description,
        "District": district,
        "Images": List<dynamic>.from(images.map((x) => x)),
        "LatLng": List<dynamic>.from(latLng.map((x) => x)),
        "ShortDetail": shortDetail,
        "Title": title,
        "youtubeID": youtubeId,
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
      };
}
