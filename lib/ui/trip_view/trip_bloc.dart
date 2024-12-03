import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:travel_app/db/model/attraction.dart';
import 'package:travel_app/db/model/trip.dart';
import 'package:travel_app/db/repository/attraction_repo.dart';
import 'package:travel_app/db/repository/trip_repo.dart';
import 'package:travel_app/db/repository/user_repo.dart';
import 'package:travel_app/ui/trip_view/trip_state.dart';

class TripBloc extends Cubit<TripState> {
  TripBloc() : super(TripState.initialState);

  void updateLoadingState(bool isLoading) {
    emit(state.clone(isSearching: isLoading));
  }

  void loadAllUsers() async {
    UserRepository userRepository = UserRepository();
    final users = await userRepository.getAllUsers();
    emit(state.clone(users: users));
  }

  void setCurrentTrip(Trip? trip) {
    emit(state.clone(currentTrip: trip ?? state.currentTrip));
  }

  Future<void> updateTripPlan(Trip trip) async {
    emit(state.clone(isSearching: true));
    TripRepository repository = TripRepository();
    final bool result = await repository.addTripPlan(state.currentTrip);
    emit(state.clone(
        isSearching: false,
        error: !result ? "Trip plan added unsuccessful." : ""));
  }

  void setUserDetails() async {
    final email = FirebaseAuth.instance.currentUser?.email;
    final UserRepository userRepository = UserRepository();
    final userByEmail = await userRepository.getUserByEmail(email ?? "");
    emit(state.clone(user: userByEmail));
  }

  void loadAll() async {
    AttractionRepo attractionRepo = AttractionRepo();
    final list = await attractionRepo.getALlWithoutPagination();
    emit(state.clone(list: list));
  }

  void updateTripStartDateLocal(DateTime dateTime) async {
    updateLoadingState(true);
    final t = state.currentTrip;
    t.startDate = dateTime;
    emit(state.clone(currentTrip: t));
    updateLoadingState(false);
  }

  void updateTripEndDateLocal(DateTime dateTime) async {
    updateLoadingState(true);
    final t = state.currentTrip;
    t.endDate = dateTime;
    emit(state.clone(currentTrip: t));
    updateLoadingState(false);
  }

  void updateTripDestinations(Attraction attraction) async {
    updateLoadingState(true);
    final t = state.currentTrip;
    var contain =
        t.attractionList.where((tt) => tt.id == attraction.title).toList();
    if (contain.length == 0) {
      t.attractionList.add(
          AttractionTripModel(id: attraction.title ?? "", isRoomBooked: false));
    } else {
      contain =
          t.attractionList.where((tt) => tt.id != attraction.title).toList();
      t.attractionList = contain;
    }
    emit(state.clone(currentTrip: t));
    updateLoadingState(false);
  }

  void removeFromDestinations(AttractionTripModel attraction) async {
    updateLoadingState(true);
    final t = state.currentTrip;
    var contain =
        t.attractionList.where((tt) => tt.id != attraction.id).toList();
    t.attractionList = contain;
    emit(state.clone(currentTrip: t));
    updateLoadingState(false);
  }

  void updateTripDateName(Trip trip) async {
    updateLoadingState(true);
    emit(state.clone(currentTrip: trip));
    updateLoadingState(false);
  }

  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    emit(state.clone(version: packageInfo.version));
  }

  void updateAccommodationsSelect(
      int index, AttractionTripModel attraction) async {
    print("index: " + index.toString());
    final t = state.currentTrip;
    attraction.isRoomBooked = index == 0 ? true : false;
    final newList =
        t.attractionList.where((t) => t.id != attraction.id).toList();
    emit(state.clone(isSearching: true));
    newList.add(attraction);
    print("attraction: " + attraction.isRoomBooked.toString());
    t.attractionList = newList;
    emit(state.clone(currentTrip: t, isSearching: false));
  }

  void addTrip() async {
    emit(state.clone(isSearching: true));
    TripRepository repository = TripRepository();
    final bool result = await repository.addTripPlan(state.currentTrip);
    emit(state.clone(
        isSearching: false,
        error: !result ? "Trip plan added unsuccessful." : ""));
  }

  void clearError() async {
    emit(state.clone(isSearching: false, error: ""));
  }
}
