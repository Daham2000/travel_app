/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/cupertino.dart';
import 'package:travel_app/db/model/attraction.dart';
import 'package:travel_app/db/model/hotel.dart';

@immutable
class HomeState {
  final String error;
  final Attraction attractionList;
  final Attraction searchList;
  final HotelModel hotelList;
  final List attractionListTwo;
  final bool isSearching;
  final int page;
  final int limit;
  final bool moreSearching;
  final bool isUpdated;

  HomeState({
    this.error,
    this.attractionList,
    this.attractionListTwo,
    this.searchList,
    this.isSearching,
    this.page,
    this.limit,
    this.moreSearching,
    this.isUpdated,
    this.hotelList,
  });

  HomeState.init()
      : this(
          error: null,
          attractionList: null,
    hotelList: null,
          attractionListTwo: null,
          searchList: null,
          isSearching: false,
    isUpdated: false,
          page: null,
          limit: null,
    moreSearching: null,
        );

  HomeState clone({
    String error,
    Attraction attractionList,
    Attraction searchList,
    HotelModel hotelList,
    List attractionListTwo,
    bool isSearching,
    bool moreSearching,
    bool isUpdated,
    int page,
    int limit,
  }) {
    return HomeState(
      error: error ?? this.error,
      hotelList: hotelList ?? this.hotelList,
      attractionList: attractionList ?? this.attractionList,
      searchList: searchList ?? this.searchList,
      attractionListTwo: attractionListTwo ?? this.attractionListTwo,
      isSearching: isSearching ?? this.isSearching,
      limit: limit ?? this.limit,
      page: page ?? this.page,
      isUpdated: isUpdated ?? this.isUpdated,
      moreSearching: moreSearching ?? this.moreSearching,
    );
  }

  static HomeState get initialState => HomeState(
        error: null,
        attractionList: Attraction(posts: []),
        searchList: Attraction(posts: []),
        hotelList: HotelModel(hotels: []),
        attractionListTwo: null,
        isSearching: false,
        isUpdated: false,
        page: 1,
        limit: 10,
        moreSearching: false,
  );
}
