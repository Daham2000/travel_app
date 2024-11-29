import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/db/repository/trip_repo.dart';
import 'package:travel_app/ui/root_page/root_state.dart';

class RootBloc extends Cubit<RootState> {
  RootBloc() : super(RootState.initialState);
  TripRepository tripRepository = new TripRepository();

  void updateLoadingState(bool isLoading) {
    emit(state.clone(isSearching: isLoading));
  }

  Future<void> loadAllTripPlans() async {
    updateLoadingState(true);
    final list = await tripRepository.getAllTripPlans();
    emit(state.clone(tripList: list, isSearching: false));
  }
}
