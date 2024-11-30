import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/ui/root_page/root_bloc.dart';
import 'package:travel_app/ui/root_page/root_state.dart';
import 'package:travel_app/ui/trip_view/trip_provider.dart';
import 'package:travel_app/ui/trip_view/widgets/trip_card_view.dart';
import 'package:travel_app/utill/image_assets.dart';
import 'package:travel_app/utill/styled_colors.dart';

class ViewAllTripPlan extends StatefulWidget {
  const ViewAllTripPlan({super.key});

  @override
  State<ViewAllTripPlan> createState() => _ViewAllTripPlanState();
}

class _ViewAllTripPlanState extends State<ViewAllTripPlan> {
  @override
  void initState() {
    super.initState();
    context.read<RootBloc>().loadAllTripPlans();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootBloc, RootState>(buildWhen: (previous, current) {
      return previous.isSearching != current.isSearching ||
          previous.tripList != current.tripList;
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100.0,
          flexibleSpace: Image(
            image: AssetImage(ImageAssets.background),
            fit: BoxFit.cover,
          ),
          title: const Text(
            "Trip Plans",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Image.asset(
                  ImageAssets.secondLogoPath,
                  width: 150,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Upcoming Trips",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 15,
              ),
              for (final t in state.tripList ?? [])
                InkWell(
                  onTap: () => {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return TripProvider(
                        isEdit: true,
                        trip: t,
                      );
                    }))
                  },
                  child: TripCardView(
                    trip: t,
                  ),
                ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: StyledColor.ORDER_STATE_BTN_COLOR,
                    elevation: 1.0,
                  ),
                  onPressed: () => {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return TripProvider(
                            isEdit: false,
                          );
                        }))
                      },
                  child: const SizedBox(
                    width: 150,
                    child: Text(
                      "Create a New Trip Plan",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      );
    });
  }
}
