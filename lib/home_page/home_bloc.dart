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
    add(GetDataAttractionEvent());
  }

  void searchAttraction(String query) async {
    List<Attraction> resultant = [];
    add(LoadingEvent(true));
    resultant = await AttractionApi().searchAttraction(query);
    if (resultant == null) {
      print('Unable to retrieve data (Searching)');
    } else {
      add(SearchDocument(resultant));
    }
    add(LoadingEvent(false));
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    switch (event.runtimeType) {
      case GetDataAttractionEvent:
        List<Attraction> resultant = state.attractionList;
        AttractionModel attractionModel = await AttractionApi().getUsersList(
          list: state.attractionList,
          documentSnapshot: state.documentSnapshot,
        );
        if (state.attractionList.isNotEmpty) {
          for (final i in attractionModel.list) {
            resultant.add(i);
          }
        } else {
          resultant = attractionModel.list;
        }
        if (resultant == null) {
          print('Unable to retrieve data');
        } else {
          yield state.clone(
            attractionList: resultant,
            documentSnapshot: attractionModel.documentSnapshot,
          );
        }
        break;

      case SearchDocument:
        final data = event as SearchDocument;
        yield state.clone(searchList: data.searchingList);
        break;

      case LoadingEvent:
        final data = event as LoadingEvent;
        yield state.clone(isSearching: data.isSearching);
        break;

      case ClearSearchResult:
        yield state.clone(searchList: []);
        break;
    }
  }
}
