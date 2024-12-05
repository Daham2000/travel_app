
import 'package:flutter/cupertino.dart';
import 'package:travel_app/db/model/trip.dart';

@immutable
class InvitationState {
  final bool? isSearching;
  final List<Trip> invitationTripPlans;

  InvitationState({
    required this.isSearching,
    required this.invitationTripPlans,
  });

  InvitationState.init()
      : this(
    isSearching: false,
    invitationTripPlans: [],
  );

  InvitationState clone({
    bool? isSearching,
    List<Trip>? invitationTripPlans,
  }) {
    return InvitationState(
      isSearching: isSearching ?? this.isSearching,
      invitationTripPlans: invitationTripPlans ?? this.invitationTripPlans,
    );
  }

  static InvitationState get initialState => InvitationState(
    isSearching: false,
    invitationTripPlans: [],
  );

}