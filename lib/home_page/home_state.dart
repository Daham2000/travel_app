/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:travel_app/db/model/attraction.dart';

@immutable
class HomeState {
  final String error;
  final List<Attraction> attractionList;
  final List<Attraction> searchList;
  final List attractionListTwo;
  final bool isSearching;
  final DocumentSnapshot documentSnapshot;

  HomeState({
    this.error,
    this.attractionList,
    this.attractionListTwo,
    this.searchList,
    this.isSearching,
    this.documentSnapshot,
  });

  HomeState.init()
      : this(
          error: null,
          attractionList: null,
          attractionListTwo: null,
          searchList: null,
          isSearching: null,
          documentSnapshot: null,
        );

  HomeState clone({
    String error,
    DocumentSnapshot documentSnapshot,
    List<Attraction> attractionList,
    List<Attraction> searchList,
    List attractionListTwo,
    bool isSearching,
  }) {
    return HomeState(
      error: error ?? this.error,
      attractionList: attractionList ?? this.attractionList,
      searchList: searchList ?? this.searchList,
      attractionListTwo: attractionListTwo ?? this.attractionListTwo,
      isSearching: isSearching ?? this.isSearching,
      documentSnapshot: documentSnapshot ?? this.documentSnapshot,
    );
  }

  static HomeState get initialState => HomeState(
        error: null,
        attractionList: [],
        searchList: [],
        documentSnapshot: null,
        attractionListTwo: null,
        isSearching: false,
      );
}
