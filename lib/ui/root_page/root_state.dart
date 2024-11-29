/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/cupertino.dart';
import 'package:travel_app/db/model/trip.dart';

@immutable
class RootState {
  final bool? isSearching;
  final List<Trip>? tripList;

  RootState({
    required this.isSearching,
    required this.tripList,
  });

  RootState.init()
      : this(
          isSearching: false,
          tripList: [],
        );

  RootState clone({
    bool? isSearching,
    List<Trip>? tripList,
  }) {
    return RootState(
      isSearching: isSearching ?? this.isSearching,
      tripList: tripList ?? this.tripList,
    );
  }

  static RootState get initialState => RootState(
        isSearching: false,
        tripList: [],
      );
}
