import 'dart:convert';

class HotelSearchResponse {
  final List<dynamic> htmlAttributions;
  final List<Hotel> results;
  final String status;

  HotelSearchResponse({
    required this.htmlAttributions,
    required this.results,
    required this.status,
  });

  factory HotelSearchResponse.fromJson(Map<String, dynamic> json) {
    return HotelSearchResponse(
      htmlAttributions: json['html_attributions'] ?? [],
      results: (json['results'] as List<dynamic>)
          .map((item) => Hotel.fromJson(item))
          .toList(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'html_attributions': htmlAttributions,
      'results': results.map((item) => item.toJson()).toList(),
      'status': status,
    };
  }
}

class Hotel {
  final String? businessStatus;
  final Geometry geometry;
  final String icon;
  final String iconBackgroundColor;
  final String iconMaskBaseUri;
  final String name;
  final OpeningHours? openingHours;
  final List<Photo>? photos;
  final String placeId;
  final PlusCode plusCode;
  final int priceLevel;
  final double rating;
  final String reference;
  final String scope;
  final List<String> types;
  final int userRatingsTotal;
  final String vicinity;

  Hotel({
    required this.businessStatus,
    required this.geometry,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconMaskBaseUri,
    required this.name,
    required this.openingHours,
    required this.photos,
    required this.placeId,
    required this.plusCode,
    required this.priceLevel,
    required this.rating,
    required this.reference,
    required this.scope,
    required this.types,
    required this.userRatingsTotal,
    required this.vicinity,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      businessStatus: json['business_status'] ?? 'UNKNOWN',
      geometry: json['geometry'] != null
          ? Geometry.fromJson(json['geometry'])
          : Geometry(
        location: Location(lat: 0.0, lng: 0.0),
        viewport: Viewport(
          northeast: Location(lat: 0.0, lng: 0.0),
          southwest: Location(lat: 0.0, lng: 0.0),
        ),
      ),
      icon: json['icon'] ?? '',
      iconBackgroundColor: json['icon_background_color'] ?? '#FFFFFF',
      iconMaskBaseUri: json['icon_mask_base_uri'] ?? '',
      name: json['name'] ?? 'Unnamed',
      openingHours: json['opening_hours'] != null
          ? OpeningHours.fromJson(json['opening_hours'])
          : OpeningHours(openNow: false),
      photos: (json['photos'] as List<dynamic>?)
          ?.map((item) => Photo.fromJson(item))
          .toList() ??
          [],
      placeId: json['place_id'] ?? '',
      plusCode: json['plus_code'] != null
          ? PlusCode.fromJson(json['plus_code'])
          : PlusCode(compoundCode: '', globalCode: ''),
      priceLevel: json['price_level'] ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reference: json['reference'] ?? '',
      scope: json['scope'] ?? '',
      types: List<String>.from(json['types'] ?? []),
      userRatingsTotal: json['user_ratings_total'] ?? 0,
      vicinity: json['vicinity'] ?? 'Unknown location',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'business_status': businessStatus,
      'geometry': geometry.toJson(),
      'icon': icon,
      'icon_background_color': iconBackgroundColor,
      'icon_mask_base_uri': iconMaskBaseUri,
      'name': name,
      'opening_hours': openingHours?.toJson(),
      'photos': photos?.map((item) => item.toJson()).toList(),
      'place_id': placeId,
      'plus_code': plusCode.toJson(),
      'price_level': priceLevel,
      'rating': rating,
      'reference': reference,
      'scope': scope,
      'types': types,
      'user_ratings_total': userRatingsTotal,
      'vicinity': vicinity,
    };
  }
}

class Geometry {
  final Location location;
  final Viewport viewport;

  Geometry({required this.location, required this.viewport});

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      location: Location.fromJson(json['location']),
      viewport: Viewport.fromJson(json['viewport']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location.toJson(),
      'viewport': viewport.toJson(),
    };
  }
}

class Location {
  final double lat;
  final double lng;

  Location({required this.lat, required this.lng});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}

class Viewport {
  final Location northeast;
  final Location southwest;

  Viewport({required this.northeast, required this.southwest});

  factory Viewport.fromJson(Map<String, dynamic> json) {
    return Viewport(
      northeast: Location.fromJson(json['northeast']),
      southwest: Location.fromJson(json['southwest']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'northeast': northeast.toJson(),
      'southwest': southwest.toJson(),
    };
  }
}

class OpeningHours {
  final bool openNow;

  OpeningHours({required this.openNow});

  factory OpeningHours.fromJson(Map<String, dynamic> json) {
    return OpeningHours(
      openNow: json['open_now'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'open_now': openNow,
    };
  }
}

class Photo {
  final int height;
  final List<String> htmlAttributions;
  final String photoReference;
  final int width;

  Photo({
    required this.height,
    required this.htmlAttributions,
    required this.photoReference,
    required this.width,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      height: json['height'],
      htmlAttributions: List<String>.from(json['html_attributions']),
      photoReference: json['photo_reference'],
      width: json['width'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'height': height,
      'html_attributions': htmlAttributions,
      'photo_reference': photoReference,
      'width': width,
    };
  }
}

class PlusCode {
  final String compoundCode;
  final String globalCode;

  PlusCode({required this.compoundCode, required this.globalCode});

  factory PlusCode.fromJson(Map<String, dynamic> json) {
    return PlusCode(
      compoundCode: json['compound_code'],
      globalCode: json['global_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'compound_code': compoundCode,
      'global_code': globalCode,
    };
  }
}
