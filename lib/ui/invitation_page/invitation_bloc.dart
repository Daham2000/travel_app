import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/db/model/trip.dart';
import 'package:travel_app/db/repository/trip_repo.dart';
import 'package:travel_app/db/repository/user_repo.dart';
import 'package:travel_app/ui/invitation_page/invitation_state.dart';

class InvitationBloc extends Cubit<InvitationState> {
  InvitationBloc() : super(InvitationState.initialState);
  TripRepository tripRepository = TripRepository();

  void updateLoadingState(bool isLoading) {
    emit(state.clone(isSearching: isLoading));
  }

  Future<void> getAllTripInvitationPlans() async {
    updateLoadingState(true);
    final email = FirebaseAuth.instance.currentUser?.email;
    final UserRepository userRepository = UserRepository();
    final userByEmail = await userRepository.getUserByEmail(email ?? "");
    final trips = state.invitationTripPlans;
    // List<Trip> trips = [];
    for (var invitation in userByEmail.invitations) {
      final Trip? trip = await tripRepository.getTripById(invitation.email);
      if (trip != null) {
        trips.add(trip);
      }
      // Optional: you can emit here if you want partial updates for each trip.
      emit(state.clone(invitationTripPlans: trips));
    }
    // Emit final state after processing all invitations.
    emit(state.clone(invitationTripPlans: trips, isSearching: false));
  }
}
