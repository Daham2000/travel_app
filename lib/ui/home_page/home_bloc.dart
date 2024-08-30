/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/db/repository/attraction_repo.dart';

import 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeState.initialState);

  void getAllAttractions() async {
    emit(state.copyWith(isSearching: true));
    AttractionRepo attractionRepo = AttractionRepo();
    final list = await attractionRepo.getALl();
    print(list.length);
    emit(state.copyWith(attractionList: list));
    emit(state.copyWith(isSearching: false));
  }
}
