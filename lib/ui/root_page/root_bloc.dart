import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:travel_app/db/repository/trip_repo.dart';
import 'package:travel_app/db/repository/user_repo.dart';
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

  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    emit(state.clone(version: packageInfo.version));
  }

  void setUserDetails() async {
    final email = FirebaseAuth.instance.currentUser?.email;
    final UserRepository userRepository = UserRepository();
    final userByEmail = await userRepository.getUserByEmail(email ?? "");
    emit(state.clone(user: userByEmail));
  }
}
