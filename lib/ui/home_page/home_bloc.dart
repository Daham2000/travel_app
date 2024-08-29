/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/db/api/attraction_api.dart';
import 'package:travel_app/db/model/attraction.dart';

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
  //
  // void getHotelList() async {
  //   add(LoadingEvent(true));
  //   add(GetHotelList([]));
  //   add(LoadingEvent(false));
  // }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    switch (event.runtimeType) {
      case GetDataAttractionEvent:
        break;

      case SearchDocument:
        final data = event as SearchDocument;
        yield state.clone(searchList: data.searchingList);
        break;

      case GetHotelList:
        final data = event as GetHotelList;
        yield state.clone(hotelList: []);
        break;

      case LoadingEvent:
        final data = event as LoadingEvent;
        yield state.clone(isSearching: data.isSearching);
        break;

      case ClearSearchResult:
        yield state.clone(searchList: Attraction(posts: [], totalItems: 0));
        break;
    }
  }
}
