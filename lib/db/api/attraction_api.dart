/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:travel_app/db/constants/url.dart';
import 'package:travel_app/db/model/attraction.dart';

class AttractionApi {
  static AttractionApi categoryAPI;
  Response response;
  final dio = Dio();

  factory AttractionApi() {
    if (categoryAPI == null) {
      categoryAPI = AttractionApi._internal();
    }
    return categoryAPI;
  }

  AttractionApi._internal();

  Future<Attraction> getAll(int page,String query,int limit) async {

    final queryParameter = {
      "page": "${page.toString()}",
      "query": query,
      "limit": "${limit.toString()}",
    };
    Attraction attractionModel;

    try {
      response = await dio.get(UrlConstants.ALL_POSTS,
          queryParameters: queryParameter);
      if (response.statusCode == 200) {
        final jsonString = response.data;
        attractionModel = Attraction.fromJson(jsonString);
        return attractionModel;
      }
    } catch (e) {
      print(e.toString());
      return attractionModel;
    }
    return attractionModel;
  }

}
