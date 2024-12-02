/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/cupertino.dart';
import 'package:travel_app/db/model/trip.dart';
import 'package:travel_app/db/model/user.dart';

@immutable
class RootState {
  final bool? isSearching;
  final List<Trip>? tripList;
  final String version;
  final User? user;

  RootState({
    required this.isSearching,
    required this.tripList,
    required this.version,
    required this.user,
  });

  RootState.init()
      : this(isSearching: false, tripList: [], version: "", user: null);

  RootState clone({
    bool? isSearching,
    String? version,
    List<Trip>? tripList,
    User? user,
  }) {
    return RootState(
      isSearching: isSearching ?? this.isSearching,
      tripList: tripList ?? this.tripList,
      version: version ?? this.version,
      user: user ?? this.user,
    );
  }

  static RootState get initialState =>
      RootState(isSearching: false, tripList: [], version: "", user: null);
}
