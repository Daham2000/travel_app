import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:travel_app/db/model/attraction.dart';
import 'package:travel_app/db/model/trip.dart';
import 'package:travel_app/db/model/user.dart';
import 'package:travel_app/db/repository/trip_repo.dart';
import 'package:travel_app/ui/home_page/widget/drawer.dart';
import 'package:travel_app/ui/trip_view/trip_bloc.dart';
import 'package:travel_app/ui/trip_view/trip_state.dart';
import 'package:travel_app/ui/trip_view/widgets/destination_view.dart';
import 'package:travel_app/utill/image_assets.dart';
import 'package:travel_app/utill/styled_colors.dart';

class TripView extends StatefulWidget {
  const TripView({super.key});

  @override
  State<TripView> createState() => _TripViewState();
}

class _TripViewState extends State<TripView> with RestorationMixin {
  @override
  void initState() {
    super.initState();
    context.read<TripBloc>().setUserDetails();
    context.read<TripBloc>().getAppVersion();
    context.read<TripBloc>().loadAll();
  }

  String? get restorationId => "Main";

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectStartDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  late final RestorableRouteFuture<DateTime?>
      _restorableEndDatePickerRouteFuture = RestorableRouteFuture<DateTime?>(
    onComplete: _selectEndDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(DateTime.now().year),
          lastDate: DateTime(DateTime.now().year + 2),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
    registerForRestoration(
        _restorableEndDatePickerRouteFuture, 'end_date_picker_route_future');
  }

  void _selectStartDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      context.read<TripBloc>().updateTripStartDateLocal(newSelectedDate);
    }
  }

  void _selectEndDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      context.read<TripBloc>().updateTripEndDateLocal(newSelectedDate);
    }
  }

  String getDateString(DateTime timeDate) {
    return timeDate.year.toString() +
        "/" +
        timeDate.month.toString() +
        "/" +
        timeDate.day.toString();
  }

  Future<void> _showMyDialog(Trip tripData) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext contextNew) {
        return AlertDialog(
          title: const Text('Enter Trip Name'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  onChanged: (e) {
                    tripData.name = e;
                    context.read<TripBloc>().updateTripDateName(tripData);
                  },
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                Navigator.of(contextNew).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showAccoumadationSelect(AttractionTripModel attraction) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext contextNew) {
        return AlertDialog(
          title: const Text(
            'Have you booked the Accommodations for this destination?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ToggleSwitch(
                        initialLabelIndex: 0,
                        totalSwitches: 2,
                        labels: [
                          'Yes',
                          'No',
                        ],
                        onToggle: (index) {
                          context.read<TripBloc>().updateAccommodationsSelect(
                              index ?? 1, attraction);
                          Navigator.of(contextNew).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(contextNew).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDialogSelectDestinations(List<Attraction> list) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext contextNew) {
        return AlertDialog(
          title: const Text('Select Destinations'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                for (final ii in list)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () => {
                              context
                                  .read<TripBloc>()
                                  .updateTripDestinations(ii),
                              Navigator.of(contextNew).pop()
                            },
                        child: Text(
                          ii.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        )),
                  )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                Navigator.of(contextNew).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void updateTrip(AttractionTripModel model) {
    context.read<TripBloc>().removeFromDestinations(model);
  }

  bool checkDate(DateTime date) {
    if (date.isBefore(DateTime.now())) {
      return true;
    } else {
      return false;
    }
  }

  void addTrip(Trip currentTrip) async {
    if (currentTrip.name == "") {
      toastification.show(
        context: context,
        type: ToastificationType.error,
        title: Text('Please enter trip name.'),
        autoCloseDuration: const Duration(seconds: 5),
      );
    } else {
      context.read<TripBloc>().updateLoadingState(true);
      TripRepository repository = TripRepository();
      final bool result = await repository.addTripPlan(currentTrip);
      if (result) {
        toastification.show(
          context: context,
          type: ToastificationType.success,
          title: Text('Trip Plan added successful.'),
          autoCloseDuration: const Duration(seconds: 5),
        );
      } else {
        toastification.show(
          context: context,
          type: ToastificationType.error,
          title: Text('Error adding Trip Plan.'),
          autoCloseDuration: const Duration(seconds: 5),
        );
      }
      context.read<TripBloc>().updateLoadingState(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripBloc, TripState>(buildWhen: (previous, current) {
      return previous.isSearching != current.isSearching ||
          previous.user != current.user ||
          previous.list != current.list ||
          previous.currentTrip.attractionList.length !=
              current.currentTrip.attractionList.length ||
          previous.currentTrip != current.currentTrip;
    }, builder: (context, state) {
      print("previous.currentTrip: " + state.currentTrip.startDate.toString());
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100.0,
          flexibleSpace: Image(
            image: AssetImage(ImageAssets.background),
            fit: BoxFit.cover,
          ),
          title: Text(
            "Create A Trip Plan",
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
        drawer: DrawerHome(
          version: state.version ?? "",
          user: state.user ?? User(email: "", firstName: "", lastName: ""),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => {_showMyDialog(state.currentTrip)},
                    child: Text(
                      "Trip Name: " +
                          (state.currentTrip.name == ""
                              ? "Enter trip name"
                              : state.currentTrip.name),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              Divider(),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text("Start Date: " +
                      getDateString(state.currentTrip.startDate)),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      _restorableDatePickerRouteFuture.present();
                    },
                    child: Icon(Icons.date_range),
                  )
                ],
              ),
              Divider(),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text("End Date: " + getDateString(state.currentTrip.endDate)),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      _restorableEndDatePickerRouteFuture.present();
                    },
                    child: Icon(Icons.date_range),
                  )
                ],
              ),
              Divider(),
              SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Selected Destinations",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                  ),
                  Divider(),
                  for (final (index, item)
                      in state.currentTrip.attractionList.indexed)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DestinationView(
                        attraction: item,
                        count: index + 1,
                        openDialogBox: showAccoumadationSelect,
                        updateTrp: updateTrip,
                      ),
                    )
                ],
              ),
              Divider(),
              SizedBox(
                height: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        elevation: 1.0,
                      ),
                      onPressed: () => {
                            if (state.list.length > 0)
                              {_showDialogSelectDestinations(state.list)}
                          },
                      child: SizedBox(
                        width: 150,
                        child: Text(
                          "Add More Destination",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Status: " +
                        (checkDate(state.currentTrip.endDate)
                            ? "Done"
                            : "Pending"),
                    style: TextStyle(
                        color: checkDate(state.currentTrip.endDate)
                            ? Colors.blue
                            : Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: StyledColor.ORDER_STATE_BTN_COLOR,
                        elevation: 1.0,
                      ),
                      onPressed: () => {addTrip(state.currentTrip)},
                      child: SizedBox(
                        width: 150,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: (state.isSearching!)
                              ? Center(
                                  child: SizedBox(
                                      width: 9,
                                      height: 9,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      )))
                              : Text(
                                  "Save",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: StyledColor.ORDER_STATE_BTN_COLOR,
                        elevation: 1.0,
                      ),
                      onPressed: () => {},
                      child: SizedBox(
                        width: 150,
                        child: Text(
                          "Share with Friends",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      );
    });
  }
}
