// To parse this JSON data, do
//
//     final hotelModel = hotelModelFromJson(jsonString);

import 'dart:convert';

HotelModel hotelModelFromJson(String str) => HotelModel.fromJson(json.decode(str));

String hotelModelToJson(HotelModel data) => json.encode(data.toJson());

class HotelModel {
  HotelModel({
    required this.hotels,
    required this.totalItems,
  });

  List<Hotel> hotels;
  int totalItems;

  factory HotelModel.fromJson(Map<String, dynamic> json) => HotelModel(
    hotels: List<Hotel>.from(json["hotels"].map((x) => Hotel.fromJson(x))),
    totalItems: json["totalItems"],
  );

  Map<String, dynamic> toJson() => {
    "hotels": List<dynamic>.from(hotels.map((x) => x.toJson())),
    "totalItems": totalItems,
  };
}

class Hotel {
  Hotel({
    required this.images,
    required this.description,
    required this.district,
    required this.link,
    required this.miv,
    required this.rate,
    required this.title,
  });

  List<String> images;
  String description;
  String district;
  String link;
  double miv;
  int rate;
  String title;

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
    images: List<String>.from(json["Images"].map((x) => x)),
    description: json["description"],
    district: json["district"],
    link: json["link"],
    miv: json["miv"].toDouble(),
    rate: json["rate"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "Images": List<dynamic>.from(images.map((x) => x)),
    "description": description,
    "district": district,
    "link": link,
    "miv": miv,
    "rate": rate,
    "title": title,
  };
}
