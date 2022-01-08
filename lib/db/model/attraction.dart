// To parse this JSON data, do
//
//     final attraction = attractionFromJson(jsonString);

import 'dart:convert';

Attraction attractionFromJson(String str) => Attraction.fromJson(json.decode(str));

String attractionToJson(Attraction data) => json.encode(data.toJson());

class Attraction {
  Attraction({
    this.posts,
  });

  List<Post> posts;

  factory Attraction.fromJson(Map<String, dynamic> json) => Attraction(
    posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
  };
}

class Post {
  Post({
    this.description,
    this.district,
    this.images,
    this.latLng,
    this.shortDetail,
    this.title,
    this.youtubeId,
  });

  String description;
  String district;
  List<String> images;
  List<String> latLng;
  String shortDetail;
  String title;
  String youtubeId;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    description: json["Description"],
    district: json["District"],
    images: List<String>.from(json["Images"].map((x) => x)),
    latLng: List<String>.from(json["LatLng"].map((x) => x)),
    shortDetail: json["ShortDetail"],
    title: json["Title"],
    youtubeId: json["youtubeID"],
  );

  Map<String, dynamic> toJson() => {
    "Description": description,
    "District": district,
    "Images": List<dynamic>.from(images.map((x) => x)),
    "LatLng": List<dynamic>.from(latLng.map((x) => x)),
    "ShortDetail": shortDetail,
    "Title": title,
    "youtubeID": youtubeId,
  };
}
