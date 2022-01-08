import 'dart:convert';

HotelModel hotelModelFromJson(String str) => HotelModel.fromJson(json.decode(str));

String hotelModelToJson(HotelModel data) => json.encode(data.toJson());

class HotelModel {
  HotelModel({
    this.hotels,
    this.totalItems,
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
    this.images,
    this.description,
    this.district,
    this.link,
    this.miv,
    this.rate,
    this.title,
  });

  List<String> images;
  String description;
  String district;
  String link;
  int miv;
  int rate;
  String title;

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
    images: List<String>.from(json["Images"].map((x) => x)),
    description: json["description"],
    district: json["district"],
    link: json["link"],
    miv: json["miv"],
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
