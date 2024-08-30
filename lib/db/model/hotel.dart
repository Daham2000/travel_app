// To parse this JSON data, do
//
//     final hotelModel = hotelModelFromJson(jsonString);

class Hotel {
  Hotel({
    required this.images,
    required this.description,
    required this.district,
    required this.link,
    required this.rate,
    required this.title,
  });

  List<String> images;
  String description;
  String district;
  String link;
  int rate;
  String title;

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
    images: List<String>.from(json["Images"].map((x) => x)),
    description: json["description"],
    district: json["district"],
    link: json["link"],
    rate: json["rate"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "Images": List<dynamic>.from(images.map((x) => x)),
    "description": description,
    "district": district,
    "link": link,
    "rate": rate,
    "title": title,
  };
}
