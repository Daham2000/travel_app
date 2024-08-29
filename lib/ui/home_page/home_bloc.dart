/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(BuildContext context) : super(HomeState.initialState) {
    on<GetHotelList>((event, emit) async {
      state.clone(attractionList: []);
    });
    on<LoadingEvent>((event, emit) async {
      state.clone(isSearching: event.isSearching);
    });
  }

  void searchAttraction(String query) async {
    add(LoadingEvent(true));

    add(LoadingEvent(false));
  }
}
