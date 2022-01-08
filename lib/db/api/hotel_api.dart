import 'package:dio/dio.dart';
import 'package:travel_app/db/constants/url.dart';
import 'package:travel_app/db/model/hotel.dart';

class HotelApi {
  static HotelApi hotelApi;
  Response response;
  final dio = Dio();

  factory HotelApi() {
    if (hotelApi == null) {
      hotelApi = HotelApi._internal();
    }
    return hotelApi;
  }

  HotelApi._internal();

  Future<HotelModel> getAll(int page,String query,int limit) async {

    final queryParameter = {
      "page": "${page.toString()}",
      "query": query,
      "limit": "${limit.toString()}",
    };
    HotelModel hotelModel;

    try {
      response = await dio.get(UrlConstants.GET_HOTELS,
          queryParameters: queryParameter);
      if (response.statusCode == 200) {
        final jsonString = response.data;
        hotelModel = HotelModel.fromJson(jsonString);
        return hotelModel;
      }
    } catch (e) {
      print(e.toString());
      return hotelModel;
    }
    return hotelModel;
  }

}
