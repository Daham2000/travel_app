/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:travel_app/db/repository/attraction_repo.dart';

import 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeState.initialState);
  AttractionRepo attractionRepo = AttractionRepo();

  void getAllAttractions() async {
    emit(state.copyWith(isSearching: true));
    AttractionRepo attractionRepo = AttractionRepo();
    final list = await attractionRepo.getALl();
    // attractionRepo.addAll();
    emit(state.copyWith(attractionList: list));
    emit(state.copyWith(isSearching: false));
  }

  void runLoader(bool isLoading) async {
    emit(state.copyWith(isSearching: isLoading));
  }

  void getAllAttractionsByName(String value) async {
    emit(state.copyWith(isSearching: true));
    var list = [];
    if (value.length > 0) {
      list = await attractionRepo.getALlByName(value);
    } else {
      list = await attractionRepo.getALl();
    }
    emit(state.copyWith(attractionList: list));
    emit(state.copyWith(isSearching: false));
  }

  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    emit(state.copyWith(version: packageInfo.version));
  }

  void getAttractionsWithPagination() async {
    emit(state.copyWith(isSearching: true));
    final list = await attractionRepo.loadWithPagination(
        state.attractionList?[state.attractionList!.length - 1]);
    final stateList = state.attractionList;
    stateList?.addAll(list);
    emit(state.copyWith(attractionList: stateList, isSearching: false));
  }
}
