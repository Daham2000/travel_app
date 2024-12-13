import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/db/model/user.dart';
import 'package:travel_app/db/repository/trip_repo.dart';
import 'package:travel_app/db/repository/user_repo.dart';
import 'package:travel_app/ui/home_page/widget/drawer.dart';
import 'package:travel_app/ui/invitation_page/invitation_bloc.dart';
import 'package:travel_app/ui/invitation_page/invitation_state.dart';
import 'package:travel_app/ui/invitation_page/widgets/trip_invitation_card.dart';
import 'package:travel_app/ui/root_page/root_bloc.dart';
import 'package:travel_app/ui/root_page/root_state.dart';
import 'package:travel_app/utill/image_assets.dart';
import 'package:travel_app/utill/route_strings.dart';

class InvitationView extends StatefulWidget {
  const InvitationView({super.key});

  @override
  State<InvitationView> createState() => _InvitationViewState();
}

class _InvitationViewState extends State<InvitationView> {
  UserRepository userRepository = UserRepository();

  @override
  void initState() {
    context.read<InvitationBloc>().getAllTripInvitationPlans();
    super.initState();
  }

  Future<void> getTripDataById(String id) async {
    try {
      TripRepository tripRepository = new TripRepository();
      final u = await tripRepository.getTripById(id);
    } catch (e) {}
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  void _showInvitationDialog(
      BuildContext context, String userID, String tripId) {
    showDialog(
      context: context,
      builder: (contextNew) {
        return AlertDialog(
          title: const Text("Invitation"),
          content: const Text("Do you want to accept this invitation?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(contextNew).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                // Handle the "Accept" logic here
                await userRepository.acceptInvitation(userID, tripId);
                Navigator.of(contextNew).pop();
                context.read<InvitationBloc>().getAllTripInvitationPlans();
                // Close the dialog
              },
              child: const Text("Accept"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootBloc, RootState>(buildWhen: (previous, current) {
      return previous.isSearching != current.isSearching ||
          previous.user != current.user ||
          previous.tripList != current.tripList;
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          flexibleSpace: Image(
            image: AssetImage(ImageAssets.background),
            fit: BoxFit.cover,
          ),
          title: const Text(
            "My Invitations",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        drawer: DrawerHome(
          version: state.version ?? "",
          currentPage: RouteStrings.invitation,
          user: state.user ??
              User(
                email: "",
                firstName: "",
                lastName: "",
                id: '',
                invitations: [],
              ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Here are the list of Trip Invitations form your Friends.",
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 15,
              ),
              BlocBuilder<InvitationBloc, InvitationState>(
                buildWhen: (previous, current) {
                  return previous.isSearching != current.isSearching ||
                      current.invitationTripPlans.length !=
                          previous.invitationTripPlans.length;
                },
                builder:
                    (BuildContext context, InvitationState stateInvitation) {
                  return Column(
                    children: [
                      for (final Invitation t in state.user?.invitations ?? [])
                        stateInvitation.invitationTripPlans
                                .where((tt) => tt.id == t.email)
                                .isNotEmpty
                            ? InkWell(
                                onTap: () => {
                                      if (!t.accepted)
                                        _showInvitationDialog(context,
                                            state.user?.id ?? "", t.email)
                                    },
                                child: TripInvitationCard(
                                  tripName: _capitalizeFirstLetter(
                                      stateInvitation.invitationTripPlans
                                          .where((tt) => tt.id == t.email)
                                          .first
                                          .name),
                                  numberOfUsers: stateInvitation
                                      .invitationTripPlans
                                      .where((tt) => tt.id == t.email)
                                      .first
                                      .users
                                      .length,
                                  numberOfPlaces: stateInvitation
                                      .invitationTripPlans
                                      .where((tt) => tt.id == t.email)
                                      .first
                                      .attractionList
                                      .length,
                                  isAccepted: t.accepted,
                                ))
                            : Container(),
                      stateInvitation.isSearching == true
                          ? Center(child: CircularProgressIndicator())
                          : Container()
                    ],
                  );
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
