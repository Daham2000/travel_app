import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:travel_app/db/model/hotel_search_model.dart';

Future<HotelSearchResponse> fetchNearbyHotels(double lat, double lng) async {
  final apiKey = 'AIzaSyC6q9DqNUesEqRvX04W60lrmTobM87GgVU';
  final url =
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&type=lodging&rankby=distance&key=$apiKey';

  final response = await http.get(Uri.parse(url));
  final HotelSearchResponse t = HotelSearchResponse.fromJson(jsonDecode(response.body));
  print("response: " + t.results[0].name);
  if (response.statusCode == 200) {
    return HotelSearchResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load hotels');
  }
}
