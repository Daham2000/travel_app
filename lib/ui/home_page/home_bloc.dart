/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/db/api/attraction_api.dart';
import 'package:travel_app/db/api/hotel_api.dart';
import 'package:travel_app/db/model/attraction.dart';
import 'package:travel_app/db/model/hotel.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(BuildContext context) : super(HomeState.initialState) {
    add(GetDataAttractionEvent());
    getHotelList("2");
  }

  void searchAttraction(String query) async {
    add(LoadingEvent(true));
    Attraction attractionModel = await
    AttractionApi().getAll(1, query, 10);
    if (attractionModel == null) {
      print('Unable to retrieve data (Searching)');
    } else {
      add(SearchDocument(attractionModel));
    }
    add(LoadingEvent(false));
  }

  void getHotelList(String query) async {
    add(LoadingEvent(true));
    HotelModel hotelModel = await HotelApi().getAll(1, query, 2);
    if (hotelModel == null) {
      print('Unable to retrieve data (Searching)');
    } else {
      add(GetHotelList(hotelModel));
    }
    add(LoadingEvent(false));
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    switch (event.runtimeType) {
      case GetDataAttractionEvent:
        List<Post> postList = state.attractionList.posts;
        Attraction resultant = state.attractionList;
        yield state.clone(isSearching:true);
        Attraction attractionModel = await
          AttractionApi().getAll(state.page, "", state.limit);
        if(attractionModel.totalItems>state.attractionList.posts.length){
          for (final post in attractionModel.posts){
            postList.add(post);
          }
        }
        resultant.posts = postList;
        if(attractionModel.posts.length<state.limit){
          yield state.clone(moreSearching: false,attractionList: resultant,isUpdated:true);
        }else{
          yield state.clone(moreSearching: true,attractionList: resultant,
              page: state.page+1,isUpdated:true);
        }
        yield state.clone(isUpdated:false,isSearching:false);
        break;

      case SearchDocument:
        final data = event as SearchDocument;
        yield state.clone(searchList: data.searchingList);
        break;

      case GetHotelList:
        final data = event as GetHotelList;
        yield state.clone(hotelList: data.hotelModel);
        break;

      case LoadingEvent:
        final data = event as LoadingEvent;
        yield state.clone(isSearching: data.isSearching);
        break;

      case ClearSearchResult:
        yield state.clone(searchList: Attraction(posts: []));
        break;
    }
  }
}
