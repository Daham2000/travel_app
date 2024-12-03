/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/cupertino.dart';
import 'package:travel_app/db/model/attraction.dart';
import 'package:travel_app/db/model/trip.dart';
import 'package:travel_app/db/model/user.dart';

@immutable
class TripState {
  final bool? isSearching;
  final User? user;
  final String? version;
  final Trip currentTrip;
  final String error;
  final List<Attraction> list;
  final List<User> users;

  TripState({
    required this.isSearching,
    required this.user,
    required this.version,
    required this.currentTrip,
    required this.list,
    required this.error,
    required this.users,
  });

  TripState.init()
      : this(
          isSearching: false,
          user: null,
          version: null,
          error: "",
          list: [],
          users: [],
          currentTrip: Trip(
              name: "",
              id: "",
              startDate: DateTime.now(),
              endDate: DateTime.now(),
              attractionList: [],
              users: []),
        );

  TripState clone({
    bool? isSearching,
    User? user,
    String? version,
    String? error,
    Trip? currentTrip,
    List<Attraction>? list,
    List<User>? users,
  }) {
    return TripState(
      isSearching: isSearching ?? this.isSearching,
      user: user ?? this.user,
      error: error ?? this.error,
      version: version ?? this.version,
      currentTrip: currentTrip ?? this.currentTrip,
      list: list ?? this.list,
      users: users ?? this.users,
    );
  }

  static TripState get initialState => TripState(
        isSearching: false,
        user: null,
        version: "",
        error: "",
        list: [],
        users: [],
        currentTrip: Trip(
            name: "",
            id: "",
            startDate: DateTime.now(),
            endDate: DateTime.now(),
            attractionList: [],
            users: []),
      );
}
