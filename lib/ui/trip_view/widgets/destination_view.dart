import 'package:flutter/material.dart';
import 'package:travel_app/db/model/trip.dart';

class DestinationView extends StatelessWidget {
  final AttractionTripModel attraction;
  final int count;
  final updateTrp;
  final openDialogBox;

  const DestinationView(
      {super.key,
      required this.attraction,
      required this.count,
      this.updateTrp,
      this.openDialogBox});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(count.toString() + ". " + attraction.id),
          InkWell(
            onTap: () => {openDialogBox(attraction)},
            child: Text("Accommodation booked: " +
                (attraction.isRoomBooked ? "Yes" : "No")),
          ),
          InkWell(
            onTap: () => {updateTrp(attraction)},
            child: Icon(
              Icons.close,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
