// To parse this JSON data, do
//
//     final attraction = attractionFromJson(jsonString);


class Attraction {
  Attraction({
    required this.description,
    required this.district,
    required this.images,
    required this.latLng,
    required this.shortDetail,
    required this.title,
    required this.youtubeId,
  });

  String description;
  String district;
  List<String> images;
  List<String> latLng;
  String shortDetail;
  String title;
  String youtubeId;

  factory Attraction.fromJson(Map<String, dynamic> json) => Attraction(
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
