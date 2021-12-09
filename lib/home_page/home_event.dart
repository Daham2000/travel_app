/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/cupertino.dart';
import 'package:travel_app/db/model/attraction.dart';

@immutable
abstract class HomeEvent {}

class GetDataAttractionEvent extends HomeEvent {
  final List<Attraction> list;

  GetDataAttractionEvent({this.list});
}

class SearchDocument extends HomeEvent {
  final List<Attraction> searchingList;

  SearchDocument(this.searchingList);
}

class LoadingEvent extends HomeEvent {
  final bool isSearching;

  LoadingEvent(this.isSearching);
}

class ClearSearchResult extends HomeEvent{

}
