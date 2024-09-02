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

  void getAllAttractions() async {
    emit(state.copyWith(isSearching: true));
    AttractionRepo attractionRepo = AttractionRepo();
    final list = await attractionRepo.getALl();
    emit(state.copyWith(attractionList: list));
    emit(state.copyWith(isSearching: false));
  }

  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    emit(state.copyWith(version: packageInfo.version));
  }
}
