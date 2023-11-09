import 'package:dio/dio.dart';
import 'package:travel_app/db/constants/url.dart';
import 'package:travel_app/db/model/hotel.dart';

class HotelApi {
  static HotelApi hotelApi = new HotelApi();
  Response? response;
  final dio = Dio();

  Future<HotelModel> getAll(int page,String query,int limit) async {

    final queryParameter = {
      "page": "${page.toString()}",
      "query": query,
      "limit": "${limit.toString()}",
    };
    HotelModel hotelModel = new HotelModel(totalItems: 0, hotels: []);

    try {
      response = await dio.get(UrlConstants.GET_HOTELS,
          queryParameters: queryParameter);
      print(response?.statusCode.toString());
      if (response?.statusCode == 200) {
        final jsonString = response?.data;
        print(jsonString);
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
