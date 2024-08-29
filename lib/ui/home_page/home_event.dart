/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/cupertino.dart';
import 'package:travel_app/db/model/attraction.dart';
import 'package:travel_app/db/model/hotel.dart';

@immutable
abstract class HomeEvent {}

class GetDataAttractionEvent extends HomeEvent {
  final List<Attraction> list;

  GetDataAttractionEvent({required this.list});
}

class SearchDocument extends HomeEvent {
  final Attraction searchingList;

  SearchDocument(this.searchingList);
}

class GetHotelList extends HomeEvent {}

class LoadingEvent extends HomeEvent {
  final bool isSearching;

  LoadingEvent(this.isSearching);
}

class ClearSearchResult extends HomeEvent {}
