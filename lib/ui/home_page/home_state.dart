/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/cupertino.dart';
import 'package:travel_app/db/model/user.dart';

@immutable
class HomeState {
  final String? error;
  final List? attractionList;
  final List searchList;
  final List? hotelList;
  final List? attractionListTwo;
  final bool? isSearching;
  final int? page;
  final int? limit;
  final bool? moreSearching;
  final bool? isUpdated;
  final String? version;
  final User? user;

  HomeState({
    required this.error,
    required this.attractionList,
    required this.attractionListTwo,
    required this.searchList,
    required this.isSearching,
    required this.page,
    required this.limit,
    required this.moreSearching,
    required this.isUpdated,
    required this.hotelList,
    required this.version,
    required this.user,
  });

  HomeState copyWith(
      {String? error,
      List? attractionList,
      List? searchList,
      List? hotelList,
      List? attractionListTwo,
      bool? isSearching,
      bool? moreSearching,
      bool? isUpdated,
      String? version,
      User? user,
      int? page,
      int? limit}) {
    return HomeState(
      error: error ?? this.error,
      attractionList: attractionList ?? this.attractionList,
      searchList: searchList ?? this.searchList,
      hotelList: hotelList ?? this.hotelList,
      attractionListTwo: attractionListTwo ?? this.attractionListTwo,
      isSearching: isSearching ?? this.isSearching,
      isUpdated: isUpdated ?? this.isUpdated,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      moreSearching: moreSearching ?? this.moreSearching,
      version: version ?? this.version,
      user: user ?? this.user,
    );
  }

  static HomeState get initialState => HomeState(
        error: null,
        attractionList: [],
        searchList: [],
        hotelList: [],
        attractionListTwo: null,
        isSearching: false,
        isUpdated: false,
        page: 1,
        limit: 10,
        moreSearching: false,
        version: "",
        user: null,
      );
}
