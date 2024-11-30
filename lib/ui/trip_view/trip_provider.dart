import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/db/model/trip.dart';
import 'package:travel_app/ui/login_page/login_bloc.dart';
import 'package:travel_app/ui/login_page/login_view.dart';
import 'package:travel_app/ui/trip_view/trip_bloc.dart';
import 'package:travel_app/ui/trip_view/trip_view.dart';

class TripProvider extends BlocProvider<TripBloc> {
  TripProvider({Key? key, required bool isEdit, Trip? trip})
      : super(
          key: key,
          create: (context) => TripBloc(),
          child: TripView(
            isEdit: isEdit,
            trip: trip,
          ),
        );
}
